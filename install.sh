echo "(dotfiles-online installer) Setting up online environment..."

###########
# Install #
###########
# Install Oh My Zsh
echo "(dotfiles-online installer) Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# AWS CLI v2
echo "(dotfiles-online installer) Installing AWS CLI v2..."
cd ~
sudo curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /
sudo rm AWSCLIV2.pkg

#########
# Fonts #
#########
# Install Powerline fonts
echo "(dotfiles-online installer) Installing Powerline fonts..."
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

# Install Fira Code font
echo "(dotfiles-online installer) Installing Fira Code font..."
mkdir fira-code
cd fira-code
curl https://github.com/tonsky/FiraCode/releases/download/5.2/Fira_Code_v5.2.zip -o fira-code.zip -s -L
unzip fira-code.zip
cp ttf/*.ttf ~/Library/Fonts/
cd ..
rm -rf fira-code

# Install regular Fira font (OTF version)
echo "(dotfiles-online installer) Installing Fira font..."
git clone https://github.com/mozilla/Fira.git --depth=1
cp Fira/otf/*.otf ~/Library/Fonts/
rm -rf Fira

###############################################
# Start laying out the dotfiles on the system #
###############################################
echo "(dotfiles-online installer) Laying out the dotfiles on your system..."
cd dotfiles

# Root level files
cp config/.gitignore_global ~/
cp config/.gitconfig ~/
cp config/.inputrc ~/
cp config/.zshrc ~/

# Bash dotfiles + Mac OSX settings
mkdir -p ~/.dotfiles/
cp system/.alias ~/.dotfiles/
cp system/.env ~/.dotfiles/

cd ..

##########
# Finish #
##########
# Run zsh compaudit
echo "(dotfiles-online installer) Zsh compaudit/compinit..."
compaudit
compinit -i

echo "(dotfiles-online installer) Done!"
