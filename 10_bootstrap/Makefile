.PHONY: all

all: init plan apply plan-with-exit-code

init:
	@echo "Removing cached terraform modules."
	@rm -Rf .terraform/modules
	@echo "Initialising terraform"
	@terraform init -reconfigure
	@echo "Validating terraform code"
	@terraform validate -no-color

plan:

	@echo "Running terraform plan."
	@terraform plan -no-color -refresh=true

plan-out:

	@echo "Running terraform plan."
	@terraform plan -no-color -refresh=true -out=plan.out

apply:
	@echo "Deploying the infrastructure."
	@terraform apply -no-color -auto-approve