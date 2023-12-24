# Vizum
Simple CLI tool that uses Git for a free CDN 

## Installation
Requirements - Git, Bash, Curl
```sh
$ sudo curl https://entrpix.me/install.sh | bash
```

## Common Isuse
I have come across a common issue when setuping up Vizum & Git so I'll leave this guide here:
- `error: failed to push some refs to 'https://github.com/entrpix/vizum-cdn.git'`
  - `git add *File Name Here*`
  - `git commit -m "Commit Message Here"`
  - `git push -u origin main -f`
Should fix any Git issues when initially setting Vizum and Git

## Commands
Run `vizum help`

## TODO
- [X] Help Command
- [X] Add Command
- [X] Remove Command
- [X] Init Command
- [X] Sync Command
- [X] Installation Script
- [ ] Embed Genorator

## My Vizum Repo
If you wanna see the stupid shit I upload check [This](https://github.com/entrpix/vizum-cdn) :3
