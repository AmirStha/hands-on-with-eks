#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

helm repo add eks https://aws.github.io/eks-charts

helm upgrade --install \
  -n kube-system \
  --set clusterName=eks-acg \
  --set serviceAccount.create=true \
  aws-load-balancer-controller eks/aws-load-balancer-controller

aws cloudformation deploy \
    --stack-name aws-load-balancer-iam-policy \
    --template-file "$SCRIPT_DIR/iam-policy.yaml" \
    --capabilities CAPABILITY_IAM