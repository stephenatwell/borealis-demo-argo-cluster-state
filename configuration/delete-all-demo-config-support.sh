echo "Initiating Complete cleanup - uninstalling agents and prometheus"
helm uninstall armory-rna-prod \
    -n borealis-demo-agent-prod
helm uninstall armory-rna-prod-eu \
    -n borealis-demo-agent-prod-eu
helm uninstall armory-rna-staging \
    -n borealis-demo-agent-staging
helm uninstall armory-rna-dev \
    -n borealis-demo-agent-dev
helm uninstall prometheus -n=borealis-demo-infra

echo "Deleting namespaces. this may take a while"
#do not delete demo agent prod, we want the secret in it kept around!!!
#kubectl delete namespace borealis-demo-agent-prod # keep this one, it has the secret
kubectl delete namespace borealis-demo-agent-staging
kubectl delete namespace borealis-demo-agent-dev
kubectl delete ns borealis-demo-agent-prod-eu
kubectl delete ns borealis-demo-infra

kubectl delete ns borealis-dev
kubectl delete ns borealis-staging
kubectl delete ns borealis-infosec
kubectl delete ns borealis-prod
kubectl delete ns borealis-prod-eu
kubectl delete ns borealis-prod-east

echo "uninstalling LinkerD from cluster"
export PATH=~/.linkerd2/bin:$PATH
linkerd uninstall | kubectl delete -f -