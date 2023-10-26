ClusterCrafter
====

![Cluster Crafter Logo](misc/logo.png)

The ClusterCrafter is a common service tool to create and template all relevant components for kubernetes clusters within the hamburg port authority. It is strictly mapped towards the kubernetes-service-catalog also provided by us under following repository: https://github.com/Hamburg-Port-Authority/kubernetes-service-catalog

The service is seperated into multiple components described within the following table.

| Component         | Service                                                                             |
|-------------------|-------------------------------------------------------------------------------------|
| coreService       | external-dns, nginx-ingress, cert-manager, external-secrets, falco, kyverno, argocd |
| observability     | (TBD)                                                                               |
| observabilityPlus | (TBD)                                                                               |
| finops            | (TBD)                                                                               |
| securityPlus      | (TBD)                                                                               |

