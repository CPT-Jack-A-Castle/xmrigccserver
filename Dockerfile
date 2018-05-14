FROM ubuntu:xenial

RUN apt-get update && \
    apt-get install software-properties-common git build-essential libbz2-dev cmake libuv1-dev libssl-dev libmicrohttpd-dev  wget -y

RUN add-apt-repository ppa:jonathonf/gcc-7.1 && \
    apt-get update && \
    apt-get install gcc-7 g++-7 -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://dl.bintray.com/boostorg/release/1.67.0/source/boost_1_67_0.tar.gz \
    && tar xfz boost_1_67_0.tar.gz \
    && cd boost_1_67_0 \
    && ./bootstrap.sh --with-libraries=system \
    && ./b2 link=static runtime-link=static install \
    && cd .. && rm boost_1_67_0.tar.gz && ldconfig

RUN  git clone https://github.com/Bendr0id/xmrigCC.git && \
    cd xmrigCC && \
    cmake . -DCMAKE_C_COMPILER=gcc-7 -DCMAKE_CXX_COMPILER=g++-7 -DWITH_CC_SERVER=ON -DWITH_HTTPD=ON -DWITH_CC_CLIENT=ON  -DBOOST_ROOT=/root/boost_1_67_0 && \
    make 
    
COPY Dockerfile /Dockerfile

ENTRYPOINT  ["/xmrigCC/xmrigCCServer"]
