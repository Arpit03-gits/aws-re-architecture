#!/bin/bash
# ============================================
# AWS Web Re-Architecture — Deployment Script
# ============================================

set -e  # Exit on any error

echo "🚀 Starting deployment..."

# --- Config ---
AWS_REGION=${AWS_REGION:-"us-east-1"}
S3_BUCKET=${S3_BUCKET:-"web-rearch-static-assets"}
APP_DIR=${APP_DIR:-"./app"}

# --- Step 1: Sync static assets to S3 ---
echo "📦 Uploading static assets to S3..."
aws s3 sync "$APP_DIR/static" "s3://$S3_BUCKET/static/" \
  --region "$AWS_REGION" \
  --cache-control "max-age=86400" \
  --delete

echo "✅ Static assets uploaded."

# --- Step 2: Invalidate CloudFront cache ---
DIST_ID=$(aws cloudfront list-distributions \
  --query "DistributionList.Items[0].Id" \
  --output text)

if [ "$DIST_ID" != "None" ]; then
  echo "🔄 Invalidating CloudFront cache..."
  aws cloudfront create-invalidation \
    --distribution-id "$DIST_ID" \
    --paths "/*"
  echo "✅ CloudFront cache invalidated."
fi

# --- Step 3: Trigger EC2 instance refresh ---
ASG_NAME="web-rearch-asg"
echo "🔁 Refreshing EC2 Auto Scaling instances..."
aws autoscaling start-instance-refresh \
  --auto-scaling-group-name "$ASG_NAME" \
  --preferences '{"MinHealthyPercentage": 90}'

echo "✅ Instance refresh initiated."
echo ""
echo "🎉 Deployment complete! Monitor at: https://console.aws.amazon.com/ec2/autoscaling"
