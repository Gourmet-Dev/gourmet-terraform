# gourmet-terraform

Gourmet terraform configurations

### Use this configuration to prevent the 'AWS Billing Management Console' rob your pocket!
* Use `terraform apply` to deploy the dev-infrastructures easily.
* When you have done your daily work, execute `terraform destroy` to clean up all things.
#### Detailed guide
1. Run `terraform init` in the environment directory which you want to perform terraformming.
2. After `terraform init` is completely done, you can simply deploy infrastructures with `terraform apply`.
3. Wait for AWS complete your deployment requests.
4. And then, apply the kubernetes configuration with `terraform output kubeconfig > ~/.kube/config`.
5. Check the liveness of your remote infrastructures using `kubectl version`; if your EKS has been configured successfully, it will return cluster versions.
6. Run `terraform output config_map_aws_auth > /tmp/eks_configmap.yml` and `kubectl apply -f /tmp/eks_configmap.yml`.
7. Have a good time with your EKS environment! XD

### Required permissions which must be lied to the IAM user.
#### For terraform
* iam:CreateRole
* AmazonEC2FullAccess
* AmazonEKSServicePolicy
#### For cluster
* eks:CreateCluster
* AmazonEKSClusterPolicy
* AmazonEKSVPCResourceController
#### For worker-node
* AmazonEC2ContainerRegistryReadOnly
* AmazonEKSWorkerNodePolicy
* AmazonEKS_CNI_Policy

### Trouble-shooting
##### Unexpected 'EOT' string from `terraform output` command.
1. Add `-raw` option to `terraform output`.
##### `kubectl` not working for my EKS cluster.
1. Make sure you installed [aws-iam-authenticator](https://docs.aws.amazon.com/ko_kr/eks/latest/userguide/install-aws-iam-authenticator.html) into the `$PATH`.
2. Export environment variables, `$AWS_ACCESS_KEY_ID` and `$AWS_SECRET_ACCESS_KEY`.
3. Create `~/.aws/credentials` with contents as the below format to preserve your AWS credential.
```yaml
[default]
aws_access_key_id = xxxxxxxxxxxxxxxxxxxx
aws_secret_access_key = xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```
