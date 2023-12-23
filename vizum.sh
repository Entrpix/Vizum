# Vizum is a simple CLI tool that uses Git for a free CDN (if you host it on a serivce like Github)
# Syntax: vizum.sh <file path> [git repo]

# Help Message
help() {
    echo "vizum.sh init <folder path> <git repo> - Will store files in the provided folder path and push them to the provided Git repo."
    echo "vizum.sh add <file path> - Copy and pastes the provided file path into the Vizum local repo and the external repo."
    echo "vizum.sh remove <file> - Removes the provided file from the Vizum local repo and the external repo."
    echo "vizum.sh sync - Syncs changes made from the external Git repo to the local repo."
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

# Checks if a git repo is initialized
if [ ! -d .git ]; then
    git init
    git add $1
    git commit -m "Vizum :3"
    git branch -M main
    git remote add origin $2
    git push -u origin main
else
    git add $1
    git commit -m "Vizum :3"
    git push -u origin main
fi
