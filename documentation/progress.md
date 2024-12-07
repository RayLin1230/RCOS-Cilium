*Raymond Lin - Fall 2024*
*Ubuntu, i.e. Linux, User*
*Document My Progress*

As instructed by the lead Sam, I will be using this file to document anything I've learned or done for the project over the span of the semester.

Sam instructed us to follow the instructions in the startup.md file in the Heather branch of the main project. 

The document began with recommending me to use Linux or WSL. I have used Ubuntu before because of a previous RCOS project I've done. Ubuntu is Linux, so I'll use that to work on this project. The document also stated I should read the onboarding.md before continuing on.

As instructed I opened the onboarding.md file and started reading it. As implied by the name of the file, the purpose of the file is to help newcomers like me to go through the onboarding process for the project.

The document first introduces me to Cilium(1), Kubernetes(2), and Terraform(3). I also watched introductory videos on these new terms to better understand what they are, their use cases, and how they work together in a cloud-native environment. This helped me familiarize myself with the setup process and some key concepts behind these tools. 

The document then showcases the files breakdown to me:
main.tf: Defines the core infrastructure components like resource groups, virtual networks, subnets, and Kubernetes clusters.
variables.tf: Holds customizable deployment variables such as client credentials and location.
versions.tf: Specifies provider versions and ensures compatibility with Terraform.

After I finished reading the onboarding.md and understand the basics of the project project, I went back to the startupd.md to continue going through the document. 

The document instructs me to install Terraform and provides a link to me. I click on the link and follow the instructions provided to me for a Ubuntu/Linux user.
I installed the gnupg, software-properties-common, and curl packages as they are needed before I can install HashiCorp's Debian package repository:
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
I installed the HashiCorp GRP key:
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
I verify the key's fingerprint:
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
I add the official HashiCorp repository to my system:
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
I download the package information from HashiCorp:
sudo apt update
I installed Terraform from the new repository:
sudo apt-get install terraform

The document instructs me to install Cilium CLI and provides me a link. I click on the link and follow the instructions to install the latest version of the Cilium CLI for Linux.
CILIUM_CLI_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/cilium-cli/main/stable.txt)
CLI_ARCH=amd64
if [ "$(uname -m)" = "aarch64" ]; then CLI_ARCH=arm64; fi
curl -L --fail --remote-name-all https://github.com/cilium/cilium-cli/releases/download/${CILIUM_CLI_VERSION}/cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}
sha256sum --check cilium-linux-${CLI_ARCH}.tar.gz.sha256sum
sudo tar xzvfC cilium-linux-${CLI_ARCH}.tar.gz /usr/local/bin
rm cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}

The document instructs me to install Kubectl and miniKube and provides me a link. I click on the link and follow the instructions. 

The document instructs me on how to set up the environment and I attempt to do so. 
In the command line, I run:
terraform init - this sets up Terraform to run the configuration by initializing the backend and installing the plugins for the providers defined in the configuration.
terraform plan - displays what actions Terraform will perform when I apply the configuration. It doesn't make any changes to real resources but shows me a preview of what will happen.
terraform apply - Terraform asked me to confirm that I want to perform the actions detailed in the plan. I typed yes to proceed. This process took several minutes as Terraform worked to set up my EKS cluster and all the associated resources

The Terraform apply was successful, so I configured kubectl to interact with my new EKS cluster. I used the AKS CLI to update my kubeconfig file with the context of my new cluster: 
az aks get-credentials --resource-group RCOS-Cilium_group --name test-aks
I verified that I can connect to my Kubernetes cluster by running: 
kubectl get nodes

Everything seemed to work and I successfully set up Cilium to run within a Kubernetes environment using Minikube, ensuring that both systems are working together. To avoid extra costs I ran: 
terraform destroy

I downloaded the latest version of Microsoft Azure(4) for Linux, specifiically for Ubuntu, by following the instructions on this site: https://learn.microsoft.com/en-us/cli/azure/install-azure-cli
I get the packages needed for the installation process:
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release
I download and install the Microsoft signing key:
sudo mkdir -p /etc/apt/keyrings
curl -sLS https://packages.microsoft.com/keys/microsoft.asc |
  gpg --dearmor | sudo tee /etc/apt/keyrings/microsoft.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/microsoft.gpg
I add the Azure CLI software repository:
AZ_DIST=$(lsb_release -cs)
echo "Types: deb
URIs: https://packages.microsoft.com/repos/azure-cli/
Suites: ${AZ_DIST}
Components: main
Architectures: $(dpkg --print-architecture)
Signed-by: /etc/apt/keyrings/microsoft.gpg" | sudo tee /etc/apt/sources.list.d/azure-cli.sources
I update repository information and install the azure-cli package:
sudo apt-get update
sudo apt-get install azure-cli
Everything seems to be in working order.

I logged into the Microsoft Azure student account. 
I joined the HCP Terraform organization so that I could initialize that on my system.
I successfully connected with the HCP Terraform by HashiCorp. 
I was working on connecting to Microsoft Azure to observe the command outputs and assess how the setup operates in a cloud setting.

There were some issues with connecting to Microsfot Azure, as during the time I took to connect to Microsoft Azure we had apparently run out of credits for Microsoft Azure, so I wouldn't be able to conduct any testing. 
The project leads Sam and Ben said they would be working on getting credits by talking to an employee at Isovalent. 
We were instructed to look at the Cilium Performance Benchmark documentation in the meantime as it held useful information that we will be doing, so I did so: 
https://docs.cilium.io/en/stable/operations/performance/benchmark/

We were instucted to download Cilium Netperf, so I did so.
I downloaded Cilium Netperf for Linux:
sudo apt install netperf
There was some issues with running the Cilium Netperf, but I worked with teammates to figure out why.
Apparently, I did not install Cilium Cli correctly and Netperf is built in with the Cli, so I needed to isntall it correctly to be able to run Netperf correctly. 
I uninstalled Cilium Cli and followed the instructions on how to correctly install the Cli with the link I was given: 
https://github.com/cilium/cilium-cli 
Netperf seemed to work correctly now.
I was given documentation about Cilium Netperf, so I read it to better understand it and its role in benchmarking and performance testing:
https://hewlettpackard.github.io/netperf/doc/netperf.html#TCP_005fMAERTS

I was given a link to the github actions/workflow that were going to be adapting for use on this project, so I read it: 
https://github.com/cilium/cilium/tree/main/.github/workflows
I looked into Prometheus(5) and Grafana(6). I tried to understand how it works and how it applies to our project. By combining the two, we can visualize the data, along with all the features from Prometheus.
I was recommended to look at workflows that are labeled conformance Cloud Provider.yaml as it was relevant, so I did so: 
https://github.com/cilium/cilium-perf-networking
We were told by the project leads that they are still waiting for word from the Isolvaent employee on how we're getting access to Cilium repo, so we should just keep famaliarizing yourslef with the workflows and netperf in the meantime.

*About*
(1) Cilium is Kubernetes Cloud Network Interface(CNI). It helps manage data communication between applications in a Kubernetes cluster, enhancing security, visibility, and scalability. It does so by offering high-performance networking capabilities, including advanced routing, load balancing, and service discovery. Cilium secures traffic by controlling which applications can communicate and provides monitoring of traffic flow within the cluster.Specifically, it implements fine-grained network policies and enforces layer 7 (application layer) security controls. This enables administrators to define and enforce security policies based on application-layer attributes, such as HTTP headers or gRPC methods.  Cilium provides rich observability features by capturing detailed network traffic telemetry and integrating with monitoring and tracing systems like Prometheus and Jaeger. This enables operators to gain insights into network behavior and troubleshoot issues effectively.

(2) Kubernetes is a container orchestration. They are a platform to automate the deployment and management of containerized applications. Containers are self-contained units that hold everything an app needs to run, ensuring consistent behavior across environments. 

(3) Terraform is infrastructure provisioning and creation. It automates infrastructure management using Infrastructure as Code (IaC). It defines infrastructure (servers, networks) using configuration files in HCL (HashiCorp Configuration Language). It uses providers (like Azure, AWS) to deploy infrastructure. In the context of the project, Terraform creates a Kubernetes cluster on Azure Kubernetes Service (AKS), where Cilium is deployed to manage networking.

(4) Microsoft Azure is the cloud computing platform developed by Microsoft. It has management, access and development of applications and services to individuals, companies, and governments through its global infrastructure. It also provides capabilities that are usually not included within other cloud platforms, including software as a service (SaaS), platform as a service (PaaS), and infrastructure as a service (IaaS). Microsoft Azure supports many programming languages, tools, and frameworks, including Microsoft-specific and third-party software and systems.a managed kubernetes service. We use it as a managed kubernetes service. 

(5) Prometheus is an open-source monitoring system with a dimensional data model, flexible query language, efficient time series database and modern alerting approach. It is a way of gathering data about your system that includes timestamps so you can track when and how everything is working. We use it for metric scraping. 

(6) Grafana is a multi-platform open source analytics and interactive visualization web application. It can produce charts, graphs, and alerts for the web when connected to supported data sources. We use it for metric dashboard visualization. 