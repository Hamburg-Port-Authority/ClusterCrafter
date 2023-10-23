psp:
  privileged: {{ services.coreServices.system.argocd.privilegedPspName }}

init:
  application:
    {%- for init in services.coreServices.system.argocd.init %}
    - repository: {{ init.gitRepositoryURL }}
      path: {{ init.gitRepositoryPath }}
      targetRevision: {{ init.targetRevision }}
      manifestId: {{ init.manifestId }} 
      applicationEnabled: {{ init.applicationEnabled }}{% endfor %}
  repository:
    {%- for init in services.coreServices.system.argocd.init %}
    - url: "{{ init.gitRepositoryURL }}"
      username: "{{ init.gitRepositoryUser }}"
      password: "{{ init.gitRepositoryPAT }}"
      manifestId: {{ init.manifestId }}
      repositoryEnabled: {{ init.repositoryEnabled }}
      insecure: "false"
      forceHttpBasicAuth: "true" {% endfor %}

ingress:
  enabled: {{ services.coreServices.system.argocd.ingress.enabled }}
  host: "{{ services.coreServices.system.argocd.ingress.hostname }}"
  issuer: "{{ services.coreServices.system.argocd.ingress.issuer }}"
  className: "{{ services.coreServices.system.argocd.ingress.className }}"


argo-cd:
  global:
    revisionHistoryLimit: "{{ services.coreServices.system.argocd.revisionHistory }}"
    image:
      repository: "{{ services.coreServices.system.argocd.globalImageRepository }}"
  dex:
    enabled: false
    env:
      - name: HTTP_PROXY
        value: '{{ services.defaults.defaultHttpProxy }}'
      - name: HTTPS_PROXY
        value: '{{ services.defaults.defaultHttpProxy }}'
      - name: http_proxy
        value: '{{ services.defaults.defaultHttpProxy }}'
      - name: https_proxy
        value: '{{ services.defaults.defaultHttpProxy }}'
      - name: no_proxy
        value: "{{ services.defaults.defaultNoProxy }}"
      - name: NO_PROXY
        value: "{{ services.defaults.defaultNoProxy }}, {{services.coreServices.system.argocd.additionalNoProxy}}"
  server:
    replicas: {{ services.coreServices.system.argocd.server.replicas }}
    ## Argo CD server Horizontal Pod Autoscaler
    autoscaling:
      # -- Enable Horizontal Pod Autoscaler ([HPA]) for the Argo CD server
      enabled: {{ services.coreServices.system.argocd.server.autoscalingEnabled | lower }}
      # -- Minimum number of replicas for the Argo CD server [HPA]
      minReplicas: {{ services.coreServices.system.argocd.server.autoscalingMinReplica }}
      # -- Maximum number of replicas for the Argo CD server [HPA]
      maxReplicas: {{ services.coreServices.system.argocd.server.autoscalingMaxReplica }}
    env:
    - name: HTTP_PROXY
        value: '{{ services.defaults.defaultHttpProxy }}'
      - name: HTTPS_PROXY
        value: '{{ services.defaults.defaultHttpProxy }}'
      - name: http_proxy
        value: '{{ services.defaults.defaultHttpProxy }}'
      - name: https_proxy
        value: '{{ services.defaults.defaultHttpProxy }}'
      - name: no_proxy
        value: "{{ services.defaults.defaultNoProxy }}"
      - name: NO_PROXY
        value: "{{ services.defaults.defaultNoProxy }}, {{services.coreServices.system.argocd.additionalNoProxy}}"
  repoServer:
    replicas: {{ services.coreServices.system.argocd.repoServer.replicas }}
    ## Repo server Horizontal Pod Autoscaler
    autoscaling:
      # -- Enable Horizontal Pod Autoscaler ([HPA]) for the repo server
      enabled: {{ services.coreServices.system.argocd.repoServer.autoscalingEnabled | lower }}
      # -- Minimum number of replicas for the Argo CD server [HPA]
      minReplicas: {{ services.coreServices.system.argocd.repoServer.autoscalingMinReplica }}
      # -- Maximum number of replicas for the Argo CD server [HPA]
      maxReplicas: {{ services.coreServices.system.argocd.repoServer.autoscalingMaxReplica }}
    env:
      - name: HTTP_PROXY
        value: '{{ services.defaults.defaultHttpProxy }}'
      - name: HTTPS_PROXY
        value: '{{ services.defaults.defaultHttpProxy }}'
      - name: http_proxy
        value: '{{ services.defaults.defaultHttpProxy }}'
      - name: https_proxy
        value: '{{ services.defaults.defaultHttpProxy }}'
      - name: no_proxy
        value: "{{ services.defaults.defaultNoProxy }}"
      - name: NO_PROXY
        value: "{{ services.defaults.defaultNoProxy }}, {{services.coreServices.system.argocd.additionalNoProxy}}"
  ## Application controller
  controller:
    replicas: {{ services.coreServices.system.argocd.controller.replicas }}
  applicationSet:
    replicaCount: "{{ services.coreServices.system.argocd.applicationSetController.replicas }}"
  redis:
    image:
      repository: {{ services.coreServices.system.argocd.redisImageRegistry }}