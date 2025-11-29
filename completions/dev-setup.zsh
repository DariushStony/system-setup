#compdef dev-setup
# Zsh completion for dev-setup CLI
# Add to ~/.zshrc:
# fpath=(/path/to/dev-setup/completions $fpath)
# autoload -U compinit && compinit

_dev_setup() {
    local -a commands config_cmds install_opts select_presets
    
    commands=(
        'install:Install development environment'
        'update:Update all installed packages'
        'select:Choose packages to install'
        'check:Check installation status'
        'list:List available packages'
        'config:Manage configuration'
        'doctor:Check system and dependencies'
        'clean:Clean up temporary files'
        'uninstall:Uninstall dev-setup CLI tool'
        'version:Show version'
        'help:Show help'
    )
    
    config_cmds=(
        'show:Show current configuration'
        'edit:Edit configuration file'
        'reset:Reset all configuration'
    )
    
    install_opts=(
        '--minimal:Install essentials only'
        '--standard:Standard installation'
        '--full:Install everything'
        '--dry-run:Preview without installing'
        '--use-config:Use saved configuration'
    )
    
    select_presets=(
        '--minimal:Essentials only'
        '--developer:Recommended for developers'
        '--full:Everything'
        '--show:Show current selection'
    )
    
    if (( CURRENT == 2 )); then
        _describe 'command' commands
    else
        case "$words[2]" in
            config)
                _describe 'config command' config_cmds
                ;;
            install)
                _describe 'install option' install_opts
                ;;
            select)
                _describe 'select preset' select_presets
                ;;
        esac
    fi
}

_dev_setup "$@"

