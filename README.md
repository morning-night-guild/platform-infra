# platform-infra

## initialize

```bash
make tool
```

# platform-manifest

## initialize project

1. generate key  
    ```bash
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

## add secret manifest

1. execute `make secret chart=${chart} secret=${secret}`  
    ex)
    ```bash
    make secret chart=app secret=password
    ```
1. set in the secret value in `charts/${chart}/templates/secret/${secret}.in.txt`
1. execute `make encrypt chart=${chart} secret=${secret}`  
    ex)
    ```bash
    make encrypt chart=app secret=password
    ```

## change secret

1. change `charts/${chart}/templates/secret/${secret}.in.txt`
1. execute `make encrypt chart=${chart} secret=${secret}`  
    ex)
    ```bash
    make encrypt chart=app secret=password
    ```

## change secret

1. set in the secret value in `charts/${chart}/templates/secret/${secret}.in.txt`
1. execute `make encrypt chart=${chart} secret=${secret}`  
    ex)
    ```bash
    make encrypt chart=app secret=password
    ```

## confirm secret @Local
1. secret key in `.secret.env`
    ```bash
    SOPS_AGE_KEY=xxx
    ```
1. execute `make decrypt chart=${chart} secret=${secret}`  
    ex)  
    ```bash
    make decrypt chart=app secret=password
    ```
1. confirm `charts/${chart}/templates/secret/${secret}.out.txt`

# platform-terraform

## Terraform Cloud Workspaces Initialize

0. https://app.terraform.io/app
1. `Create a workspace`
2. choose `API-driven workflow`
3. Workspace Name: `platform-$ENV` (`prev` or `prod`)  
4. `Settings` > `General` > `Execution Mode` -> select `Local` -> `Save settings`

## Setup Local PC

```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

```bash
brew install gettext
```

## Update .terraform.lock.hcl

.secret.env
```
TF_TOKEN_app_terraform_io=*********
```

```bash
make tfdev
make tfinit
```

## Q&A

Q. What if you want to delete the resource for each provider?

A. If the provider is deleted, the resource cannot be deleted. Let's remove the resource first. and merge. Then remove the provider.
