.PHONY: help 

# Ref: https://gist.github.com/prwhite/8168133
help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} \
		/^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

install: ## install requirement package
	sh install.sh
	## terminal 
	brew install alacritty
	brew install tmux
	if [ ! -d ~/.tmux/plugins/tpm ]; then \
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm; \
	fi
	brew install htop
	brew install fzf
	/usr/local/opt/fzf/install
	brew install fd 
	## vim
	brew install neovim
	brew install wget
	brew install ctags
	brew install ripgrep
	## language
	brew install go
	brew install maven
	brew install openjdk@17
	brew install node
	brew install homebrew/cask-fonts/font-jetbrains-mono-nerd-font
	brew install protobuf
	pip3 install antlr4-tools

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
