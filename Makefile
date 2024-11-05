# Variables
DOCKER_IMAGE_X86=libcoral-x86-builder
DOCKER_IMAGE_ARM=libcoral-arm-builder

# Build for x86
build-container-x86:
	docker build -t $(DOCKER_IMAGE_X86) -f Dockerfile.x86 .

run-container-x86:
	docker run --rm -v "$(CURDIR):/output" $(DOCKER_IMAGE_X86)

# Install x86
install-lib-x86:
	sudo tar -xzf libcoral-x86.tar.gz -C /usr/local/lib
	sudo ldconfig

# Build for ARM
build-container-arm:
	docker build -t $(DOCKER_IMAGE_ARM) -f Dockerfile.arm .

run-container-arm:
	docker run --rm -v "$(CURDIR):/output" $(DOCKER_IMAGE_ARM)

# Install on Coral Dev Board
install-lib-arm:
	@read -p "Enter hostname of the Coral Dev Board: " HOSTNAME; \
	scp libcoral-arm.tar.gz "$$HOSTNAME":~/ && \
	ssh "$$HOSTNAME" "sudo tar -xzf ~/libcoral-arm.tar.gz -C /usr/local/lib && sudo ldconfig && rm ~/libcoral-arm.tar.gz"

# Targets
x86: build-container-x86 run-container-x86 install-lib-x86
arm: build-container-arm run-container-arm install-lib-arm
