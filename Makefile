.PHONY: help ps build build-prod start fresh fresh-prod stop restart destroy \
	cache cache-clear migrate migrate migrate-fresh tests tests-html

CONTAINER_PHP=php
CONTAINER_REDIS=redis
CONTAINER_DATABASE=	database
VOLUME_DATABASE=my-laravel-project_db_data


help: ## Print help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

auth: ## Authenticate your Docker client to your registry. Use the AWS CLI:
	@aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 339712724064.dkr.ecr.eu-central-1.amazonaws.com

build: ## Build our prod image.
	@docker build -t prod-my-laravel-project-base-image .

push: ## Push our prod image to ECR.
	@docker tag prod-my-laravel-project-base-image:latest 339712724064.dkr.ecr.eu-central-1.amazonaws.com/prod-my-laravel-project-base-image:latest
	@docker push 339712724064.dkr.ecr.eu-central-1.amazonaws.com/prod-my-laravel-project-base-image:latest

