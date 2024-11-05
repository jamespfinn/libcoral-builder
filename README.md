# libcoral Cross-Compilation Environment

This project provides an automated setup for building the `libcoral` library for both x86 and ARM architectures. The goal is to create a reproducible, Docker-based environment that compiles `libcoral`, packages it, and installs it either locally (for x86) or on a Coral Dev Board (for ARM). By encapsulating the build process in Docker and automating it through a Makefile, we ensure a consistent build environment for both platforms.

## Purpose

The Coral Dev Board, powered by Edge TPU, enables on-device AI processing at high speeds with low power requirements. The `libcoral` library by Google provides a streamlined API for interacting with the Edge TPU hardware, making it a core component for running machine learning models on Coral devices. Cross-compiling `libcoral` for ARM allows developers to build on powerful x86_64 systems while deploying to embedded ARM devices like the Coral Dev Board.

## Prerequisites

Ensure you have the following installed on your system:

- Docker
- Make
- SSH access to your Coral Dev Board for ARM installation

### Note

The Makefile uses `scp` and `ssh` for installing the ARM build on the Coral Dev Board. Make sure the board is accessible over the network and that you have SSH credentials set up.

## Files and Structure

- `Dockerfile.x86`: Builds `libcoral` for x86_64.
- `Dockerfile.arm`: Cross-compiles `libcoral` for ARM.
- `Makefile`: Contains targets for building and running each Docker container, generating `.tar.gz` packages, and installing libraries for both architectures.

## Usage

The Makefile includes targets for building and installing `libcoral` on both x86_64 and ARM architectures.

### Steps

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/google-coral/libcoral.git
   cd libcoral
   ```

2. **Build and Install for x86_64**:

   - To build and install `libcoral` on the local x86_64 system:
     ```bash
     make x86
     ```
   - This command does the following:
     1. Builds a Docker image using `Dockerfile.x86`.
     2. Runs the Docker container, which builds and packages `libcoral` as `libcoral-x86.tar.gz`.
     3. Extracts and installs the library on the local system in `/usr/local/lib`.

3. **Build and Install for ARM**:

   - To cross-compile and install `libcoral` for ARM on a Coral Dev Board:
     ```bash
     make arm
     ```
   - This command performs these steps:
     1. Builds a Docker image using `Dockerfile.arm`.
     2. Runs the Docker container to build and package `libcoral` as `libcoral-arm.tar.gz`.
     3. Prompts for the hostname of your Coral Dev Board.
     4. Transfers the package to the Dev Board using `scp` and installs it in `/usr/local/lib`.

4. **Clean Up**:
   - To remove any intermediate files, Docker images, or containers, you can use:
     ```bash
     make clean
     ```
   - This will help keep your environment tidy, especially if you’re performing multiple builds.

## Directory Structure After Build

After running the build commands, you should have the following files generated in the current directory:

- `libcoral-x86.tar.gz`: Packaged x86_64 library.
- `libcoral-arm.tar.gz`: Packaged ARM library (after `make arm`).

These packages contain `libcoral` in the expected directory structure for installation, making it simple to deploy on both local systems and remote devices.

## Troubleshooting

1. **Docker Permission Errors**:
   If you encounter permissions errors when copying files from Docker, ensure Docker has appropriate permissions on your system. Run Docker commands with `sudo` if necessary.

2. **SSH/Network Errors for ARM Installation**:
   Ensure the Coral Dev Board is reachable over the network. Verify that SSH access is configured correctly with your credentials.

## Future Improvements

- **Automated Testing**: Set up tests to validate the functionality of `libcoral` after each build.
- **ARM Variants**: Support other ARM architectures if needed (e.g., ARMv7).
- **Containerization of the Makefile Process**: Encapsulate the entire Makefile process within Docker for easier distribution.

---

This setup should streamline the cross-compilation process and make it easy to deploy `libcoral` across different architectures reliably. Enjoy building with Coral!
