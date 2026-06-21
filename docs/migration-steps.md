# 📋 Migration Steps

A step-by-step guide of how the web application was migrated and re-architected on AWS.

---

## Phase 1 — Assessment & Planning

- [ ] Audit existing on-premises infrastructure
- [ ] Identify application dependencies
- [ ] Define target AWS architecture
- [ ] Estimate costs using AWS Pricing Calculator
- [ ] Set migration timeline and rollback plan

---

## Phase 2 — AWS Account Setup

- [ ] Create AWS account and enable MFA on root
- [ ] Set up IAM users/roles with least privilege
- [ ] Enable AWS CloudTrail for audit logging
- [ ] Configure AWS Budgets and billing alerts
- [ ] Enable AWS Config for compliance tracking

---

## Phase 3 — Network Setup (VPC)

- [ ] Create VPC with CIDR `10.0.0.0/16`
- [ ] Create public subnets in 2 Availability Zones
- [ ] Create private subnets in 2 Availability Zones
- [ ] Attach Internet Gateway to VPC
- [ ] Create NAT Gateway in public subnet
- [ ] Configure Route Tables for public/private routing
- [ ] Set up Security Groups for each tier

---

## Phase 4 — Database Migration

- [ ] Create RDS Aurora cluster (Multi-AZ)
- [ ] Export existing database dump
- [ ] Import data into RDS using AWS DMS or mysqldump
- [ ] Validate data integrity
- [ ] Update application DB connection strings
- [ ] Store credentials in AWS Secrets Manager

---

## Phase 5 — Application Deployment

- [ ] Create EC2 Launch Template with AMI
- [ ] Configure user-data script to install app on boot
- [ ] Create Auto Scaling Group (min: 2, max: 6)
- [ ] Set up Application Load Balancer
- [ ] Configure ALB Target Groups and health checks
- [ ] Attach SSL certificate via AWS ACM
- [ ] Test HTTP → HTTPS redirect

---

## Phase 6 — Static Assets & CDN

- [ ] Create S3 bucket for static assets
- [ ] Upload static files (images, CSS, JS)
- [ ] Create CloudFront distribution pointing to S3
- [ ] Configure cache behaviors and TTL
- [ ] Update app to serve static assets from CloudFront URL

---

## Phase 7 — DNS Cutover

- [ ] Create Route 53 hosted zone
- [ ] Add ALB alias record in Route 53
- [ ] Lower TTL on old DNS records (to 60s before cutover)
- [ ] Perform DNS cutover during low-traffic window
- [ ] Monitor traffic shifting to AWS
- [ ] Verify old DNS records fully expired

---

## Phase 8 — Monitoring & Observability

- [ ] Create CloudWatch dashboards (CPU, Memory, RDS)
- [ ] Set up CloudWatch Alarms for critical metrics
- [ ] Configure SNS topics for alert notifications
- [ ] Enable RDS Performance Insights
- [ ] Enable VPC Flow Logs for network analysis

---

## Phase 9 — Testing & Validation

- [ ] Load test with AWS or third-party tool
- [ ] Verify auto-scaling triggers correctly
- [ ] Test RDS failover (Multi-AZ)
- [ ] Validate CloudFront caching
- [ ] Run security scan (AWS Inspector / third-party)
- [ ] Test rollback procedure

---

## Phase 10 — Decommission Old Infrastructure

- [ ] Monitor for 2 weeks post-migration
- [ ] Confirm no traffic hitting old servers
- [ ] Decommission on-premises/old infrastructure
- [ ] Final cost report and documentation
