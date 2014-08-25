#!/bin/bash

set -e

version=
binary_path="$(pwd)/uwsgi"
profile="default"
args=

while [ $# -gt 0 ]; do

    case $1 in

	    --usage|--help)
		cat - <<-EOF
		Description: Download and install uwsgi
        Example: $ ./install.sh --version=2.0.6 --binary-path=$(pwd)/uwsgi --profile=default
		EOF
		exit 0
	    ;;

	    --version=*)
		version=${1#--version=}
	    ;;

	    --binary-path=*)
		binary_path=${1#--binary-path=}
	    ;;

	    --profile=*)
		profile=${1#--profile=}
	    ;;

	    *)
		args="$args $1"
	    ;;

    esac

    shift

done


if [ ! $version ]; then echo "--version is required, eg. 2.0.6"; exit 1; fi
if [ "${binary_path:0:1}" != "/" ]; then echo "--binary-path must be absolute"; exit 1; fi

package="uwsgi-${version}"
archive="${package}.tar.gz"
url="http://projects.unbit.it/downloads/${archive}"

if [ ! -e $archive ]; then
    wget -O $archive $url
fi

rm -rf $package
mkdir $package
tar xzvC $package --strip-components=1 -f $archive

apt-get -y install build-essential python-dev

pushd $package
UWSGI_PROFILE="$profile" UWSGI_BIN_NAME="$binary_path" make
popd

rm -rf $package
rm -rf $archive

