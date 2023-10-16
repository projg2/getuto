## getuto

getuto ('Gentoo trust tool') is a tool to maintain a gpg keyring in `/etc/portage/gnupg`
for binary packages:
* It creates a keyring in `/etc/portage/gnupg` if it doesn't already exist.
* If a keyring already exists, it will refresh the keys from keyservers/wkd
  and import newer keys if available on the system.

If `--getbinpkg` or `--getbinpkgonly` is used, Portage will run `getuto` before fetching
any binary packages.

A fresh keyring is needed to safely verify binary packages for revocations
and renewals of gpg keys.

To disable getuto, set `PORTAGE_TRUST_HELPER=true` in `/etc/portage/make.conf`.
