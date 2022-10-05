#!/bin/bash
TMPDIR=$(mktemp -d)
CURRENT=$PWD
cd $TMPDIR

echo "(dotfiles-online installer) Setting up online environment..."

###########
# Install #
###########

# Install Oh My Zsh
#echo "(dotfiles-online installer) Installing Oh My Zsh..."
#sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# AWS CLI v2
echo "(dotfiles-online installer) Installing AWS CLI v2..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

#########
# Fonts #
#########

# Install Fira Code font
echo "(dotfiles-online installer) Installing Fira Code font..."
mkdir fira-code
cd fira-code
curl https://github.com/tonsky/FiraCode/releases/download/5.2/Fira_Code_v5.2.zip -o fira-code.zip -s -L
unzip fira-code.zip
cp ttf/*.ttf ~/
cd ..
rm -rf fira-code

# Install regular Fira font (OTF version)
echo "(dotfiles-online installer) Installing Fira font..."
git clone https://github.com/mozilla/Fira.git --depth=1
cp Fira/otf/*.otf ~/
rm -rf Fira

##########
# Finish #
##########

cd $CURRENT
rm -rf $TMPDIR
echo "(dotfiles-online installer) Done!"
