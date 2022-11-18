.PHONY: help 

# Ref: https://gist.github.com/prwhite/8168133
help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} \
		/^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

install: ## install requirement package
	## terminal 
	brew install alacritty
	brew install tmux
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
	brew install htop
	## vim
	brew install neovim
	brew install wget
	brew install ctags
        ## language
	brew install go
	brew install maven
	brew install openjdk@17
	brew install node
	brew install homebrew/cask-fonts/font-jetbrains-mono-nerd-font

CONFIG_PATH = ~/.config
config: ## sync config file
	if [ ! -d $(CONFIG_PATH) ]; then \
		mkdir $(CONFIG_PATH); \
	fi
	cp -rf ./alacritty $(CONFIG_PATH)
	cp -rf ./nvim $(CONFIG_PATH)
	cp -rf ./zsh $(CONFIG_PATH)
