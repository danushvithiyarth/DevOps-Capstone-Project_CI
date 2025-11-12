# 🧩 DevOps Capstone Project – CI & IaC Repository

## 📘 Overview
This repository contains the **Continuous Integration (CI)** and **Infrastructure as Code (IaC)** automation for my **DevOps Capstone Project**.  
The goal is to design a fully automated DevOps pipeline using **AWS, Terraform, Jenkins, Docker, SonarQube, Nexus, OWASP, Trivy, and ArgoCD**, following **GitOps principles** and real-world best practices.

---

## 🧱 Source Application
The application used in this project is based on the open-source **Multi-Tier Bank Application**.  
Only the **application source code and related build configuration files** were referenced from the original repository.

| Component | Source Repository | Description |
|------------|------------------|--------------|
| Application Code | [Multi-Tier-BankApp-CI](https://github.com/jaiswaladi246/Multi-Tier-BankApp-CI.git) | Used as the base Java source and build configuration for the banking application. All DevOps automation and infrastructure configurations are self-developed. |

---

## 🏗️ Infrastructure Overview (Terraform + Jenkins)

### ⚙️ IaC Machine (Infrastructure Automation Node)
- Dedicated EC2 instance on AWS.
- Installed tools: **Jenkins**, **Terraform**.
- Purpose: To automate creation and destruction of all other machines (**CI**, **Sonar/Nexus**, and **CD**) through Jenkins pipelines.
- No monitoring setup — used strictly for IaC automation.

### 🔧 Infrastructure Provisioned
Terraform scripts handle creation of:
- **1 VPC** with public and private subnets.
- **3 EC2 instances (t3.large)** for:
  1. CI Server  
  2. SonarQube & Nexus Server  
  3. CD & Kubernetes Deployment Server  

---

### 🧱 Terraform Apply Pipeline
Automates provisioning of infrastructure components on AWS.

**Features:**
- Parameterized `autoApprove` flag for safe/manual control.
- Uses AWS credentials securely from Jenkins credentials store.
- Runs Terraform `init`, `fmt`, `plan`, and `apply` stages.
- Preview of Terraform plan before apply.
- Manual approval step (unless autoApprove = true).

---

### 🧨 Terraform Destroy Pipeline
Destroys AWS resources created by Terraform.

**Features:**
- Shows current Terraform state before destruction.
- Manual approval before executing `terraform destroy -auto-approve`.
- Ensures safe teardown of infra resources.

---

### ☁️ AWS Monitoring for Infra
- **AWS CloudWatch** tracks EC2 instance metrics.
- **SNS Topic** sends email alerts when CPU utilization exceeds 80%.
- (Alert setup configured but not tested due to stress simulation limits.)

---

## ⚙️ Continuous Integration Setup

### 💻 Machine 1 – CI Server
- Tools Installed:
  - **Jenkins**
  - **Docker**
  - **Trivy**
- Integrations: **SonarQube**, **Nexus**, **OWASP Dependency Check**, **ArgoCD (GitOps)**

---

### 🔁 Jenkins CI Pipeline Stages

#### 1. **Checkout**
Clones the project from [DevOps-Capstone-Project_CI](https://github.com/danushvithiyarth/DevOps-Capstone-Project_CI.git).

#### 2. **Build & Test**
Builds the Java Spring Boot application (Multi-Tier-BankApp) using Maven.

#### 3. **Nexus Deployment**
Publishes Maven artifacts to Nexus repository via secure config file.

#### 4. **SonarQube Analysis**
Performs static code analysis for code quality and technical debt.

#### 5. **OWASP Dependency Check**
Scans project dependencies for known vulnerabilities.

#### 6. **Docker Image Build**
Builds Docker image with dual tags:
- `latest`
- `v<build_number>`

#### 7. **Trivy Image Scan**
Scans the built image for vulnerabilities and generates an HTML report.

#### 8. **Push to DockerHub**
Authenticates using Jenkins credentials and pushes images to:
> [DockerHub – danushvithiyarth/capstoneproject](https://hub.docker.com/r/danushvithiyarth/capstoneproject)

#### 9. **GitOps with ArgoCD**
- Clones the [CD repository](https://github.com/danushvithiyarth/DevOps-Capstone-Project_CD.git).
- Updates image version tag in `frontendapp.yaml`.
- Commits and pushes change using GitHub token.
- **Triggers ArgoCD** on CD server to automatically sync and deploy.

---

### 📊 Reports Generated
| Report | File |
|---------|------|
| OWASP Dependency Scan | `dependency-check-jenkins.html` |
| Trivy Image Scan | `report.html` |

---

### 🔐 Jenkins Credentials Used
| Purpose | Credential ID |
|----------|----------------|
| AWS Access Key | `Access_Key` |
| AWS Secret Key | `Secret_ID` |
| DockerHub Login | `Docker_pass` |
| GitHub Token (for GitOps updates) | `github-cerds` |
| SonarQube Connection | `sonar-server` |

---

## 🧠 Machine 2 – SonarQube, Nexus & Monitoring Server

### Configuration
- EC2 instance provisioned via Terraform.
- Tools Installed (as Docker containers):
  - **SonarQube**
  - **Nexus Repository**
  - **Prometheus**
  - **Grafana**

### Integration
- SonarQube and Nexus integrated with Jenkins on Machine 1.
- Prometheus scrapes Docker daemon metrics.
- Grafana visualizes system performance and container stats.

---

## 🧩 Architecture Summary

| Machine | Purpose | Key Tools |
|----------|----------|-----------|
| **IaC Machine** | Infrastructure automation (no monitoring) | Terraform, Jenkins |
| **Machine 1 – CI** | Build, test, scan, and push images | Jenkins, Maven, Docker, Trivy, SonarQube, Nexus |
| **Machine 2 – Sonar/Nexus** | Code quality, artifact management, and monitoring | SonarQube, Nexus, Prometheus, Grafana |
| **Machine 3 – CD** | Kubernetes deployment & GitOps (ArgoCD + Vault) | EKS, Helm, Vault, ArgoCD |

---

## 🧰 Tools & Technologies

| Category | Tools |
|-----------|-------|
| CI | Jenkins, Maven, SonarQube, OWASP, Trivy |
| IaC | Terraform |
| SCM | GitHub |
| Containers | Docker |
| Artifact Repository | Nexus |
| Image Registry | DockerHub |
| Monitoring | CloudWatch, Prometheus, Grafana |
| GitOps | ArgoCD |
| Cloud Provider | AWS (EC2, VPC, EKS) |

---

## 🏁 Workflow Summary

1. **Infrastructure Provisioning**
 
2. **CI Pipeline Execution**

3. **Continuous Deployment (CD)**

---

## 🌐 Repositories

| Repository | Description |
|-------------|-------------|
| [DevOps-Capstone-Project_CI](https://github.com/danushvithiyarth/DevOps-Capstone-Project_CI.git) | CI Pipelines, IaC setup, Terraform & Jenkins pipelines |
| [DevOps-Capstone-Project_CD](https://github.com/danushvithiyarth/DevOps-Capstone-Project_CD.git) | Kubernetes manifests, Helm charts, Vault, monitoring & alerts |
| [Multi-Tier-BankApp-CI (Source)](https://github.com/jaiswaladi246/Multi-Tier-BankApp-CI.git) | Source Java Spring Boot app used for this project’s CI build process |

---

## 🧾 Author

**👤 Danush Vithiyarth**  
💻 [GitHub: @danushvithiyarth](https://github.com/danushvithiyarth)

---

> 🧠 *This setup demonstrates a complete DevOps lifecycle — from Infrastructure as Code to Continuous Integration, GitOps-based Continuous Deployment, and real-time Monitoring — representing a modern, production-grade DevOps workflow.*
