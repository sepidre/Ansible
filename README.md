# ToDos
- ZSH
``` bash
# install
sudo apt install zsh
# get version to insert in next command to set is as default
zsh --version
chsh -s $(which zsh)
```
- Powerline fonts
``` zsh
git clone https://github.com/powerline/fonts.git
cd fonts
./install.sh
```
- nerd fonts mac
``` zsh
brew install wget
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/CascadiaCode.zip
unzip CascadiaCode.zip
mv *.ttf ~/Library/Fonts
```
- nerd fonts debian
``` zsh
apt install wget
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/CascadiaCode.tar.xz
unzip CascadiaCode.tar.xz
mv *.ttf ~/.fonts
fc-cache -fv
```
- OhMyZSH
``` zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```
- OhMyZSH Theme powerlevel10k
```zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```
- neofetch on MAC
``` zsh
brew install neofetch
```
- neofetch on debian
``` zsh
sudo apt install neofetch
```
- neofetch themes
``` zsh
cd ~/.config/neofetch/ && mv config.conf configbackup.conf
git clone https://github.com/Chick2D/neofetch-themes/
cp neofetch-themes/normal/acenoster.conf ~/.config/neofetch/config.conf
## to change rm old
rm ~/.config/neofetch/config.conf
```

ansible-playbook -i init-inventory inituserandshell.yml --extra-vars "usr=sepidre usrpwd=$6$R/4YUut1qdGneQFy$oB7bNV0GUykAeT0Xab/Cf0ORvXuX8wdsaETFO3qiOBpmL23Eu6nb2BZe5So5iaMvRQDWnK019elmox3EHRj.w0 usrpwdmac=1234"