all:
	ln -f -s $(CURDIR)/asdf/.asdf.sh ~/
	ln -f -s $(CURDIR)/bash/.bash_profile ~/
	ln -f -s $(CURDIR)/bin/ecto.rebuild ~/bin/
	ln -f -s $(CURDIR)/bin/ecto.reset ~/bin/
	ln -f -s $(CURDIR)/bin/find-and-replace ~/bin/
	ln -f -s $(CURDIR)/bin/glp ~/bin/
	ln -f -s $(CURDIR)/bin/pr ~/bin/
	ln -f -s $(CURDIR)/git/.gitconfig ~/
	ln -f -s $(CURDIR)/git/.gitignore_global ~/
	ln -f -s $(CURDIR)/ssh/config ~/.ssh/
	ln -f -s $(CURDIR)/vim/.vimrc ~/
	ln -f -s $(CURDIR)/bin/wdalias ~/bin/
	ln -f -s $(CURDIR)/git/.gitconfig ~/
	ln -f -s $(CURDIR)/git/.gitignore_global ~/
	ln -f -s $(CURDIR)/ssh/config ~/.ssh/
	ln -f -s $(CURDIR)/vim/.vimrc ~/
	curl --silent -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
