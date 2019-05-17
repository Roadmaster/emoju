# last -> final
# lang  -> tongue

comple(){
    COMPREPLY=( $(compgen -W "last lang" "${COMP_WORDS[$COMP_CWORD]}") )

    if [[ ${#COMPREPLY[@]} -eq 1 ]]; then
        if [[ ${COMPREPLY[0]} = "last" ]]; then 
            COMPREPLY=( :final: )
        fi
        if [[ ${COMPREPLY[0]} = "lang" ]]; then 
            COMPREPLY=( :tongue: )
        fi
    fi
}
complete -F comple emoju
