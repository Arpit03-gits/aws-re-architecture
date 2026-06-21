# 💰 Cost Analysis — Before vs After

## Before (On-Premises / Old Setup)

| Item                    | Monthly Cost (USD) |
|-------------------------|-------------------|
| Physical Server Lease   | $800              |
| Colocation / Data Center| $400              |
| Network / Bandwidth     | $200              |
| DBA / IT Admin Labor    | $500              |
| Backup Storage          | $100              |
| **Total**               | **$2,000/month**  |

---

## After (AWS Re-Architecture)

| AWS Service             | Config                     | Monthly Cost (USD) |
|-------------------------|----------------------------|--------------------|
| EC2 Auto Scaling (x2)   | t3.medium, On-Demand        | $120              |
| RDS Aurora              | db.t3.medium, Multi-AZ      | $200              |
| Application Load Balancer | Standard                  | $20               |
| S3 Storage              | 100 GB                     | $3                |
| CloudFront              | 1 TB transfer              | $85               |
| Route 53                | 1 hosted zone              | $1                |
| NAT Gateway             | Standard usage             | $35               |
| CloudWatch              | Logs + Metrics             | $15               |
| Secrets Manager         | 2 secrets                  | $1                |
| **Total**               |                            | **$480/month**    |

---

## Savings Summary

| Metric              | Value         |
|---------------------|--------------|
| Old Monthly Cost    | $2,000        |
| New Monthly Cost    | $480          |
| **Monthly Savings** | **$1,520**    |
| **Annual Savings**  | **$18,240**   |
| **Cost Reduction**  | **~76%**      |

---

## Additional Value (Non-Cost Benefits)

- 📈 **Scalability**: Auto-scales to handle 3x traffic spike with zero manual effort
- 🔁 **High Availability**: 99.99% uptime SLA vs ~95% before
- 🔒 **Security**: Managed patching, WAF, encryption — reducing risk
- ⏱️ **Deployment Speed**: CI/CD reduces release time from hours to minutes
- 🛠️ **Reduced Ops Overhead**: Managed services reduce manual maintenance

> 💡 *Costs are estimates. Use the [AWS Pricing Calculator](https://calculator.aws.amazon.com) to customize for your usage.*
