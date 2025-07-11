#!/bin/sh

cd /infrastructure/env/dev

echo "🚀 Terraform Init"
terraform init

echo "📜 Terraform Plan"
terraform plan -out=tfplan.out

echo "🔄 Terraform Refresh"
terraform refresh
