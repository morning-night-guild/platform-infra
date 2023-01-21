include .secret.env
export

.PHONY: tool
tool:
	@aqua i

.PHONY: ymlfmt
ymlfmt: ## YAML format
	@yamlfmt

.PHONY: tfinit
tfinit: ## Terraform initialize
	@(cd terraform && terraform init)

.PHONY: tfmt
tfmt: ## Terraform format
	@terraform fmt -recursive

.PHONY: tflint
tflint: ## Terraform format check and terraform validate
	@terraform fmt -recursive -check && \
	terraform validate

.PHONY: tfdev
tfdev: ## Make terraform develop backend.tf
	@(cd terraform && ENV=dev envsubst '$$ENV' < backend.tf.template > backend.tf)

.PHONY: key
key:
	@age-keygen

.PHONY: secret
secret: ## Create kubernates secret yaml. ex) make secret secret=password
	@script/secret.sh ${secret}

.PHONY: encrypt
encrypt: ## Encrypt kubernates secret. ex) make encrypt secret=password
	@script/encrypt.sh ${secret}

.PHONY: decrypt
decrypt: ## Decrypt kubernates secret. ex) make decrypt secret=password
	@script/decrypt.sh ${secret}

.PHONY: help
help: ## Display this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
