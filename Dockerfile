FROM sagemath/sagemath-dev:latest
LABEL author="Duc A. Hoang"

RUN sudo apt-get -qq update && \
	sudo apt-get -qq install -y software-properties-common && \
	sudo add-apt-repository ppa:jonathonf/texlive-2018 -y && \
	sudo apt-get -qq update && \
	sudo apt-get -qq install -y \
		texlive-latex-base \
		texlive-latex-recommended \
		texlive-latex-extra \
		texlive-fonts-recommended \
		texlive-lang-other \
		latexmk && \
	sudo apt-get -qq clean && \
    sudo rm -r /var/lib/apt/lists/*
