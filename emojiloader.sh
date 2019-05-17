# last -> final
# lang  -> tongue

oldIFS=${IFS}
IFS=","

declare -A emoji
while IFS=, read -r -a array
do
    # skip empty pairs
    ((${#array[@]} >= 2)) || continue

    # skip empty keys (even if they have value)
    if [ -n "${array[@]:1:1}" ]; then
        # assign associative
        emoji["${array[@]:1:1}"]="${array[@]:0:1}"
    fi
done < filtered.txt
echo "${!emoji[@]}" 
comple(){
    COMPREPLY=( $(compgen -W "${!emoji[@]}" "${COMP_WORDS[$COMP_CWORD]}") )
    if [[ ${#COMPREPLY[@]} -eq 1 ]]; then
        local key=${COMPREPLY[0]}
        local value=${emoji[$key]}
        COMPREPLY=( $value )
    fi
}
complete -F comple emoju
