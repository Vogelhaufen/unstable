#!/bin/bash
set -euo pipefail

# === CONFIGURATION ===
PATCHED_CUDA="$HOME/Games/star-citizen/libcuda.patched.so"
GAME_EXECUTABLE="${1:-}"

if [[ -z "$GAME_EXECUTABLE" ]]; then
  echo "Usage: $0 /path/to/game/binary [args...]"
  exit 1
fi

GAME_EXEC=$(realpath "$GAME_EXECUTABLE")
shift
GAMEDIR=$(dirname "$GAME_EXEC")
WINEPREFIX="${WINEPREFIX:-$HOME/Games/star-citizen}"

# === RUNTIME + DISPLAY DETECTION ===
RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
WAYLAND_SOCKET=""
if [[ -n "${WAYLAND_DISPLAY:-}" && -S "$RUNTIME_DIR/$WAYLAND_DISPLAY" ]]; then
  WAYLAND_SOCKET="$RUNTIME_DIR/$WAYLAND_DISPLAY"
else
  for sock in "$RUNTIME_DIR"/wayland-*; do
    if [[ -S "$sock" ]]; then
      WAYLAND_SOCKET="$sock"
      WAYLAND_DISPLAY="$(basename "$sock")"
      break
    fi
  done
fi

# === CUDA REDIRECTION TARGET ===
if [[ ! -f "$PATCHED_CUDA" ]]; then
  echo "Error: Patched libcuda.so not found at: $PATCHED_CUDA"
  exit 2
fi

# === REQUIRED NVIDIA DEVICES ===
REQUIRED_DEVICES=(
  /dev/nvidia0
  /dev/nvidiactl
  /dev/nvidia-uvm
  /dev/nvidia-uvm-tools
  /dev/nvidia-modeset
  /dev/dri
  /dev/shm
)
for dev in "${REQUIRED_DEVICES[@]}"; do
  [[ -e "$dev" ]] || { echo "Missing NVIDIA device: $dev"; exit 3; }
done

# === BUBBLEWRAP CONFIG ===
BWRAP_ARGS=(
  --ro-bind / /
  --dev /dev
  --proc /proc
  --tmpfs /tmp
  --ro-bind /sys /sys

  # Bind patched CUDA to all detected libcuda.so* files across common dirs
)

cuda_lib_dirs=(
  /usr/lib
  /usr/lib64
  /usr/lib/x86_64-linux-gnu
  /usr/lib/nvidia
  /usr/lib/nvidia-525
  /usr/lib/nvidia-current
  /usr/lib64/nvidia
)

for dir in "${cuda_lib_dirs[@]}"; do
  if [[ -d "$dir" ]]; then
    while IFS= read -r -d '' file; do
      basefile=$(basename "$file")
      if [[ "$basefile" =~ ^libcuda\.so(\.[0-9]+)*$ ]]; then
        echo "Binding patched CUDA as $basefile"
        BWRAP_ARGS+=(--bind "$PATCHED_CUDA" "$file")
      fi
    done < <(find "$dir" -maxdepth 1 \( -type f -o -type l \) -name 'libcuda.so*' ! -name '*.old' ! -name '*.bak' ! -name '*.disabled' -print0)
  fi
done

BWRAP_ARGS+=(
  --bind "$GAMEDIR" "$GAMEDIR"
  --bind "$HOME" "$HOME"

  --dev-bind /dev/nvidia0 /dev/nvidia0
  --dev-bind /dev/nvidiactl /dev/nvidiactl
  --dev-bind /dev/nvidia-uvm /dev/nvidia-uvm
  --dev-bind /dev/nvidia-uvm-tools /dev/nvidia-uvm-tools
  --dev-bind /dev/nvidia-modeset /dev/nvidia-modeset
  --dev-bind /dev/dri /dev/dri
  --dev-bind /dev/shm /dev/shm

  --bind /tmp/.X11-unix /tmp/.X11-unix
  --bind "$RUNTIME_DIR/pipewire-0" "$RUNTIME_DIR/pipewire-0"
)

if [[ -n "$WAYLAND_SOCKET" ]]; then
  BWRAP_ARGS+=(--bind "$WAYLAND_SOCKET" "$WAYLAND_SOCKET")
fi

# Minimal safe environment for EAC
BWRAP_ARGS+=(
  --setenv HOME "$HOME"
  --setenv PATH "$PATH"
  --setenv WINEPREFIX "$WINEPREFIX"
  --setenv DISPLAY "${DISPLAY:-}"
  --setenv WAYLAND_DISPLAY "${WAYLAND_DISPLAY:-}"
  --setenv XDG_RUNTIME_DIR "$RUNTIME_DIR"
)

# === EXECUTION ===
echo ""
echo "Launching Star Citizen inside Bubblewrap..."
echo "Executable: $GAME_EXEC"
echo "Patched CUDA: $PATCHED_CUDA"
echo "Wine Prefix: $WINEPREFIX"
echo "Wayland Socket: $WAYLAND_SOCKET"
echo "--------------------------------------------"
exec bwrap "${BWRAP_ARGS[@]}" "$GAME_EXEC" "$@"
