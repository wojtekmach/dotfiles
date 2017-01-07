all:
	ln -f -s $(CURDIR)/bash/.bash_profile ~/
	ln -f -s $(CURDIR)/git/.gitconfig ~/
	ln -f -s $(CURDIR)/git/.gitignore_global ~/
	ln -f -s $(CURDIR)/vim/.vimrc ~/
	curl --silent -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
