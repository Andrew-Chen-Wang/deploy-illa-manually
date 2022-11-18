#!/usr/bin/env bash
set -Eeo pipefail

# check to see if this file is being run or sourced from another script
_is_sourced() {
	# https://unix.stackexchange.com/a/215279
	[ "${#FUNCNAME[@]}" -ge 2 ] \
		&& [ "${FUNCNAME[0]}" = '_is_sourced' ] \
		&& [ "${FUNCNAME[1]}" = 'source' ]
}


_main() {

    echo 
    echo 'config init.'
    echo 

    # replace frontend repo
    if [ ! -n "$API_SERVER_ADDRESS" ]; then
        echo "API_SERVER_ADDRESS not defined, skip."
    else
        sed -i "s/localhost/$API_SERVER_ADDRESS/g" /opt/illa/illa-frontend/assets/*.js
    fi

    if [ ! -n "$RELEASE_VERSION" ]; then
        echo "RELEASE_VERSION not defined, skip."
    else
        sed -i "s#<head>#<head><meta release-version=\"$RELEASE_VERSION\" />#g" /opt/illa/illa-frontend/index.html
    fi
    

    echo 
    echo 'config init done.'
    echo 

}






if ! _is_sourced; then
	_main "$@"
fi
