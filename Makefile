all: separate

apt:
	apt install -y terminator
	apt install -y network-manager-openconnect-gnome
	apt install -y git
	apt install -y python3
	apt install -y python3-pip
	apt install -y neovim
	apt install -y elixir

snap:
	snap install ipfs
	snap install go --classic
	snap install atom --classic

go:
	go get -u github.com/github/hub


separate:
	sudo make apt
	sudo make snap
	make go
