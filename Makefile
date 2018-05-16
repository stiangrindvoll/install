.PHONY: dotfiles bin
SHELL := /bin/bash
ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
UBUNTU=artful
DEP=dependencies

all: clean
	make deb-dependencies
	make apt-dependencies
	sudo make apt-repositories
	sudo make debs
	sudo make aptitude
	make dotfiles
	make pip
	make git-dependencies
	make ruby
	sudo make snap
	make go
	make bin

dotfiles:
	stow nvim terminator bash git -d dotfiles -t ~/

deb-dependencies:
	mkdir -p ${DEP}
	wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb -O ${DEP}/erlang-solutions_1.0_all.deb
	wget https://atom.io/download/deb -O ${DEP}/atom-amd64.deb

apt-dependencies:
	mkdir -p ${DEP}
	wget https://download.docker.com/linux/ubuntu/gpg -O ${DEP}/docker.asc
apt-repositories:
	apt-key add ${DEP}/docker.asc
	add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu ${UBUNTU} stable"

git-dependencies:
	git clone https://github.com/rbenv/rbenv.git ~/.rbenv
	git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --bin

debs:
	dpkg -i ${DEP}/erlang-solutions_1.0_all.deb
	dpkg -i ${DEP}/atom-amd64.deb

aptitude:
	apt-get update
	apt-get install -y stow #dotfiles
	apt-get install -y git htop curl neovim terminator jq
	apt-get install -y network-manager-openconnect-gnome
	apt-get install -y python3 python3-pip
	apt-get install -y esl-erlang elixir npm inotify-tools
	apt-get install -y openjdk-8-jre openjdk-8-jdk
	apt-get install -y docker-ce
	apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev # ruby dependencies

ruby:
	cd ~/.rbenv && src/configure && make -C src

snap:
	snap install ipfs
	snap install go --classic

pip:
	pip3 install --user docker-compose
	pip3 install --user awscli
	pip3 install --user git+https://github.com/makethunder/awsudo.git


go:
	go get -u github.com/github/hub
	# For atom GoLang environment
	go get -u golang.org/x/lint/golint
	go get -u golang.org/x/tools/cmd/goimports
	go get -u golang.org/x/tools/cmd/gorename
	go get -u github.com/sqs/goreturns
	go get -u github.com/nsf/gocode
	go get -u github.com/alecthomas/gometalinter
	go get -u github.com/zmb3/gogetdoc
	go get -u github.com/zmb3/goaddimport
	go get -u github.com/rogpeppe/godef
	go get -u golang.org/x/tools/cmd/guru
	go get -u github.com/fatih/gomodifytags
	go get -u github.com/tpng/gopkgs

bin:
	mkdir -p ~/bin
	wget https://raw.githubusercontent.com/so-fancy/diff-so-fancy/d2b7286e88230f5ee654acd2892504e5af482e43/third_party/build_fatpack/diff-so-fancy -O ~/bin/diff-so-fancy && chmod +x ~/bin/diff-so-fancy # version 1.2.0


clean:
	rm -r ${DEP}
