#!/bin/bash

set -e

# some global var we want to overwrite with options
namespace=''
ARGS=() ### this array holds any positional arguments, i.e., arguments not started with dash

usage()
{
    echo "Creates chart from installed helm release."
    echo "Usage: $0 [-n namespace] HELM-RELEASE [REVISION]"
    exit
}

while [ $# -gt 0 ]; do
    while getopts hn: name; do
        case $name in
            n) namespace="$OPTARG";;
            h) usage
        esac
    done
    [ $? -eq 0 ] || exit 1
    [ $OPTIND -gt $# ] && break   # reached the end of parameters

    shift $[$OPTIND - 1] # free processed options so far
    OPTIND=1             # we must reset OPTIND
    ARGS[${#ARGS[*]}]=$1 # save first non-option argument (a.k.a. positional argument)
    shift                # remove saved arg
done

if [ ${#ARGS[*]} -eq 0 ]; then
    usage
fi

release=${ARGS[0]}

if [ ${#ARGS[*]} -gt 1 ]; then
    revision=${ARGS[1]}
else
  revision=$(helm ls ${namespace:+-n $namespace} -o json | jq  '.[]|select(.name=="'$release'")|.revision' -r)
  echo "Found latest revision: \"$release-v$revision\"" >&2
fi

dumpfile=.helm-recreate.$release-v$revision
echo Creating dumpfile: $dumpfile >&2
#trap "rm -f $dumpfile" EXIT

kubectl get secret sh.helm.release.v1.$release.v$revision -o jsonpath={.data.release} ${namespace:+-n $namespace} \
    | base64 -d | base64 -d | zcat \
    > $dumpfile

cat $dumpfile
