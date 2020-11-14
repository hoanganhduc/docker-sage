FROM sagemath/sagemath-dev:latest
LABEL author="Duc A. Hoang"

RUN sudo apt-get -qq update
	
RUN sudo apt-get -qq install -y texlive-latex-base

RUN sudo apt-get -qq install -y latexmk
	
RUN sudo apt-get -qq clean && \
    sudo rm -r /var/lib/apt/lists/*
