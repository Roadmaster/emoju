#
#
# "Globals"
declare -A emojis
declare emoji_shortnames

# Functions
load_emoji(){
    while IFS=, read -r -a temp_array
    do
        # skip empty pairs
        ((${#temp_array[@]} >= 2)) || continue

        # skip empty keys (even if they have value)
        if [ -n "${temp_array[@]:1:1}" ]; then
            # assign associative
            emojis["${temp_array[@]:1:1}"]="${temp_array[@]:0:1}"
        fi
    done < filtered.txt
    emoji_shortnames=$(echo "${!emojis[@]}" )
}

comple(){
    COMPREPLY=( $(compgen -W "$emoji_shortnames" "${COMP_WORDS[$COMP_CWORD]}") )
    # TODO: Also resolve if the top match is identical to current word.
    # This helps resolving word to emoji when there are still more matches but
    # I have what I need.
    if [[ ${#COMPREPLY[@]} -eq 1 ]]; then
        local key=${COMPREPLY[0]}
        local value=${emojis[$key]}
        COMPREPLY=( $value )
    fi
}

# The meat
load_emoji
complete -F comple emoju
