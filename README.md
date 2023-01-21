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

## add secret manifest

1. execute `make secret secret=${secret}`  
    ex)
    ```bash
    make secret secret=password
    ```
1. set in the secret value in `k8s/templates/secret/${secret}.in.txt`
1. execute `make encrypt secret=${secret}`  
    ex)
    ```bash
    make encrypt secret=password
    ```
1. fill in `./sops --decrypt --in-place k8s/templates/secret/{secret}.yaml` to `octeto/sops.sh`

## change secret

1. change `k8s/templates/secret/${secret}.in.txt`
1. execute `make encrypt secret=${secret}`  
    ex)
    ```bash
    make encrypt secret=password
    ```

## change secret

1. set in the secret value in `k8s/templates/secret/${secret}.in.txt`
1. execute `make encrypt secret=${secret}`  
    ex)
    ```bash
    make encrypt secret=password
    ```

## confirm secret @Local
1. secret key in `.secret.env`
    ```bash
    SOPS_AGE_KEY=xxx
    ```
1. execute `make decrypt secret=${secret}`  
    ex)  
    ```bash
    make make decrypt secret=password
    ```
1. confirm `k8s/templates/secret/${secret}.out.txt`

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
