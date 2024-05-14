.PHONY: help 

# Ref: https://gist.github.com/prwhite/8168133
help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} \
		/^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

install: ## install requirement package
	sh install.sh
	## terminal 
	brew install --cask wezterm
	brew install fish
	brew install onefetch
	brew install alacritty
	brew install tmux
	if [ ! -d ~/.tmux/plugins/tpm ]; then \
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm; \
	fi
	brew install htop
	brew install fzf
	/usr/local/opt/fzf/install
	brew install fd 
	brew install tree
	brew install kubectl
	brew install gnu-sed
	brew install btop
	## vim
	brew install neovim
	brew install wget
	brew install ctags
	brew install ripgrep
	## language
	brew install go
	brew install maven
	brew install openjdk@17
	brew install gitui
	brew install node
	brew install homebrew/cask-fonts/font-go-mono-nerd-font
	brew install font-jetbrains-mono
	brew install protobuf
	pip3 install antlr4-tools

	# fish for bash
	omf install bass

install_plugins: ## install plugins
	~/.tmux/plugins/tpm/scripts/install_plugins.sh

CONFIG_PATH = ~/.config
config: ## sync config file
	if [ ! -d $(CONFIG_PATH) ]; then \
		mkdir $(CONFIG_PATH); \
	fi
	cp -rf ./alacritty $(CONFIG_PATH)
	cp -rf ./nvim $(CONFIG_PATH)
	cp -rf ./zsh $(CONFIG_PATH)
	cp -rf ./tmux/.tmux.conf ~/
	cp -rf ./zsh/.zshrc ~/
	tmux source ~/.tmux.conf
	## install kubectl cheatsheet
	source <(kubectl completion zsh)  # set up autocomplete in zsh into the current shell
	echo '[[ $commands[kubectl] ]] && source <(kubectl completion zsh)' >> ~/.zshrc # add autocomplete permanently to your zsh shell
