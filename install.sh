echo "(dotfiles-online installer) Setting up online environment..."

###########
# Install #
###########

# Install Oh My Zsh
echo "(dotfiles-online installer) Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# AWS CLI v2
echo "(dotfiles-online installer) Installing AWS CLI v2..."
AWS_CLI_V2_URL='https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip'
curl "${AWS_CLI_V2_URL}" -o "awscliv2.zip" &&
  unzip awscliv2.zip &&
  ./aws/install -i /workspace/aws-cli -b ${WORKSPACE_BIN}
alias aws="${WORKSPACE_BIN}/aws"

#############
# Setup AWS #
#############

aws configure set credential_process ${WORKSPACE_BIN}/aws-sso-credential-process
touch ~/.aws/credentials && chmod 600 $_

cat <<EOF >~/.aws/config
[${DEFAULT_PROFILE}]
credential_process = ${WORKSPACE_BIN}/aws-sso-credential-process
sso_start_url = ${SSO_START_URL}
sso_region = ${SSO_REGION}
sso_account_id = ${SSO_ACCOUNT_ID}
sso_role_name =${SSO_ROLE_NAME}
region = ${DEFAULT_REGION}
output = ${DEFAULT_OUTPUT}
EOF

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
