[![Terraform](https://img.shields.io/badge/Terraform-1.5-green)](https://www.terraform.io/) [![AWS](https://img.shields.io/badge/AWS-us--east--1-blue)](https://aws.amazon.com/) [![License](https://img.shields.io/badge/License-Apache%202.0-blue)](LICENSE)

---

<details>
<summary>📖 Table of Contents</summary>

1. [Real-World Problem](#real-world-problem)  
2. [Existing Solutions](#existing-solutions)  
3. [Solution Comparison](#solution-comparison)  
4. [Proposed Solution](#proposed-solution)  
5. [Detailed Architecture](#detailed-architecture)  
6. [Project Structure](#project-structure)  
7. [Quick Start](#quick-start)  
8. [Contributing](#contributing)  
9. [License](#license)  
</details>

---

## Real-World Problem  
> Healthcare applications handling PHI must ensure **strict isolation**, **99.9% uptime**, and **auditability** (HIPAA § 164.312). Classic single-VPC designs risk data exposure via broad egress and incur high NAT costs (~\$0.045/GB), while manual drift remediation threatens compliance.

---

## Existing Solutions  
1. **Single-VPC per Environment**
   - Utilizes NAT Gateway for Internet egress.
   - Requires manual security group updates.
   - Employs VPC Flow Logs directed to CloudWatch.

2. **Transit Gateway Hub-and-Spoke**
   - Offers centralized connectivity.
   - Reduces peering overhead.
   - Involves higher transit fees.

3. **Third-Party SDN Appliances**
   - Provides fine-grained micro-segmentation.
   - Introduces licensing and operational complexity.
---

## Solution Comparison  

| 🔑 Feature                 | Single-VPC         | Transit GW        | SDN Appliance     | **This Project**             |
|----------------------------|--------------------|-------------------|--------------------|------------------------------|
| **Isolation**              | 🔸 Limited         | 🔹 Strong         | 🔹 Strong          | 🔹 Dedicated multi-AZ VPCs   |
| **Cost Control**           | 🔸 High NAT fees   | 🔸 Transit fees   | 🔸 Licensing       | 🔹 Free Gateway Endpoints    |
| **Automation**             | 🔸 Manual          | 🔹 Partial        | 🔸 Manual          | 🔹 Terraform + CI/CD         |
| **Audit & Remediation**    | 🔸 Manual          | 🔸 Custom scripts | 🔸 Manual          | 🔹 AWS Config + Sentinel     |
| **Operational Complexity** | 🔹 Low             | 🔸 High           | 🔸 High            | 🔹 Moderate, opinionated     |

---

## Proposed Solution  
A **Shared-Services VPC** centralizes NAT and Gateway Endpoints (S3, DynamoDB) for cost savings, peered to **Environment-Specific VPCs**. All infra is declared in **Terraform modules**, with **CI/CD**, **drift detection**, and **auto-remediation** for a fully compliant, scalable architecture.

---

## Detailed Architecture  

### 📦 Modules  
### 1. Modular Terraform Architecture

- **Reusable modules**: `vpc`, `subnets`, `nat-gateway`, `flow-logs`, `shared-services`, `monitoring`.
- **Version-pinned providers**: Terraform `>=1.5,<2.0`; AWS provider `~>4.0`.

### 2. Shared-Services VPC

- **High-availability NAT Gateways** and **Gateway Endpoints** (S3, DynamoDB) to eliminate per-GB NAT charges.
- **VPC Peering** to dev/staging/prod VPCs for centralized egress and AWS service access.

### 3. Environment VPCs

- **Public & private subnets** across multiple Availability Zones for fault tolerance.
- **Layered security groups** (management, application, data) to enforce least-privilege networking.

### 4. Compliance & Automated Remediation

- **AWS Config Rules** (`vpc-flow-logs-enabled`, `restricted-cidrs`) with **AWS managed remediations** via Systems Manager.
- **Terraform Sentinel policies** in Terraform Cloud to block insecure changes before apply.

### 5. CI/CD & Drift Management

- **GitHub Actions** workflows:
  - `lint-validate.yml`: Terraform formatting and validation.
  - `terraform-plan.yml`: Generates and annotates plans.
  - `terraform-apply.yml`: Applies changes with manual approvals.
  - `drift-detect.yml`: Scheduled daily drift detection runs.

### 6. Monitoring & Logging

- **VPC Flow Logs** directed to CloudWatch Logs, then to Kinesis Firehose, and stored in S3 with 365-day retention.
- **CloudWatch Alarms** on NAT Gateway egress and Flow Log errors, notifying via SNS.


---
## 🧗 Challenges Faced

### 1. Navigating Complex HIPAA Regulations

Interpreting and implementing HIPAA's intricate and evolving guidelines posed significant challenges, especially in translating legal requirements into technical controls.

### 2. Balancing Security and Usability

Implementing stringent security measures without hindering user experience required careful planning to avoid friction and ensure compliance.

### 3. Managing Terraform State

Ensuring consistent and secure management of Terraform state files across multiple environments was critical to prevent configuration drift and maintain infrastructure integrity.

### 4. Ensuring Vendor Compliance

Working with third-party providers necessitated rigorous vetting to ensure their compliance with HIPAA standards, as any lapse could compromise the entire system's security posture.

### 5. Automating Compliance Checks

Developing automated systems for continuous compliance monitoring and remediation was essential to maintain adherence to regulatory requirements without manual intervention.

---

## Project Structure  
```text
secure-vpc-clinical/
├── globals/
│   ├── provider.tf       # AWS providers & assume_role
│   ├── versions.tf       # Terraform & provider constraints
│   ├── backend.tf        # S3 backend + SSE-KMS + DynamoDB lock
│   └── budgets.tf        # AWS Budgets alerts
│
├── modules/              # Reusable, documented modules
│   ├── vpc/              
│   ├── subnets/          
│   ├── nat-gateway/      
│   ├── security-groups/  
│   ├── flow-logs/        
│   ├── shared-services/  
│   └── monitoring/       
│
├── policies/             # Sentinel, AWS Config & SCPs
├── ci/                   # GitHub Actions workflows
├── environments/         # dev, staging, prod roots
├── scripts/              # init, secrets, validation
├── docs/                 # requirements, architecture, runbooks
├── .github/              # Dependabot config
├── LICENSE               
└── README.md             # This file
