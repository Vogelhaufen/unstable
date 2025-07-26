# REG Key to enable NGX
echo "============= Setting Registry Keys =============="
WINE_BIN="/home/hans/Games/star-citizen/runners/wine_runner/bin/wine"
REG_PATH="HKLM\\Software\\NVIDIA Corporation\\Global\\NGXCore"
VALUE_NAME="FullPath"
EXPECTED_VALUE_SET="C:\\Windows\\System32"
EXPECTED_VALUE_CHECK="C:\Windows\System32"

REG_QUERY_OUTPUT=$("$WINE_BIN" reg query "$REG_PATH" /v "$VALUE_NAME" 2>/dev/null)

CURRENT_VALUE=$(echo "$REG_QUERY_OUTPUT" \
  | grep "$VALUE_NAME" \
  | tr -s ' ' \
  | cut -d ' ' -f4- \
  | sed -e "s/^[[:space:]\'\"]*//" -e "s/[[:space:]\'\"]*$//")

echo "Current registry value: '$CURRENT_VALUE'"

if [ "$CURRENT_VALUE" = "$EXPECTED_VALUE_CHECK" ]; then
    echo "Registry key already set. Skipping."
else
    echo "Setting registry key..."
    "$WINE_BIN" reg add "$REG_PATH" /v "$VALUE_NAME" /t REG_SZ /d "$EXPECTED_VALUE_SET" /f
fi

# END REG Key to enable NGX

# Wait for previous wine instance to die
sleep 3
