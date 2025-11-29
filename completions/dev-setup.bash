# Bash completion for dev-setup CLI
# Source this file or add to ~/.bashrc:
# source /path/to/dev-setup/completions/dev-setup.bash

_dev_setup_completion() {
    local cur prev commands config_cmds
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    
    # Main commands
    commands="install update select check list config doctor clean uninstall version help"
    
    # Config subcommands
    config_cmds="show edit reset"
    
    # Install options
    install_opts="--minimal --standard --full --dry-run --use-config"
    
    # Select presets
    select_presets="--minimal --developer --full --show"
    
    # Complete main command
    if [ $COMP_CWORD -eq 1 ]; then
        COMPREPLY=( $(compgen -W "${commands}" -- ${cur}) )
        return 0
    fi
    
    # Complete based on previous command
    case "${prev}" in
        config)
            COMPREPLY=( $(compgen -W "${config_cmds}" -- ${cur}) )
            return 0
            ;;
        install)
            COMPREPLY=( $(compgen -W "${install_opts}" -- ${cur}) )
            return 0
            ;;
        select)
            COMPREPLY=( $(compgen -W "${select_presets}" -- ${cur}) )
            return 0
            ;;
        *)
            ;;
    esac
    
    return 0
}

complete -F _dev_setup_completion dev-setup

