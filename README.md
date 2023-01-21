# platform-infra

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
