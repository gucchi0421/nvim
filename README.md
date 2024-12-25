# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## Neovim
```sh
sudo apt update
sudo apt install -y wget gpg
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
tar -xzf nvim-linux64.tar.gz
ls nvim-linux64
sudo ln -sf $(pwd)/nvim-linux64/bin/nvim /usr/bin/nvim
nvim --version
```

## alias
```sh
nvim ~/.bashrc
# alias n="nvim"
# :wq
source ~/.bashrc
```

## Fzf
```sh
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
fzf --version
```

## Lazy
```sh
git clone --depth=1 https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/lazy/lazy.nvim
```

## Font
- HackGen_NF_v2.9.1をマシンにインストール後、terminalで設定


## Lazygit
```sh
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/

ln -s /home/user/.config/nvim/symbolic/lazygit/config.yml ~/.config/lazygit/config.yml
ls -l ~/.config/lazygit/config.yml
```

## LazyDocker
```
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
git clone https://github.com/jesseduffield/lazydocker.git
echo "alias lzd='lazydocker'" >> ~/.zshrc
```

## Snippets

[https://github.com/honza/vim-snippets/tree/master/snippets](https://github.com/honza/vim-snippets/tree/master/snippets)


## Sh
```sh
# zshのインストール
# 実行後一回terminal再起動
sudo apt update
sudo apt install zsh
chsh -s $(which zsh)

# Oh My Zshのインストール
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 設定ファイル追加 **git管理のためシンボリックリンクで対応**
# どちらか一方でも削除したり移動すると壊れるので注意
ln -s $HOME/.config/nvim/symbolic/zsh/.zshrc ~/.zshrc
ls -l ~/.zshrc

# terminalでの画像表示に必要
echo 'deb [trusted=yes] https://apt.fury.io/ascii-image-converter/ /' | sudo tee /etc/apt/sources.list.d/ascii-image-converter.list
sudo apt update
sudo apt install -y ascii-image-converter

# プラグインインストール
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# シンボリックリンク設定していれば下記不要
# nvim ~/.zshrc

# 下記テーマを追加
# ZSH_THEME="robbyrussell"

# themeの設定をやり直したいとき
# p10k configure

# 下記プラグインを追加
# plugins=(git docker zsh-autosuggestions zsh-syntax-highlighting web-search)

sudo apt update
sudo apt install locales
sudo locale-gen ja_JP.UTF-8
sudo update-locale LANG=ja_JP.UTF-8
locale

source ~/.zshrc
```

## シェル変更でBashのパス消えるかも
```
~/.fzf/install
sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b ~/.local/bin
curl -LsSf https://astral.sh/uv/install.sh | sh
```

##  Windows
```sh
# win-depsのバイナリをC:\Program Filesに入れてPath通しておく

winget install --id=Neovim.Neovim -e
nvim -v

cd $env:LOCALAPPDATA\
git clone https://github.com/gucchi0421/nvim.git
```

## SSH
まず.sshをコピペして、適切なルートとパス形式に変更
\ ←これは右に変更 /
C: ←これは/home/{USERNAME}/
```sh
# 権限付与
chmod 700 ~/.ssh
chmod 600 ~/.ssh/*
# 改行コード修正
find ~/.ssh -type f -exec sed -i 's/\r$//' {} +
# ^Mが消えていればOK
cat -A ~/.ssh/*
# テスト
ssh -i ~/.ssh/id_ed25519 -p 10022 webchecker4@sv14937.xserver.jp
```