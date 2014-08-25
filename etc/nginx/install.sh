#!/bin/bash

set -e

version=
prefix=
args=

while [ $# -gt 0 ]; do

    case $1 in

	    --usage|--help)
		cat - <<-EOF
		Description: Download and install nginx
		Example: $ ./install.sh --version=1.6.1 --prefix=/opt/nginx
		EOF
		exit 0
	    ;;
	    --version=*)
		version=${1#--version=}
	    ;;

	    --prefix=*)
		prefix=${1#--prefix=}
	    ;;

	    *)
		args="$args $1"
	    ;;

    esac

    shift

done


if [ ! $version ]; then echo "--version is required"; exit 1; fi
if [ ! $prefix ]; then echo "--prefix is required"; exit 1; fi

# remove trailing slash
prefix="${prefix%/}"
package="nginx-${version}"
module_root="$(pwd)"


archive="${package}.tar.gz"
url="http://nginx.org/download/${archive}"

rm -rf $package

if [ ! -e $archive ]; then
    wget -O $archive $url
fi

tar xzvf $archive

apt-get -y install build-essential zlib1g zlib1g-dev libpcre3 libpcre3-dev
apt-get -y install libgd3 libgeoip1 libgeoip-dev libssl1.0.0 libxml2 libxslt1.1

pushd $package
./configure --prefix="$prefix" --sbin-path="$prefix/bin/nginx" $args
make build
make install
popd

rm -rf $package
rm -rf $archive

