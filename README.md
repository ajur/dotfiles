# For ~/ with ❤

Clone this repo and run install.zsh

This time I'm testing [slimzsh](https://github.com/changs/slimzsh) for faster running

### On macOS:

- install [Homebrew](https://brew.sh/)
- set brew zsh as default: 
  ```
  brew install zsh zsh-completions fasd
  sudo dscl . -create /Users/$USER UserShell /usr/local/bin/zsh
  ```
- for compaudit issue, run `for f in $(compaudit);do sudo chmod -R 755 $f;done;`
- MS Code: Search for `shell command` to add/remove `code` command
- java: https://github.com/shyiko/jabba
