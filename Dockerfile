# Create Docker container user to build 0install generic binaries.
FROM talex5/0install-static-build

RUN sudo apt-get install -y vim git build-essential unzip python-gobject wget curl --no-install-recommends

COPY trustdb.xml /root/.config/0install.net/injector/trustdb.xml

RUN curl -L https://downloads.sourceforge.net/zero-install/0install-linux-x86_64-2.14.1.tar.bz2 | tar xj
RUN 0install-linux-x86_64-2.14.1/install.sh local

#RUN curl -L https://downloads.sourceforge.net/zero-install/0install-linux-armv7l-2.14.1.tar.bz2 | tar xj
#RUN 0install-linux-armv7l-2.14.1/install.sh local

RUN 0install add 0release --cpu "$CPU" http://0install.net/2007/interfaces/0release.xml \
		--version-for http://0install.net/2006/interfaces/0compile.xml 1.5..

WORKDIR /mnt
