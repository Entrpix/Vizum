# Vizum
Simple CLI tool that uses Git for a free CDN 

## Commands
- `vizum.sh init <folder path> <git repo>`: Stores files in the provided folder path and pushes them to the provided Git repo.
- `vizum.sh add <file path> (-f)`: Copies and pastes the provided file path into the Vizum local repo and the remote repo. Use `-f` to force push.
- `vizum.sh remove <file>`: Removes the provided file from the local repo and the remote repo.
- `vizum.sh sync`: Syncs changes made from the remote Git repo to the local repo.
- `vizum.sh help`: Displays a help message.

## TODO
- [X] Help Command
- [X] Add Command
- [X] Remove Command
- [X] Init Command
- [X] Sync Command
- [X] Installation Script
- [ ] Embed Genorator

## Installation
Requirements - Git, Bash, Curl
```sh
$ sudo curl https://entrpix.me/install.sh | bash
```

## My Vizum Repo
If you wanna see the stupid shit I upload check [This](https://github.com/entrpix/vizum-cdn) :3
