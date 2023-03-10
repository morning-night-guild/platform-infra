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

.PHONY: key
key: ## Generate key
	@age-keygen

.PHONY: secret
secret: ## Create kubernates secret yaml. ex) make secret env=dev secret=password
	@secret/secret.sh ${env} ${secret}

.PHONY: encrypt
encrypt: ## Encrypt kubernates secret. ex) make encrypt env=dev secret=password
	@secret/encrypt.sh ${env} ${secret}

.PHONY: decrypt
decrypt: ## Decrypt kubernates secret. ex) make decrypt env=dev secret=password
	@secret/decrypt.sh ${env} ${secret}

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

.PHONY: tfdev
tfdev: ## Make terraform develop backend.tf
	@(cd terraform && ENV=dev envsubst '$$ENV' < backend.tf.template > backend.tf)
