# start from the latest Ubuntu base image
FROM ubuntu:latest

# set environment variables to make installs non-interactive
ENV DEBIAN_FRONTEND=noninteractive

# update package list and install common tools and utilities
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    software-properties-common \
    build-essential \
    git \
    vim \
    tmux \
    unzip \
    zip \
    htop \
    net-tools \
    iputils-ping \
    dnsutils \
    lsof \
    gnupg \
    ca-certificates \
    apt-transport-https

# install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm@latest

# install Python 3 and pip
RUN apt-get install -y python3 python3-pip

# install OpenJDK
RUN apt-get install -y openjdk-21-jdk

# install Go
RUN wget https://go.dev/dl/go1.23.2.linux-amd64.tar.gz && \
    rm -rf /usr/local/go && \
    tar -C /usr/local -xzf go1.23.2.linux-amd64.tar.gz && \
    rm go1.23.2.linux-amd64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin

# add the PPA for Helix and install Helix editor
RUN add-apt-repository ppa:maveonair/helix-editor -y && \
    apt-get update && \
    apt-get install -y helix

# install Rust and Rustup
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
    apt-get install -y rustup && \
    rustup update
ENV PATH="$PATH:/root/.cargo/bin"

# install PostgreSQL Client
RUN apt-get install -y postgresql-client

# install Redis CLI
RUN apt-get install -y redis-tools

# install ZSH
RUN apt-get -y install zsh
RUN chsh -s $(which zsh)

# install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# set the theme and plugins in .zshrc, replacing existing entries if present
RUN sed -i 's/^ZSH_THEME=".*"/ZSH_THEME="af-magic"/' ~/.zshrc || echo 'ZSH_THEME="af-magic"' >> ~/.zshrc && \
    sed -i 's/^plugins=(.*)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)/' ~/.zshrc || echo 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting web-search)' >> ~/.zshrc

# set aliases
RUN echo "# aliases" >> ~/.zshrc
RUN echo "alias ll=\"ls -la\"" >> ~/.zshrc

# set run on startup commands
RUN echo "# run on startup"
RUN echo "date" >> ~/.zshrc

# clean up unnecessary files to reduce image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# default command to keep the container running (useful for interactive sessions)
CMD ["bash"]

