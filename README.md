# For ~/ with ❤

**NOTE:** this repo contains my personal shell config.
It's highly opinionated and not created to be universal or anything.
Just a bunch of random configs that I currently use.

Although, recently I've even made a solid rewrite (powered by AI, heh -_-),
and finally got rid of old stuff that was broken or unusable.

I've also removed dependencies on any external ZSH configs, only bringing some parts from
previously used [slimzsh](https://github.com/changs/slimzsh), that I'm actually using.
Before, I've also used [prezto](https://github.com/sorin-ionescu/prezto) but it was waaay
too big for my needs and usage.

So, if in any way someone finds it useful, that's great!
(Although I kinda doubt it, in this era of not sharing, but letting everything be custom built by AI... but that is a rant for another time).

## Installation

### On macOS:

Get [Homebrew](https://brew.sh/) first. It pulls in Xcode Command Line Tools, so `git` is there too.
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Clone and install:
```
git clone https://github.com/ajur/dotfiles.git ~/.dotfiles
~/.dotfiles/install.sh
```

Tools and apps I use are in the `Brewfile` (`dots help` lists them with a short note on what for):
```
brew bundle --file ~/.dotfiles/Brewfile
```

Few things macOS won't let me script:
- Hammerspoon needs Accessibility permission (System Settings → Privacy & Security → Accessibility)
- Ghostty needs a restart after install. It's hidden from Dock and Cmd+Tab, toggle it with Ctrl+§ / Ctrl+\`

Hammerspoon is there only for that Ghostty hotkey window with tabs. Ghostty's own quick terminal can't do tabs (yet), once it can, Hammerspoon can go.

### On Linux / SSH machines:

```
sudo apt install git zsh
chsh -s "$(command -v zsh)"
git clone https://github.com/ajur/dotfiles.git ~/.dotfiles
~/.dotfiles/install.sh
```
fzf, fnm, direnv etc. are optional, they just kick in when installed.

### After install:

Git name and email stay out of the repo, so put them in `~/.gitconfig.local`:
```
[user]
	name = Your Name
	email = you@example.com
```

Anything machine specific goes to `~/.zshrc.local`.

Cloned over https, so to push, switch to ssh:
```
git -C ~/.dotfiles remote set-url origin git@github.com:ajur/dotfiles.git
```

## Usage:

### `dots` tool

Small shell tool to help with keeping up to date, or remembering what I've added here.

- `dots help` - what's available (aliases, functions, keys, scripts)
- `dots update` - update everything (repo, links, zsh plugins, Brewfile, brew)

It also checks for updates once a week in the background, and tells me when there's something new.

To get something into `dots help`, comment it with `##`:
```
## description of the alias/function below
alias x='...'
## [keys] Ctrl-X -- standalone entry, [section] is optional
```

### When needed:

**Node**: [fnm](https://github.com/Schniz/fnm) switches versions from `.nvmrc` on `cd`. Get one with `fnm install --lts`.

**Python**: [uv](https://docs.astral.sh/uv/) (`brew install uv`)
- `uv tool install <tool>` for CLI tools, `uvx <tool>` to just run one
- `uv init`, `uv add <pkg>`, `uv run ...` for projects
- `uv python install --default` for a fresh `python3` (otherwise it's Apple's old one)

**Java**: [SDKMAN!](https://sdkman.io/)
```
curl -s "https://get.sdkman.io?rcupdate=false" | bash
```

**VS Code**: search commands for `shell command` to get `code` in terminal.

**zsh complains about "insecure directories"**: `compaudit | xargs chmod g-w,o-w`
