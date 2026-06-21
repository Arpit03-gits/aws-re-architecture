#!/bin/bash
# ============================================
# AWS Web Re-Architecture — Setup Script
# ============================================

set -e

echo "🔧 Running initial setup..."

# Check AWS CLI
if ! command -v aws &> /dev/null; then
  echo "❌ AWS CLI not found. Install it: https://aws.amazon.com/cli/"
  exit 1
fi

# Check Terraform
if ! command -v terraform &> /dev/null; then
  echo "❌ Terraform not found. Install it: https://developer.hashicorp.com/terraform/downloads"
  exit 1
fi

echo "✅ AWS CLI version: $(aws --version)"
echo "✅ Terraform version: $(terraform version -json | python3 -c 'import sys,json; print(json.load(sys.stdin)["terraform_version"])')"

# Check AWS credentials
echo "🔑 Checking AWS credentials..."
aws sts get-caller-identity > /dev/null 2>&1 && echo "✅ AWS credentials valid." || {
  echo "❌ AWS credentials not configured. Run: aws configure"
  exit 1
}

# Copy tfvars example
if [ ! -f "infrastructure/terraform.tfvars" ]; then
  cp infrastructure/terraform.tfvars.example infrastructure/terraform.tfvars
  echo "📄 Created infrastructure/terraform.tfvars — please fill in your values."
fi

echo ""
echo "✅ Setup complete! Next steps:"
echo "   1. Edit infrastructure/terraform.tfvars with your values"
echo "   2. cd infrastructure && terraform init"
echo "   3. terraform plan"
echo "   4. terraform apply"
