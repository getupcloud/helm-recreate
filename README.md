# Helm Recreate

Creates a local chart dir from an already installer chart (release).

Sometimes you have an installed chart but the original repo was lost (or you don't have access to it anymore).

Luckly helm stores all necessary information inside the kubernetes cluster itself, allowing we to dump
it and recreate the chart.


## Install

There is no install:

``` shell
git clone https://github.com/getupcloud/helm-recreate
cd helm-recreate
pip install -r requirements.txt
```

## Using

For example, to recreate the ingress-nginx chart from the latest revision:

```shell
./dump-helm-release.sh -n ingress-nginx ingress-nginx | ./helm-recreate.py
```

A new directory `ingress-nginx` is created.

If you want an specific revision, just put it as the second argument:

```shell
./dump-helm-release.sh -n ingress-nginx ingress-nginx 2 | ./helm-recreate.py
```
