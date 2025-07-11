# AWS Infrastructure as Code (IaC) — Terraform Project

## Overview

This project provisions a secure, scalable AWS infrastructure using **Terraform modules**. It is designed to deploy:

* A VPC with public, private API, and private database subnets across two Availability Zones.
* An EKS cluster hosting multiple microservices.
* NAT Gateways for outbound internet from private subnets.
* Load Balancers (ALB/NLB) for public access.
* VPC Flow Logs to monitor traffic.
* Remote state management with S3 and DynamoDB.

---

## Architecture Summary

**VPC CIDR Block**: `10.0.0.0/16`

| AZ           | Public Subnet | Private API Subnet | Private DB Subnet |
| :----------- | :------------ | :----------------- | :---------------- |
| `us-east-2a` | `10.0.1.0/24` | `10.0.11.0/24`     | `10.0.12.0/24`    |
| `us-east-2b` | `10.0.2.0/24` | `10.0.21.0/24`     | `10.0.22.0/24`    |

---

## Project Structure

```
infrastructure/
├── env/
│   └── dev/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       ├── terraform.tfvars
│       └── backend.tf
├── modules/
│   ├── network/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── versions.tf
│   └── eks/
│       └── ...
└── README.md
```

---

## Pre-Requisites

* AWS CLI installed & configured
* Terraform v1.6+ installed
* AWS IAM User with permissions: VPC, EC2, EKS, IAM, Load Balancer
* S3 bucket for remote state
* DynamoDB table for state locking

---

## Remote State Configuration

**env/dev/backend.tf:**

```hcl
terraform {
  backend "s3" {
    bucket         = "eks-my-tfstate-bucket"
    key            = "eks/network/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
```

> Create these manually:

* S3 bucket: `eks-my-tfstate-bucket`
* DynamoDB table: `terraform-lock` (Partition Key: `LockID`)

---

## Deployment Process

### 1. Initialize Terraform

```bash
terraform init
```

### 2. Validate Configuration

```bash
terraform validate
```

### 3. Plan Deployment

```bash
terraform plan -out=tfplan
```

### 4. Apply Infrastructure

```bash
terraform apply "tfplan"
```

---

## Module Outputs

| Output Name        | Description                 |
| :----------------- | :-------------------------- |
| `vpc_id`           | VPC ID                      |
| `public_subnets`   | List of Public Subnet IDs   |
| `private_subnets`  | List of Private Subnet IDs  |
| `database_subnets` | List of Database Subnet IDs |
| `igw_id`           | Internet Gateway ID         |
| `nat_gateway_ips`  | NAT Gateway IPs             |
| `vpc_flow_log_arn` | ARN of the VPC Flow Logs    |
| `route53_zone_id`  | Route53 Hosted Zone ID      |

---

## Clean Up Infrastructure

```bash
terraform destroy
```

> ⚠️ Do not delete your S3 bucket and DynamoDB table if you need to retain state history.

---

## Features & Best Practices

* Multi-AZ, highly available VPC architecture
* Segregated subnets for APIs and Databases
* NAT Gateways for secure outbound traffic
* VPC Flow Logs for network monitoring
* Remote state management with S3 and DynamoDB
* Modular, reusable, and clean Terraform code
* Validated and commented configuration files

---

## 📞 Contact

**Ramratan**
DevOps Engineer
📧 [ram.yadav.snaatak@mygurukulam.co](mailto:ram.yadav.snaatak@mygurukulam.co)

---

> Clean, secure, production-ready AWS infrastructure built using Terraform modules.
