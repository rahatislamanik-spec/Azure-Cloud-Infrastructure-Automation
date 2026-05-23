# Azure Cloud Infrastructure & Automation

### Deploying, Securing, Governing, and Monitoring Azure Infrastructure End to End

**Md Rahat Islam Anik · George Brown College · Cloud Computing Technologies (T465) · Postgraduate**

[![GitHub Repo](https://img.shields.io/badge/GitHub-Repository-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/rahatislamanik-spec/azure-cloud-infrastructure-automation)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-rahatislamanik-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/rahatislamanik)

---

## Overview

This project covers the full Azure infrastructure lifecycle — from initial resource deployment through security hardening, governance, monitoring, and cost control. Every configuration was applied hands-on using the Azure Portal, Azure Cloud Shell, and Infrastructure as Code, reflecting the operational decisions an Azure administrator makes in a real cloud environment.

The work spans four core domains: infrastructure automation, operations and governance, security and secrets management, and cost visibility. Each area builds on the last — a deployment without governance is ungoverned, governance without monitoring is invisible, and monitoring without cost control is expensive.

---

## What Was Built

### Infrastructure & Automation

**Azure Resource Deployment — Portal and Cloud Shell**
Resources were deployed using both the Azure Portal for visual configuration and Azure Cloud Shell (Bash) for scripted, repeatable operations — mirroring the dual-mode approach used in enterprise Azure environments where some resources are provisioned interactively and others through pipelines.

**Infrastructure as Code — ARM Templates**
ARM templates were implemented to define and deploy Azure infrastructure declaratively. IaC removes the dependency on manual portal clicks, ensures consistent environments, and creates an auditable deployment record — foundational to any production Azure operation.

**Virtual Networking — Network Security Groups**
Secure virtual networking was configured using Network Security Groups (NSGs). Inbound and outbound traffic rules were defined to control resource exposure, restrict access by port and protocol, and enforce network-level segmentation between workloads.

**Serverless — Azure Functions**
Azure Functions were deployed and tested to support event-driven, serverless workloads — demonstrating the ability to extend cloud infrastructure beyond VMs and containers into lightweight compute that scales automatically.

---

### Operations & Governance

**Role-Based Access Control (RBAC)**
RBAC was implemented across Azure subscriptions to control who can do what to which resources. Role assignments were scoped at the appropriate level — subscription, resource group, or resource — following least-privilege principles to prevent over-permissioned access.

**Azure Monitor — Resource Health & Metrics**
Azure Monitor was configured to track resource health, availability, and operational metrics across the deployed environment. Monitoring is the operational layer that makes everything else visible — without it, failures and anomalies go undetected.

**Cost Management — Spending Visibility & Governance**
Azure Cost Management was used to track and optimize cloud spending across the environment. Cost governance prevents uncontrolled resource sprawl and is a core responsibility for any cloud operations role.

---

### Security & Secrets Management

**Azure Key Vault — Secrets & Encryption**
Azure Key Vault was implemented to centralize secrets management and encryption key handling. Credentials and configuration data were stored in Key Vault rather than hardcoded in scripts or templates — a non-negotiable security practice in any production Azure environment.

**Least-Privilege Access**
Least-privilege access principles were applied throughout — RBAC scoped tightly, Key Vault access policies restricted to required identities, and sensitive resources protected from over-exposure. Every permission granted was intentional.

---

## Tech Stack

| Category | Tools & Services |
|---|---|
| Cloud Platform | Microsoft Azure |
| Deployment | Azure Portal · Azure Cloud Shell (Bash) |
| Infrastructure as Code | ARM Templates |
| Networking | Virtual Networks · Network Security Groups (NSGs) |
| Compute | Azure Functions (Serverless) |
| Identity & Access | Role-Based Access Control (RBAC) |
| Security | Azure Key Vault · Least-Privilege Access |
| Monitoring | Azure Monitor |
| Cost Governance | Azure Cost Management |

---

## Skills Demonstrated

`Azure Resource Deployment` · `ARM Templates` · `Infrastructure as Code` · `Network Security Groups` · `RBAC` · `Azure Key Vault` · `Secrets Management` · `Azure Monitor` · `Azure Functions` · `Cost Management` · `Azure Cloud Shell` · `Least-Privilege Access` · `Cloud Governance`

---

## Screenshots

Configuration evidence from the live Azure environment — every screenshot documents a real deployment decision.

### ARM Template Deployment
![ARM Template Deployment](screenshots/ARM_Deployment_Complete.png)

### Resource Group Overview
![Resource Group Overview](screenshots/Resource_Group_Overview.png)

### Network Security Group Rules
![Network Security Group Overview](screenshots/Network_Security_Group_Overview.png)

### Azure Function Application
![Azure Function App Overview](screenshots/Azure_Function_App_Overview.png)

### Azure Cloud Shell (CLI)
![Azure Cloud Shell CLI](screenshots/Azure_Cloud_Shell_CLI.png)

---

## Author

**Md Rahat Islam Anik**
Cloud Computing & Network Administration · George Brown College · May 2026

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=flat&logo=linkedin)](https://linkedin.com/in/rahatislamanik)
[![GitHub](https://img.shields.io/badge/GitHub-Portfolio-181717?style=flat&logo=github)](https://github.com/rahatislamanik-spec)
