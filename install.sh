#!/bin/bash

#for i in crds/*.yaml; do kubectl apply -f $i; done

#kubectl apply -f ./yanxuan-istio-auth.yaml


DIFF_YAML=""
for i in diff/*.yaml; do
    CUR_YAML=`cat $i`
    DIFF_YAML="${DIFF_YAML}
---
${CUR_YAML}
"
done

echo "${DIFF_YAML}" |
    sed "s#{{K8S_CERT}}#$K8S_CERT#g" |
    sed "s#{{K8S_KEY}}#$K8S_KEY#g" |
    sed "s#{{K8S_API_ADDRESS}}#$K8S_API_ADDRESS#g" |
    sed "s#{{K8S_CERT_AUTH}}#$K8S_CERT_AUTH#g"

kubectl delete deploy istio-ingressgateway -n istio-system
kubectl delete deploy istio-egressgateway -n istio-system
kubectl delete svc istio-ingressgateway -n istio-system
kubectl delete svc istio-egressgateway -n istio-system
