VERSION := v1

# constuire les images
build:
	@echo "Build with version : $(VERSION)"
	@docker build -f Dockerfile.jenkins -t jenkins-ansible:$(VERSION) .
	@docker build -f Dockerfile.ubuntu-target -t ubuntu-target:$(VERSION) .
# lancer les conteneur
up:
	@docker compose up -d
