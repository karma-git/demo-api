kubectl:
	kubectl create -f ./10-raw-k8s
helm:
	helm upgrade --install fa ./50-helm -f ./50-helm/fa-values.yaml

	helm upgrade --install demo-api . -f values.yaml --namespace demo

	helm upgrade --install  argocd argo/argo-cd  \
					--kube-context sandbox \
					--namespace argocd \
					--version 5.26.1 \
					--wait --timeout 10m \
					--atomic \
					--values argocd.values.yml

jsonnet:
	jsonnet -y ./60-jssonnet/fa-ui.jsonnet | kubectl create -f -
teardown:
	kubectl -n default delete all --all
	helm delete fa || true
