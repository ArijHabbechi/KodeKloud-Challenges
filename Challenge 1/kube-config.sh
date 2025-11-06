
#Build user information for martin in the default kubeconfig file: User = martin, client-key = /root/martin.key and client-certificate = /root/martin.crt
#Create a new context called 'developer' in the default kubeconfig file with 'user = martin' and 'cluster = kubernetes'
#set context 'developer' with user = 'martin' and cluster = 'kubernetes' as the current context

kubectl config set-credentials martin --client-certificate /root/martin.crt --client-key /root/martin.key

# 1. Create the context
kubectl config set-context developer --cluster=kubernetes --user=martin

# 2. Switch to it as the current context
kubectl config use-context developer
