#!/bin/sh
#mkdir ~/.zsh
#git clone git://github.com/tarruda/zsh-autosuggestions .zsh/zsh-autosuggestions
#git clone git://github.com/zsh-users/zsh-syntax-highlighting.git .zsh/zsh-syntax-highlighting
curl -L http://install.ohmyz.sh | sh
cp ~/sync/home/.oh-my-zsh/themes/local.zsh-theme ~/.oh-my-zsh/themes/
cp ~/sync/home/.zshrc ~/.zshrc
