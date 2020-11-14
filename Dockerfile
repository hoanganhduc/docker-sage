FROM sagemath/sagemath:latest
LABEL author="Duc A. Hoang"

RUN sudo apt-get -qq update && \
	sudo apt-get -qq install -y texlive-base && \
	sudo apt-get -qq clean && \
    sudo rm -r /var/lib/apt/lists/*
