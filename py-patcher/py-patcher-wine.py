#!/usr/bin/env python3
# stupid approach to patch steamoverlay without recompiling
# just stubs this time

import subprocess
import tempfile
import os

WINE_BINARY = "wine"      # Path to the wine binary you want to patch
OUTPUT_BINARY = "wine.patched"

# Dummy data to hold our fake symbols
DUMMY_DATA = b"\x00" * 16

def patch_wine():
    # Create a temporary dummy data file
    tmpfile = tempfile.NamedTemporaryFile(delete=False)
    tmpfile.write(DUMMY_DATA)
    tmpfile.flush()
    tmpfile.close()

    print("[+] Adding .winehack section with dummy data...")
    subprocess.run([
        "objcopy",
        "--add-section", f".winehack={tmpfile.name}",
        "--set-section-flags", ".winehack=alloc,load,readonly,data",
        "--change-section-lma", ".winehack=0",  # ensures it's mapped in a segment
        WINE_BINARY, OUTPUT_BINARY
    ], check=True)

    print("[+] Adding missing Wine symbols...")
    for sym in ["wine_r_debug", "wine_main_preload_info"]:
        subprocess.run([
            "objcopy",
            "--add-symbol", f"{sym}=.winehack:0,global,object",
            OUTPUT_BINARY
        ], check=True)

    os.unlink(tmpfile.name)
    print(f"[+] Patched Wine binary written to {OUTPUT_BINARY}")


if __name__ == "__main__":
    try:
        patch_wine()
    except subprocess.CalledProcessError as e:
        print(f"[-] ERROR: objcopy failed: {e}")
