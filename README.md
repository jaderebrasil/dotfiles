# Jader Personal dotfiles.

## Instalation
Run the following command without root permissions. Of course, git is a requirement.

```
# add this line in your .zshrc/.bashrc
alias dfmconfig='/usr/bin/git --git-dir=$HOME/.local/share/dotfiles --work-tree=$HOME'

# run
curl -Ls "https://gitlab.com/jaderbrasil/dotfiles/-/raw/master/.local/bin/dotfiles/install.sh" | /bin/bash
```

# Requirements
Some software may be necessary for all settings to work well.

For neovim you need
- nodejs
- yarn (yarn global add neovim)
- python3
- pip3 (pip install pynvim)
- xclip
- fzf

For zsh
- oh-my-zsh

## Help

I follow this tutorial for produce [this](https://www.atlassian.com/git/tutorials/dotfiles) storage system.

[Here](https://git-scm.com/docs/gitignore) you can find help about on managing gitignore.
