FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
	apt install git build-essential libbz2-dev cmake libuv1-dev libssl-dev libhwloc-dev wget gcc g++ -y && \
	apt clean && \
   	rm -rf /var/lib/apt/lists/*

RUN  git clone https://github.com/Bendr0id/xmrigCC.git && \
	cd xmrigCC && \
	cmake . -DWITH_CC_CLIENT=OFF && \
	make 
	
COPY Dockerfile /Dockerfile

ENTRYPOINT  ["/xmrigCC/xmrigServer"]
