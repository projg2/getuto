#!/bin/bash
set -x -e

whoami() {
	# Bypass getuto's check for root as we're going to run in a fake tempdir.
	echo root
}

export -f whoami
# Keep the real root around before we override its value so we can grab a copy of
# gentoo-release.asc.
export REAL_ROOT="${ROOT%/}"
export ROOT="$(mktemp -d)"

mkdir -p "${ROOT}"/usr/share/openpgp-keys
ln -s "${REAL_ROOT}"/usr/share/openpgp-keys/gentoo-release.asc "${ROOT}"/usr/share/openpgp-keys/gentoo-release.asc

# Generate a keyring using getuto.
bash -x getuto

# Make sure the newly-generated keyring works.
export GNUPGHOME="${ROOT%/}"/etc/portage/gnupg
mkdir -p "${ROOT}"/tmp/binpkg
tar xvf libc-1-r1-1.gpkg.tar -C "${ROOT}"/tmp/binpkg
for file in image.tar.bz2 metadata.tar.bz2 ; do
	gpg --verify "${ROOT}"/tmp/binpkg/libc-1-r1-1/${file}.sig
done
