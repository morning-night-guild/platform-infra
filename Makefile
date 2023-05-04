include .secret.env
export

.PHONY: help
help: ## Display this help screen
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: tool
tool: ## Instal tool
	@aqua i

.PHONY: ymlfmt
ymlfmt: ## Fromat yaml
	@yamlfmt

.PHONY: helmlint
helmlint: ## Lint helm chart
	@for chart in $(find charts -type d -depth 1) ; do \
      helm lint ${chart}; \
    done

.PHONY: chart
chart: ## Create helm chart. ex) make chart chart=app
	@(cd charts && helm create ${chart})

.PHONY: tfinit
tfinit: ## Terraform initialize
	@(cd terraform && terraform init)

.PHONY: tfmt
tfmt: ## Terraform format
	@terraform fmt -recursive

.PHONY: tflint
tflint: ## Terraform format check and terraform validate
	@terraform fmt -recursive -check
	@terraform validate

.PHONY: tfkey
tfkey: ## Generate key for sops
	@age-keygen

.PHONY: tfsecret
tfsecret: ## Create terraform secret yaml. ex) make secret secret=password
	@script/tfsecret.sh ${secret}

.PHONY: tfencrypt
tfencrypt: ## Encrypt terraform secret. ex) make encrypt secret=password
	@script/tfencrypt.sh ${secret}

.PHONY: tfdecrypt
tfdecrypt: ## Decrypt terraform secret. ex) make decrypt secret=password
	@script/tfdecrypt.sh ${secret}

.PHONY: tfsops
tfsops: ## Operation check of sops. The result is output under tmp.
	@script/tfsops.sh
