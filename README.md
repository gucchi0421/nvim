# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

Neovim
```
sudo apt update
sudo apt install -y wget gpg
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
tar -xzf nvim-linux64.tar.gz
ls nvim-linux64
sudo ln -sf $(pwd)/nvim-linux64/bin/nvim /usr/bin/nvim
nvim --version
```

alias
```
nvim ~/.bashrc
# alias n="nvim"
# :wq
source ~/.bashrc
```

Fzf
```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
fzf --version
```

Lazy
```
git clone --depth=1 https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/lazy/lazy.nvim
```

Font
```md
HackGen_NF_v2.9.1をマシンにインストール後、terminalで設定
```


lazygit
```
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/

# n ~/.config/lazygit/config.yml
```
