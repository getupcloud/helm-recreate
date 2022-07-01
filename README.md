# Helm Recreate

Creates a local chart dir from an already installer chart (release).

Sometimes you have an installed chart but the original repo was lost (or you dont have access to it).
Luckly helm stores all necessary information into the kubernetes cluster itself, allowing we to dump
it and recreate the chart.


For example, to recreate the ingress-nginx chart from the latest revision:

```shell
$ ./dump-helm-release.sh -n ingress-nginx ingress-nginx | ./helm-recreate.py
Found latest revision: "ingress-nginx-v9"
Creating dumpfile: .helm-recreate.ingress-nginx-v9
Creating chart dir: ingress-nginx
Creating file: ingress-nginx/Chart.yaml
Creating file: ingress-nginx/values.yaml
Creating file: ingress-nginx/templates/NOTES.txt
Creating file: ingress-nginx/templates/_helpers.tpl
Creating file: ingress-nginx/templates/admission-webhooks/job-patch/clusterrole.yaml
Creating file: ingress-nginx/templates/admission-webhooks/job-patch/clusterrolebinding.yaml
Creating file: ingress-nginx/templates/admission-webhooks/job-patch/job-createSecret.yaml
Creating file: ingress-nginx/templates/admission-webhooks/job-patch/job-patchWebhook.yaml
Creating file: ingress-nginx/templates/admission-webhooks/job-patch/psp.yaml
Creating file: ingress-nginx/templates/admission-webhooks/job-patch/role.yaml
Creating file: ingress-nginx/templates/admission-webhooks/job-patch/rolebinding.yaml
Creating file: ingress-nginx/templates/admission-webhooks/job-patch/serviceaccount.yaml
Creating file: ingress-nginx/templates/admission-webhooks/validating-webhook.yaml
Creating file: ingress-nginx/templates/clusterrole.yaml
Creating file: ingress-nginx/templates/clusterrolebinding.yaml
Creating file: ingress-nginx/templates/controller-configmap-addheaders.yaml
Creating file: ingress-nginx/templates/controller-configmap-proxyheaders.yaml
Creating file: ingress-nginx/templates/controller-configmap-tcp.yaml
Creating file: ingress-nginx/templates/controller-configmap-udp.yaml
Creating file: ingress-nginx/templates/controller-configmap.yaml
Creating file: ingress-nginx/templates/controller-daemonset.yaml
Creating file: ingress-nginx/templates/controller-deployment.yaml
Creating file: ingress-nginx/templates/controller-hpa.yaml
Creating file: ingress-nginx/templates/controller-poddisruptionbudget.yaml
Creating file: ingress-nginx/templates/controller-prometheusrules.yaml
Creating file: ingress-nginx/templates/controller-psp.yaml
Creating file: ingress-nginx/templates/controller-role.yaml
Creating file: ingress-nginx/templates/controller-rolebinding.yaml
Creating file: ingress-nginx/templates/controller-service-internal.yaml
Creating file: ingress-nginx/templates/controller-service-metrics.yaml
Creating file: ingress-nginx/templates/controller-service-webhook.yaml
Creating file: ingress-nginx/templates/controller-service.yaml
Creating file: ingress-nginx/templates/controller-serviceaccount.yaml
Creating file: ingress-nginx/templates/controller-servicemonitor.yaml
Creating file: ingress-nginx/templates/default-backend-deployment.yaml
Creating file: ingress-nginx/templates/default-backend-poddisruptionbudget.yaml
Creating file: ingress-nginx/templates/default-backend-psp.yaml
Creating file: ingress-nginx/templates/default-backend-role.yaml
Creating file: ingress-nginx/templates/default-backend-rolebinding.yaml
Creating file: ingress-nginx/templates/default-backend-service.yaml
Creating file: ingress-nginx/templates/default-backend-serviceaccount.yaml
```

A new directory `ingress-nginx` is created.

If you want an specific revision, just put it as the second argument:

```shell
$ ./dump-helm-release.sh -n ingress-nginx ingress-nginx 2 | ./helm-recreate.py
Creating dumpfile: .helm-recreate.ingress-nginx-v2
Creating chart dir: ingress-nginx
Creating file: ingress-nginx/Chart.yaml
Creating file: ingress-nginx/values.yaml
Creating file: ingress-nginx/templates/NOTES.txt
Creating file: ingress-nginx/templates/_helpers.tpl
Creating file: ingress-nginx/templates/admission-webhooks/job-patch/clusterrole.yaml
...
```
