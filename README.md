# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

Neovim
```sh
sudo apt update
sudo apt install -y wget gpg
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
tar -xzf nvim-linux64.tar.gz
ls nvim-linux64
sudo ln -sf $(pwd)/nvim-linux64/bin/nvim /usr/bin/nvim
nvim --version
```

alias
```sh
nvim ~/.bashrc
# alias n="nvim"
# :wq
source ~/.bashrc
```

Fzf
```sh
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
fzf --version
```

Lazy
```sh
git clone --depth=1 https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/lazy/lazy.nvim
```

Font
```md
HackGen_NF_v2.9.1をマシンにインストール後、terminalで設定
```