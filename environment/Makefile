kubectl:
	kubectl create -f ./10-raw-k8s
helm:
	helm upgrade --install fa ./50-helm -f ./50-helm/fa-values.yaml
jsonnet:
	jsonnet -y ./60-jssonnet/fa-ui.jsonnet | kubectl create -f -
teardown:
	kubectl -n default delete all --all 
	helm delete fa || true
