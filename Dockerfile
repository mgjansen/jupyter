FROM jupyter/all-spark-notebook
USER root 

RUN apt-get update && apt-get install -y --no-install-recommends \
		g++ \
		gcc \
		libc6-dev \
		make \
		pkg-config \
	&& rm -rf /var/lib/apt/lists/*

RUN apt-get -qq update && \
    apt-get -qq -y install curl && \
    echo "deb http://download.opensuse.org/repositories/network:/messaging:/zeromq:/release-stable/Debian_9.0/ ./" >> /etc/apt/sources.list 

RUN wget https://download.opensuse.org/repositories/network:/messaging:/zeromq:/release-stable/Debian_9.0/Release.key -O-  | sudo apt-key add - &&\
    apt-get -y install libzmq3-dev


ENV GO_VERSION 1.9.3.linux-amd64   

RUN curl -sLO https://dl.google.com/go/go${GO_VERSION}.tar.gz && \
    sudo tar -C /usr/local -zxf go${GO_VERSION}.tar.gz && \
    rm -f go${GO_VERSION}.tar.gz && \
    export PATH=$PATH:/usr/local/go/bin && \
    GOPATH=/go /usr/local/go/bin/go get github.com/gopherdata/gophernotes && \
    cp /go/bin/gophernotes /usr/local/bin/ && \
    mkdir -p ~/.local/share/jupyter/kernels/gophernotes && \    
    cp -r /go/src/github.com/gopherdata/gophernotes/kernel/* ~/.local/share/jupyter/kernels/gophernotes

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH




