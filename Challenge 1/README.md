#  Deploy the Jekyll Static Site Generator (SSG)

This repository contains the Kubernetes manifests and configuration scripts for deploying the **Jekyll SSG architecture** shown below.  
![Jekyll SSG Architecture](./kubernetes-challenge1-archi)

> **Note:**  
> The **PersistentVolume (`jekyll-pv`)** and **Namespace (`development`)** are already created, we do **not** need to recreate them.

---

<details>
<summary>Jekyll Pod</summary>

* pod: 'jekyll' has an initContainer, name: 'copy-jekyll-site', image: 'gcr.io/kodekloud/customimage/jekyll' and command: rm -rf /site/* && jekyll new /site && cd /site && bundle install  

* Container 'jekyll' should run the command: cd /site && bundle install && bundle exec jekyll serve --host 0.0.0.0 --port 4000  

* pod: 'jekyll', initContainer: 'copy-jekyll-site', mountPath = '/site'  

* pod: 'jekyll', initContainer: 'copy-jekyll-site', volume name = 'site'  

* pod: 'jekyll', container: 'jekyll', volume name = 'site'  

* pod: 'jekyll', container: 'jekyll', mountPath = '/site'  

* pod: 'jekyll', container: 'jekyll', image = 'gcr.io/kodekloud/customimage/jekyll-serve'  

* pod: 'jekyll', uses volume called 'site' with pvc = 'jekyll-site'  

* pod: 'jekyll' uses label 'run=jekyll'  


</details>
<details> <summary>Jekyll PersistentVolumeClaim</summary>
* Storage Request: 1Gi

* Access modes: ReadWriteMany

* pvc name = jekyll-site, namespace = development

* 'jekyll-site' PVC should be bound to the PersistentVolume called 'jekyll-site'

* PVC 'jekyll-site' should use storageClassName: 'local-storage'
</details>
<details> <summary>Jekyll Service</summary>
* Service name should be jekyll-node-service
* Service 'jekyll-node-service' uses targetPort: '4000'
* Service 'jekyll-node-service' uses Port: '4000
* Service 'jekyll-node-service' uses NodePort: '30097'
  
</details>
<details> <summary> Kube Config (User Martin) </summary>

* Build user information for martin in the default kubeconfig file: User = martin, client-key = /root/martin.key and client-certificate = /root/martin.crt

* Create a new context called 'developer' in the default kubeconfig file with 'user = martin' and 'cluster = kubernetes'

* set context 'developer' with user = 'martin' and cluster = 'kubernetes' as the current context

</details>
<details> <summary>Developer Role</summary>
* 'developer-role' should have all(*) permissions for services in development namespace

* 'developer-role' should have all(*) permissions for persistentvolumeclaims in development namespace

* 'developer-role' should have all(*) permissions for pods in development namespace

</details>
<details> <summary>Developer RoleBinding</summary>
* create rolebinding = developer-rolebinding, role= 'developer-role', namespace = development
* rolebinding = developer-rolebinding should be associated with user = 'martin'

</details>
