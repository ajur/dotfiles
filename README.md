# For ~/ with ❤

**NOTE:** this repo contains my personal shell config.
It's higly opinionated, sometimes experimental, and usually lacking in refinement etc. It's not created to be universal or anything. Just a bunch of random configs i sticked to through the years :)

Also, as for ZSH configs, this time I'm testing [slimzsh](https://github.com/changs/slimzsh) for faster running, ditching [prezto](https://github.com/sorin-ionescu/prezto) that was too big, and packed with features i never used.

### On macOS:

Install [Homebrew](https://brew.sh/)

Set brew zsh as default (if not used already)
```
> brew install zsh zsh-completions
> sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh
```

Clone and run install script:
```
> git clone git@github.com:ajur/dotfiles.git ~/.dotfiles
> cd ~/.dotfiles
> ./install.zsh
```

Install some usefull tools, check out [modern unix](https://github.com/ibraheemdev/modern-unix) for more
```
brew install tldr fasd jq fd the_silver_searcher nvm
```

For compaudit issue, run
```
for f in $(compaudit);do sudo chmod -R 755 $f;done;
```

**MS Code**: Search for `shell command` to add/remove `code` command

**Java**: https://sdkman.io/
