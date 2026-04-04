all:

libc-1-r1-1.gpkg.tar:
	test -f $@ || wget https://distfiles.gentoo.org/releases/amd64/binpackages/23.0/x86-64/virtual/libc/libc-1-r1-1.gpkg.tar -O libc-1-r1-1.gpkg.tar

check: getuto test-getuto.sh libc-1-r1-1.gpkg.tar
	./test-getuto.sh
