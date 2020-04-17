all:
	mkdir -p ~/bin
	mkdir -p ~/.vim
	ln -f -s $(CURDIR)/ag/.agignore ~/
	ln -f -s $(CURDIR)/asdf/.tool-versions ~/
	ln -f -s $(CURDIR)/bash/.bash_profile ~/
	ln -f -s $(CURDIR)/bash/.git-completion.bash ~/
	ln -f -s $(CURDIR)/bash/.hushlogin ~/
	ln -f -s $(CURDIR)/bin/ecto.rebuild ~/bin/
	ln -f -s $(CURDIR)/bin/itermvim ~/bin/
	ln -f -s $(CURDIR)/bin/current_project_name ~/bin/
	ln -f -s $(CURDIR)/bin/ecto.reset ~/bin/
	ln -f -s $(CURDIR)/bin/find-and-replace ~/bin/
	ln -f -s $(CURDIR)/bin/github ~/bin/
	ln -f -s $(CURDIR)/bin/glp ~/bin/
	ln -f -s $(CURDIR)/bin/pr ~/bin/
	ln -f -s $(CURDIR)/bin/t ~/bin/
	ln -f -s $(CURDIR)/bin/wdalias ~/bin/
	ln -f -s $(CURDIR)/bin/mdocs ~/bin/
	ln -f -s $(CURDIR)/bin/tt ~/bin/
	ln -f -s $(CURDIR)/bin/harvest ~/bin/
	ln -f -s $(CURDIR)/bin/repush ~/bin/
	ln -f -s $(CURDIR)/bin/m ~/bin/
	ln -f -s $(CURDIR)/git/.gitconfig ~/
	ln -f -s $(CURDIR)/git/.gitignore_global ~/
	ln -f -s $(CURDIR)/git/template ~/.git_template
	ln -f -s $(CURDIR)/ssh/config ~/.ssh/
	ln -f -s $(CURDIR)/vim/.vimrc ~/
	ln -f -s $(CURDIR)/vim/colors ~/.vim/
	ln -f -s $(CURDIR)/git/.gitconfig ~/
	ln -f -s $(CURDIR)/git/.gitignore_global ~/
	ln -f -s $(CURDIR)/ssh/config ~/.ssh/
	ln -f -s $(CURDIR)/vim/.vimrc ~/
	rm -rf ~/.iterm2
	ln -f -s $(CURDIR)/iterm2 ~/.iterm2
	curl --silent -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	# brew install postgresql
	# brew services start postgresql
	# createuser ${USER}
	# createuser postgres --password --superuser
