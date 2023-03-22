HOME="$1"
DISCORD_CONFIG_PATH="$HOME/.config/discord/settings.json"

JQ_RESPONSE="$(jq -e "." "$DISCORD_CONFIG_PATH" 2>/dev/null)"
JQ_RETURN_CODE="$?"
# IF the file IS INVALID, MISSING, OR EMPTY, set ORIGINAL_JSON to {}, otherwise set to the CONTENTS of DISCORD_CONFIG_PATH
if [ "$JQ_RETURN_CODE" -ne 0 ] || [ -z "$JQ_RESPONSE" ]; then
    ORIGINAL_JSON="{}"
else
    ORIGINAL_JSON="$JQ_RESPONSE"
fi

jq ".SKIP_HOST_UPDATE=true" <<< "$ORIGINAL_JSON" > "$DISCORD_CONFIG_PATH"