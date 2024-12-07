*Raymond Lin - Fall 2024*
*Ubuntu, i.e. Linux, User*
*Document My Progress*

As instructed by the lead Sam, I will be using this file to document anything I've learned or done for the project over the span of the semester.

Sam instructed us to follow the instructions in the startup.md file in the Heather branch of the main project. 

The document began with recommending me to use Linux or WSL. I have used Ubuntu before because of a previous RCOS project I've done. Ubuntu is Linux, so I'll use that to work on this project. The document also stated I should read the onboarding.md before continuing on.

As instructed I opened the onboarding.md file and started reading it. As implied by the name of the file, the purpose of the file is to help newcomers like me to go through the onboarding process for the project.

The document first introduces me to Cilium, Kubernetes, and Terraform. I also watched introductory videos on these new terms to better understand what they are, their use cases, and how they work together in a cloud-native environment. This helped me familiarize myself with the setup process and some key concepts behind these tools. 

Kubernetes are a platform to automate the deployment and management of containerized applications. Containers are self-contained units that hold everything an app needs to run, ensuring consistent behavior across environments. 

Cilium helps manage data communication between applications in a Kubernetes cluster, enhancing security, visibility, and scalability. Cilium secures traffic by controlling which applications can communicate and provides monitoring of traffic flow within the cluster.

Terraform automates infrastructure management using Infrastructure as Code (IaC). It defines infrastructure (servers, networks) using configuration files in HCL (HashiCorp Configuration Language). It uses providers (like Azure, AWS) to deploy infrastructure. In the context of the project, Terraform creates a Kubernetes cluster on Azure Kubernetes Service (AKS), where Cilium is deployed to manage networking.

The document then showcases the files breakdown to me.

main.tf: Defines the core infrastructure components like resource groups, virtual networks, subnets, and Kubernetes clusters.
variables.tf: Holds customizable deployment variables such as client credentials and location.
versions.tf: Specifies provider versions and ensures compatibility with Terraform.

After I finished reading the onboarding.md and understand the basics of the project project, I went back to the startupd.md to continue going through the document. 

The document instructs me to install Terraform and provides a link to me. I click on the link and follow the instructions provided to me for a Ubuntu/Linux user.

I installed the gnupg, software-properties-common, and curl packages as they are needed before I can install HashiCorp's Debian package repository. 
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

I installed the HashiCorp GRP key.
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

I verify the key's fingerprint.
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint

I add the official HashiCorp repository to my system.
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

I download the package information from HashiCorp.
sudo apt update

I install Terraform from the new repository.
sudo apt-get install terraform

The document instructs me to install Cilium CLI and provides me a link. I click on the link and follow the instructiosn to install the latest version of the Cilium CLI for Linux.
CILIUM_CLI_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/cilium-cli/main/stable.txt)
CLI_ARCH=amd64
if [ "$(uname -m)" = "aarch64" ]; then CLI_ARCH=arm64; fi
curl -L --fail --remote-name-all https://github.com/cilium/cilium-cli/releases/download/${CILIUM_CLI_VERSION}/cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}
sha256sum --check cilium-linux-${CLI_ARCH}.tar.gz.sha256sum
sudo tar xzvfC cilium-linux-${CLI_ARCH}.tar.gz /usr/local/bin
rm cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}