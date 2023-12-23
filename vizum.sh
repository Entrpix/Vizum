# Vizum is a simple CLI tool that uses Git for a free CDN (if you host it on a serivce like Github)

# Configuration
config_dir="/home/$USER/.config/vizum"
config_file="$config_dir/path.cfg"
repo=$(cat "$config_file")

# Help Message
help() {
    echo "vizum.sh init <folder path> <git repo> - Will store files in the provided folder path and push them to the provided Git repo."
    echo "vizum.sh add <file path> (-f) - Copy and pastes the provided file path into the Vizum local repo and the remote repo. (-f will force push)"
    echo "vizum.sh remove <file> - Removes the provided file from the local repo and the remote repo."
    echo "vizum.sh sync - Syncs changes made from the remote Git repo to the local repo."
    echo "vizum.sh help - Displays a help message."
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
    git pull
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

## Add Command
if [ "$1" == "add" ]; then
    cp "$2" "$repo"

    cd "$repo"
    git add "$2"
    git commit -m "Added file $2"

    if [ "$3" == "-f" ]; then
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
        rm -rf "$2"
    else
        echo "File does not exist."
        exit
    fi

    cd "$repo"
    git rm "$2"
    git commit -m "Removed file $2"
    git push origin main
fi
