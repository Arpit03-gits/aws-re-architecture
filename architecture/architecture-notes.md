# 🏗️ Architecture Notes

## Overview

The re-architected solution uses a **3-tier architecture** on AWS:
1. **Presentation Layer** — CloudFront + ALB
2. **Application Layer** — EC2 Auto Scaling Group
3. **Data Layer** — RDS Aurora Multi-AZ

---

## VPC & Networking

- **VPC CIDR**: `10.0.0.0/16`
- **Public Subnets** (2 AZs): Host ALB and NAT Gateway
- **Private Subnets** (2 AZs): Host EC2 instances and RDS
- **Internet Gateway**: Attached to VPC for public internet access
- **NAT Gateway**: Allows private instances to reach the internet securely

```
VPC (10.0.0.0/16)
├── Public Subnet AZ-1 (10.0.1.0/24)  → ALB, NAT GW
├── Public Subnet AZ-2 (10.0.2.0/24)  → ALB
├── Private Subnet AZ-1 (10.0.3.0/24) → EC2, RDS Primary
└── Private Subnet AZ-2 (10.0.4.0/24) → EC2, RDS Replica
```

---

## Compute (EC2 + Auto Scaling)

- **Instance Type**: t3.medium (adjustable)
- **AMI**: Amazon Linux 2023
- **Auto Scaling**: Min=2, Desired=2, Max=6
- **Scaling Policy**: CPU > 70% triggers scale-out

---

## Load Balancer (ALB)

- **Type**: Application Load Balancer (Layer 7)
- **Listeners**: HTTP (80) → redirect to HTTPS (443)
- **Target Group**: EC2 instances on port 80
- **Health Check**: `/health` endpoint every 30s

---

## Database (RDS Aurora)

- **Engine**: Aurora MySQL 8.0 compatible
- **Multi-AZ**: Yes (automatic failover)
- **Instance**: db.t3.medium
- **Backup**: Automated daily, 7-day retention
- **Encryption**: At rest using AWS KMS

---

## Storage & CDN

- **S3 Bucket**: Private, versioning enabled
- **CloudFront**: Serves static assets globally
- **Cache TTL**: 86400s (24 hours) for static content
- **SSL/TLS**: ACM certificate attached to CloudFront

---

## Security Architecture

```
Internet → CloudFront (WAF) → ALB (SG: 443 only) → EC2 (SG: 80 from ALB) → RDS (SG: 3306 from EC2)
```

- **WAF Rules**: OWASP Top 10 managed rules
- **Security Groups**: Layered, least-privilege
- **IAM Roles**: EC2 instance profile (no hardcoded keys)
- **Secrets Manager**: DB credentials rotated every 30 days
