# Create Docker container user to build 0install generic binaries.

# (can't use 10.04 any more, due to "vsyscall attempted with vsyscall=none" when running bash)
# (can't use 12.04 any more; SSL libraries too old to download things from sf.net)
# (can't use 14.04/16.04 any more; gives libcurl.so.4: version `CURL_OPENSSL_3' not found on modern systems)
FROM ocurrent/opam:debian-10-ocaml-4.08

RUN sudo apt-get install -y vim 0install-core libgtk2.0-dev libcurl4-openssl-dev build-essential ca-certificates m4 unzip python-gobject wget curl --no-install-recommends

RUN mkdir /home/opam/bin
ENV PATH /home/opam/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
RUN opam install cppo yojson xmlm ounit lwt_react ocurl obus lablgtk lwt_glib sha dune
COPY --chown=opam:opam trustdb.xml /home/opam/.config/0install.net/injector/trustdb.xml

RUN 0install add 0release --cpu "$CPU" http://0install.net/2007/interfaces/0release.xml \
		--version-for http://0install.net/2006/interfaces/0compile.xml 1.5..

WORKDIR /mnt
