#!/bin/sh

#
# Uses the CIRCLE_TOKEN environment variable to securely access CircleCI.
# VERSION refers to latest dexels/navajo-container version.
#

script=$(basename $0)


usage () {

    if [ -n "$1" ] ; then
        exec >&2
        echo "$script: Unknown option '$1'"
    fi

    echo "Usage: $script [-h] [-d] [-k] [-n]"
    echo "  -h  this info"
    echo "  -d  dry run"
    echo "  -k  run without the kafka container"
    echo "  -n  run without the navajo container"
    
    if [ -n "$1" ] ; then
        exit 0
    else
        exit 1
    fi
}


parse_options () {
    
    with_kafka="set"
    
    while getopts :hdkn option ; do
        case $option in
            \?)  usage $OPTARG ;;
            h)  usage ;;
            d)  dry_run="set" ;;
            k)  with_kafka="" ;;
            n)  with_navajo="" ;;
        esac
    done
        
    if [ -n "$with_kafka" ] ; then
        services="$services kafka"
    fi
    
    if [ -n "$with_navajo" ] ; then
        services="$services navajo"
        build_option="--build"
    fi
}


dry_run=""    
with_navajo="set"
build_option=""
services="postgres mongodemo"

parse_options "$@"


export VERSION=""
if [ -n "$with_navajo" ] ; then
    prefix=3.3
    if [ -z "$CIRCLE_TOKEN" ] ; then
        echo "$script: environment variable CIRCLE_TOKEN empty or undefined." >&2
        exit 2
    fi

    build=$(curl -s "https://circleci.com/api/v1.1/project/github/Dexels/navajo-container?circle-token=${CIRCLE_TOKEN}&limit=1&offset=0&filter=successful" | jq '.[0].build_num')
    export VERSION="$prefix.$build"
    echo "Navajo container version: '${VERSION}'"
fi

if [ -n "$dry_run" ] ; then
    echo "dry-run:" docker-compose  up  $build_option  $services
else
    echo "services: $services"
    docker-compose  up  $build_option  $services
fi
