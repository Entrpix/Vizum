#!/bin/bash

# Configuration
config_dir="/home/$USER/.config/vizum"
config_file="$config_dir/path.cfg"

# Help Message
help() {
    echo "Vizum - A simple CLI for Managing Files with Git"
    echo ""
    echo "Usage:"
    echo "  vizum <command> [<args>]"
    echo ""
    echo "Available commands:"
    echo "  init <folder path> <git repo> - Initialize Vizum with a folder path and a Git repo."
    echo "  add <file path> [-mv] [-l|-r] - Add a file to the Vizum local and/or remote repo."
    echo "                                 Use -mv to move instead of copy. Use -l for local only, -r for remote only."
    echo "  remove <file> [-l|-r] - Remove a file from the Vizum local and/or remote repo."
    echo "                          Use -l for local only, -r for remote only."
    echo "  sync [-l|-r] - Sync changes between the local and remote repo."
    echo "                 Use -l to push local changes to remote, -r to pull remote changes to local."
    echo "  help - Display this help message."
    echo ""
    echo "Flags:"
    echo "  -mv - Move a file instead of copying it."
    echo "  -l - Perform action on local repo only."
    echo "  -r - Perform action on remote repo only."
    echo "  -f - Force push to remote repo. Use with caution."
}

# Checks if Git is installed
if ! command -v git &> /dev/null
then
    echo "It appears that Git is not installed."
    exit
fi

# Displays the help message if no args are provided or if the arg help is provided
if [ "$1" == "help" ] || [ $# -lt 1 ]; then
    help
    exit
fi

## Sync Command
if [ "$1" == "sync" ]; then
    cd "$repo"
    if [ "$2" == "-l" ]; then
        git add *
        git commit -m "Sycned all changes from local repo to remote repo."
        git push origin main
    elif [ "$2" == "-r" ]; then
        git pull
    else
        echo "Invalid flag. Use -l to sync local changes to remote or -r to sync remote changes to local."
    fi
    exit
fi

## Init Command
if [ "$1" == "init" ]; then
    if [ ! -d "$2" ]; then
        mkdir "$2"
    fi
    cd "$2"
    git init
    git branch -M main
    git remote add origin $3

    if [ ! -d "$config_dir" ]; then
        mkdir -p "$config_dir"
    fi

    echo "$2" > "$config_file"
fi

repo=$(cat "$config_file")

## Add Command
if [ "$1" == "add" ]; then
    if [ "$3" == "-mv" ]; then
        mv "$2" "$repo"
    else
        cp "$2" "$repo"
    fi

    cd "$repo"

    git add "$2"
    git commit -m "Added file $2"

    if [ "$4" == "-l" ]; then
        echo "Changes made to local repo only."
    elif [ "$4" == "-r" ]; then
        git push -u origin main
    elif [ "$4" == "-f" ]; then
        echo "Are you sure you want to force push, this will overwrite the remote repo? (y/n)"
        read answer
        if [ "$answer" == "y" ]; then
            git push -f -u origin main
        else
            echo "Aborted."
            exit
        fi
    else
        git push -u origin main
    fi
fi

## Remove Command
if [ "$1" == "remove" ]; then
    cd "$repo"
    if [ -f "$2" ]; then
        git rm "$2"
        git commit -m "Removed file $2"

        if [ "$3" == "-l" ]; then
            echo "Changes made to local repo only."
        elif [ "$3" == "-r" ]; then
            if [ "$4" == "-f" ]; then
               echo "Are you sure you want to force push, this will overwrite the remote repo? (y/n)"
                read answer
                if [ "$answer" == "y" ]; then
                    git push -f -u origin main
                else
                    echo "Aborted."
                    exit
                fi
            else
                git push -u origin main
            fi
        else
            git push -u origin main
        fi
    fi
fi
