#!/bin/bash

set -euo pipefail

WORKDIR="/infrastructure/env/dev"
PLANFILE="tfplan.out"

cd "$WORKDIR" || { echo "❌ Failed to cd into $WORKDIR"; exit 1; }

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] 📣 $*"
}

error_exit() {
  echo "❌ Error on line $1"
  exit 1
}

trap 'error_exit $LINENO' ERR

if [ ! -f "/root/.aws/credentials" ]; then
  log "❌ AWS credentials not found at /root/.aws/credentials"
  exit 1
else
  log "✅ AWS credentials loaded"
fi

COMMAND="${1:-all}"

apply_with_confirmation() {
  log "🛑 Do you want to apply this Terraform plan? (yes/no)"
  read -r user_input
  if [ "$user_input" = "yes" ]; then
    log "🚀 Terraform Apply (auto-approve)"
    terraform apply -auto-approve
  else
    log "❌ Skipping apply as per user input."
  fi
}

case "$COMMAND" in
  init)
    log "🚀 Terraform Init"
    terraform init
    ;;
  plan)
    log "📜 Terraform Plan"
    terraform plan -out="$PLANFILE"
    ;;
  refresh)
    log "🔄 Terraform Refresh"
    terraform refresh
    ;;
  apply)
    log "📜 Terraform Plan"
    terraform plan -out="$PLANFILE"

    apply_with_confirmation
    ;;
  all)
    log "🚀 Terraform Init"
    terraform init

    log "📜 Terraform Plan"
    terraform plan -out="$PLANFILE"

    log "🔄 Terraform Refresh"
    terraform refresh

    apply_with_confirmation
    ;;
  *)
    log "❌ Invalid command: $COMMAND"
    echo "Usage: $0 [init|plan|refresh|apply|all]"
    exit 1
    ;;
esac

log "✅ Task '$COMMAND' completed successfully."
