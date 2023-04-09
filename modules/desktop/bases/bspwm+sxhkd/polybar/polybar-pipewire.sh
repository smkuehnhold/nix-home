# Stolen from:
# https://github.com/jonringer/nixpkgs-config/blob/618496e858af54f1b6deab4747bded0e11c60204/nix/polybar.nix
function main() {
    VOLUME=$(pamixer --get-volume-human)
    case $1 in
        "up")
            pamixer --increase 5
            ;;
        "down")
            pamixer --decrease 5
            ;;
        "mute")
            pamixer --toggle-mute
            ;;
        *)
        echo "${VOLUME}"
    esac
}

main "$@"