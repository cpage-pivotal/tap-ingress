set -x

ytt -f ingress-resources.yaml -f values-ingress.yaml | kubectl apply -f-

kubectl patch configmap config-domain- -n knative-serving -p "$(ytt -f patch-domain.yaml -f values-ingress.yaml | sed "s/key: //g" | sed "s/'//g")"

kubectl patch configmap config-network -n knative-serving -p "$(ytt -f patch-network.yaml -f values-ingress.yaml)"

kubectl patch configmap config-contour -n knative-serving -p "$(ytt -f patch-contour.yaml -f values-ingress.yaml)"
