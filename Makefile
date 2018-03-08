UBUNTU=artful
DEP=dependencies

all: separate

deb-dependencies:
	mkdir -p ${DEP}
	wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb -O ${DEP}/erlang-solutions_1.0_all.deb

apt-dependencies:
	mkdir -p ${DEP}
	wget https://download.docker.com/linux/ubuntu/gpg -O ${DEP}/docker.asc
apt-repositories:
	apt-key add ${DEP}/docker.asc
	add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu ${UBUNTU} stable"


debs:
	dpkg -i repositorie/serlang-solutions_1.0_all.deb

aptitude:
	apt-get update
	apt-get install -y terminator
	apt-get install -y network-manager-openconnect-gnome
	apt-get install -y git
	apt-get install -y curl
	apt-get install -y python3 python3-pip
	apt-get install -y neovim
	apt-get install -y esl-erlang	elixir
	apt-get install -y docker-ce

snap:
	snap install ipfs
	snap install go --classic
	snap install atom --classic

go:
	go get -u github.com/github/hub


separate:
	make deb-dependencies
	make apt-dependencies
	sudo make apt-repositories
	sudo make debs
	sudo make aptitude
	sudo make snap
	make go
