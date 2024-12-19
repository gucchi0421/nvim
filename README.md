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
sudo ln -sf /usr/local/nvim-linux64/bin/nvim /usr/bin/nvim
nvim --version
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
マシンにインストール後、terminalで設定
```