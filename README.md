# platform-infra

## initialize

```shell
make tool
```

# platform-manifest

## initialize project

1. generate key  
    ```shell
    make key
    ```
1. set `public key` to `key` in `script/encrypt.sh`  
    ```
    key=${public key}
    ```
1. set secret key as name `SOPS_AGE_KEY` to `Settings` > `Secrets` in `Octeto`

## create app

1. create helm charts

```shell
helm create <app-name>
```

# platform-terraform

## Terraform Cloud Workspaces Initialize

0. https://app.terraform.io/app
1. `Create a workspace`
2. choose `API-driven workflow`
3. Workspace Name: `platform-$ENV` (`prev` or `prod`)  
4. `Settings` > `General` > `Execution Mode` -> select `Local` -> `Save settings`

## Setup Local PC

```shell
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

```shell
brew install gettext
```

## Update .terraform.lock.hcl

.secret.env
```
TF_TOKEN_app_terraform_io=*********
```

```shell
make tfinit
```

## Initialize SOPS (Secrets)

1. generate key
    ```shell
    make tfkey
    ```
1. set `public key` to `key` in `script/tfencrypt.sh`  
1. set `private key` to `SOPS_AGE_KEY` in `Settings` > `Secrets and variables` > `Actions` > `New repository secret` in `GitHub`

## Add new secret

1. execute `make tfsecret secret=${secret}`  
    ex)
    ```shell
    make tfsecret secret=password
    ```
1. set in the secret value in `terraform/sops/${secret}.in.txt`
1. execute `make tfencrypt secret=${secret}`  
    ex)
    ```shell
    make tfencrypt secret=password
    ```

## Change secret

1. change `terraform/sops/${secret}.in.txt`
1. execute `make tfencrypt secret=${secret}`  
    ex)
    ```shell
    make tfencrypt secret=password
    ```

## Confirm secret value
1. execute `make tfdecrypt secret=${secret}`  
    ex)
    ```shell
    make tfdecrypt secret=password
    ```
1. confirm `terraform/sops/${secret}.out.txt`

## Q&A

Q. What if you want to delete the resource for each provider?

A. If the provider is deleted, the resource cannot be deleted. Let's remove the resource first. and merge. Then remove the provider.
