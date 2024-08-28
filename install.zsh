#!/usr/bin/env zsh
DOTFILES_PATH=${0:a:h}
cd "$DOTFILES_PATH"
FILES_TO_LINK=(
	.zshrc
	.tool-versions
	$(ls -d .config/*)
)

echo "Starting set up"
echo "Fetching and updating submodules"
git submodule update --init --recursive

echo "Installing xcode CLI tools"
xcode-select --install

echo "Checking if homebrew is installed"
if test ! $(which brew)
then
	echo "Homebrew not found, installing"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
	echo "Found homebrew at $(which brew). Skipping installation."
fi

for config in $FILES_TO_LINK
do
	echo "Checking if $config already exists"
	if [[ -f "$HOME"/"$config" || -h "$HOME"/"$config" ]]; then
		echo "$config exists and is a file or symlink. Removing."
		rm -f "$HOME"/"$config"
	elif [[ -d "$HOME"/"$config" ]]; then
		echo "$config exists and is a directory. Removing."
		rm -rf "$HOME"/"$config"
	fi

	echo "Linking $config"
	ln -sw "$DOTFILES_PATH"/"$config" "$HOME"/"$config"
done

echo "Reloading .zshrc config"
source "$HOME"/.zshrc

echo "Updating homebrew formulae"
brew update
brew tap homebrew/bundle
echo "Begin installating brew packages"
brew bundle --file ./Brewfile

if [[ -f "$ASDF_DEFAULT_TOOL_VERSIONS_FILENAME" ]]
then
	echo "Installing asdf shims"
	for lang in $(cat "$DOTFILES_PATH"/".tools-versions" | cut -d' ' -f1)
	do
		echo "Adding and installing $lang"
		asdf plugin add ${lang}
		asdf install ${lang}
	done
fi

echo "Finished set up"
