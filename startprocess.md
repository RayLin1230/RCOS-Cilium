*Raymond Lin - Fall 2024*
*Ubuntu, i.e. Linux/WSL, User*
*My Getting Started Process*

As instructed by the lead Sam, I will be using this file to document anything I've learned or done for the project over the span of the semester. I'll be explaining my learning process and will include anything I plan to do for the rest of the year.

Sam instructed us to follow the instructions in the startup.md file in the Heather branch of the main project. 

The document began with recommending me to use Linux or WSL. I have used Ubuntu before because of a previous RCOS project I've done. Ubuntu is Linux/WSL, so I'll use that to work on this project. The document also stated I should read the onboarding.md before continuing on.

As instructed I opened the onboarding.md file and started reading it. As implied by the name of the file, the purpose of the file is to help newcomers like me to go through the onboarding process for the project.

The document first introduces me to Cilium, Kubernetes, and Terraform. 

Kubernetes are a platform to automate the deployment and management of containerized applications. Containers are self-contained units that hold everything an app needs to run, ensuring consistent behavior across environments. 

Cilium helps manage data communication between applications in a Kubernetes cluster, enhancing security, visibility, and scalability. Cilium secures traffic by controlling which applications can communicate and provides monitoring of traffic flow within the cluster.

Terraform automates infrastructure management using Infrastructure as Code (IaC). It defines infrastructure (servers, networks) using configuration files in HCL (HashiCorp Configuration Language). It uses providers (like Azure, AWS) to deploy infrastructure. In the context of the project, Terraform creates a Kubernetes cluster on Azure Kubernetes Service (AKS), where Cilium is deployed to manage networking.
