FROM archlinux:latest
LABEL author="Duc A. Hoang"

ARG USERNAME=sage
ARG USERHOME=/home/sage
ARG USERID=1000
ARG USERGECOS='SageMath'

RUN useradd \
	--create-home \
	--home-dir "$USERHOME" \
	--password "" \
	--uid "$USERID" \
	--comment "$USERGECOS" \
	--shell /bin/bash \
	"$USERNAME" && \
	echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8 

RUN pacman -Syy && \
	pacman -S --noconfirm --needed arb bc binutils boost brial cblas cddlib eclib fflas-ffpack flintqs gc gcc gcc gcc-fortran gd gf2x gfan giac glpk gsl iml lapack lcalc libatomic_ops libbraiding libgiac lrcalc m4 m4ri m4rie make nauty openblas palp pari pari-elldata pari-galdata pari-galdata pari-galpol pari-seadata pari-seadata patch perl planarity ppl python r rankwidth readline sqlite3 suitesparse symmetrica sympow tachyon tar which zn_poly && \
	pacman -S --noconfirm --needed boost coin-or-cbc coxeter ninja openssl pandoc pari-elldata pari-galpol pari-seadata perl-term-readline-gnu && \
	pacman -S --noconfirm --needed base base-devel python perl ffmpeg imagemagick texlive-core texlive-bin texlive-fontsextra openssh git curl wget sudo && \
	yes | pacman -Scc

USER $USERNAME
	
#RUN git clone -c core.symlinks=true --branch master git://trac.sagemath.org/sage.git && \
#	cd sage && \
#	make configure && \
#	./configure && \
#	make && \
#	./config.status --recheck && ./config.status && \
#	sudo ln -s /home/sage/sage /usr/local/bin/sage && \
#	mkdir $HOME/.sage && echo "%colors linux" >> $HOME/.sage/init.sage 

RUN curl -O http://mirrors.mit.edu/sage/src/sage-9.2.tar.gz && \
	tar xvf sage-9.2.tar.gz && \
	mv sage-9.2 sage && \
	rm -rf sage-9.2.tar.gz
	
RUN cd $USERHOME/sage && \
	./configure && \
	make build && \
	./config.status --recheck && ./config.status && \
	sudo ln -s $USERHOME/sage/sage /usr/local/bin/sage && \
	mkdir $USERHOME/.sage && echo "%colors linux" >> $USERHOME/.sage/init.sage 
	

	


