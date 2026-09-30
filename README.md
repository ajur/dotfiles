# For ~/ with ❤

**NOTE:** this repo contains my personal shell config.
It's higly opinionated, sometimes experimental, and usually lacking in refinement etc. It's not created to be universal or anything. Just a bunch of random configs that I currently use, or just sticked to them through the years :)

Also, as for ZSH configs, this time I'm testing [slimzsh](https://github.com/changs/slimzsh) for faster running, ditching [prezto](https://github.com/sorin-ionescu/prezto) that was too big, and packed with features i never used.

### On macOS:

Install [Homebrew](https://brew.sh/)

Optionally install brew zsh as default
```
> brew install zsh zsh-completions
> sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh
```

otherwise it might be needed to add completions to fpath - to do this, add whats below to ~/.zprofile
```
fpath+=("$(brew --prefix)/share/zsh/site-functions")
```

Install some usefull tools, check out [modern unix](https://github.com/ibraheemdev/modern-unix) for more
```
brew install tldr fasd jq fd the_silver_searcher python3 fnm

python3 -m venv ~/.py3
~/.py3/bin/pip install shell-gpt
```

Clone and run install script:
```
> git clone git@github.com:ajur/dotfiles.git ~/.dotfiles
> cd ~/.dotfiles
> ./install.zsh
```

For compaudit issue, run
```
for f in $(compaudit);do sudo chmod -R 755 $f;done;
```

**MS Code**: Search for `shell command` to add/remove `code` command

**Java**: https://sdkman.io/
