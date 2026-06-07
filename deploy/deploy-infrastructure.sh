#!/bin/bash
# =============================================================
# Azure Cloud Infrastructure & Automation
# Script: deploy-infrastructure.sh
#
# Deploys the full infrastructure stack using Azure CLI:
#   - Resource Group
#   - Virtual Network + Subnet
#   - Network Security Group with hardened rules
#   - Azure Function App (serverless compute)
#   - Azure Key Vault (secrets management)
#   - RBAC role assignment (least-privilege)
#   - Azure Monitor alert rule
#   - Budget alert (cost governance)
#
# Usage:
#   chmod +x deploy-infrastructure.sh
#   ./deploy-infrastructure.sh
#
# Prerequisites:
#   - Azure CLI installed and logged in (az login)
#   - Contributor access on target subscription
#
# Azure Cloud Infrastructure & Automation — portfolio case study
# =============================================================

set -e

# --- Variables ---
RESOURCE_GROUP="AzureInfra-RG"
LOCATION="eastus"
VNET_NAME="AzureInfra-VNet"
VNET_PREFIX="10.0.0.0/16"
SUBNET_NAME="AzureInfra-Subnet"
SUBNET_PREFIX="10.0.1.0/24"
NSG_NAME="AzureInfra-NSG"
STORAGE_NAME="azureinfrastorage$(date +%s | tail -c 6)"
FUNCTION_APP_NAME="azureinfra-func-$(date +%s | tail -c 6)"
KEYVAULT_NAME="AzureInfra-KV-$(date +%s | tail -c 5)"
CURRENT_USER=$(az ad signed-in-user show --query id -o tsv 2>/dev/null || echo "")

echo "=================================================="
echo " Azure Cloud Infrastructure Deployment"
echo " Resource Group : $RESOURCE_GROUP"
echo " Location       : $LOCATION"
echo "=================================================="

# --- Step 1: Resource Group ---
echo ""
echo "[1/8] Creating Resource Group..."
az group create   --name "$RESOURCE_GROUP"   --location "$LOCATION"   --tags Environment=Lab Project=AzureInfraAutomation Owner=IT-Operations

echo "  ✅ Resource Group: $RESOURCE_GROUP"

# --- Step 2: Virtual Network + Subnet ---
echo ""
echo "[2/8] Creating Virtual Network and Subnet..."
az network vnet create   --resource-group "$RESOURCE_GROUP"   --name "$VNET_NAME"   --address-prefix "$VNET_PREFIX"   --subnet-name "$SUBNET_NAME"   --subnet-prefix "$SUBNET_PREFIX"   --location "$LOCATION"

echo "  ✅ VNet: $VNET_NAME ($VNET_PREFIX)"
echo "  ✅ Subnet: $SUBNET_NAME ($SUBNET_PREFIX)"

# --- Step 3: Network Security Group ---
echo ""
echo "[3/8] Creating and configuring Network Security Group..."
az network nsg create   --resource-group "$RESOURCE_GROUP"   --name "$NSG_NAME"   --location "$LOCATION"

# Allow HTTPS inbound
az network nsg rule create   --resource-group "$RESOURCE_GROUP"   --nsg-name "$NSG_NAME"   --name "Allow-HTTPS"   --priority 100   --protocol Tcp   --direction Inbound   --source-address-prefixes "*"   --source-port-ranges "*"   --destination-address-prefixes "*"   --destination-port-ranges 443   --access Allow

# Deny all other inbound
az network nsg rule create   --resource-group "$RESOURCE_GROUP"   --nsg-name "$NSG_NAME"   --name "Deny-All-Inbound"   --priority 4096   --protocol "*"   --direction Inbound   --source-address-prefixes "*"   --source-port-ranges "*"   --destination-address-prefixes "*"   --destination-port-ranges "*"   --access Deny

# Associate NSG to subnet
az network vnet subnet update   --resource-group "$RESOURCE_GROUP"   --vnet-name "$VNET_NAME"   --name "$SUBNET_NAME"   --network-security-group "$NSG_NAME"

echo "  ✅ NSG: $NSG_NAME — HTTPS allowed, all else denied"

# --- Step 4: Storage Account (required for Function App) ---
echo ""
echo "[4/8] Creating Storage Account for Function App..."
az storage account create   --resource-group "$RESOURCE_GROUP"   --name "$STORAGE_NAME"   --location "$LOCATION"   --sku Standard_LRS   --kind StorageV2   --min-tls-version TLS1_2   --allow-blob-public-access false

echo "  ✅ Storage: $STORAGE_NAME (TLS 1.2, no public blob access)"

# --- Step 5: Azure Function App ---
echo ""
echo "[5/8] Creating Azure Function App..."
az functionapp create   --resource-group "$RESOURCE_GROUP"   --name "$FUNCTION_APP_NAME"   --storage-account "$STORAGE_NAME"   --consumption-plan-location "$LOCATION"   --runtime python   --runtime-version 3.11   --functions-version 4   --os-type Linux

echo "  ✅ Function App: $FUNCTION_APP_NAME (Python 3.11, Consumption plan)"

# --- Step 6: Key Vault ---
echo ""
echo "[6/8] Creating Key Vault..."
az keyvault create   --resource-group "$RESOURCE_GROUP"   --name "$KEYVAULT_NAME"   --location "$LOCATION"   --sku standard   --enable-soft-delete true   --retention-days 7   --enable-rbac-authorization true

# Store a sample secret
az keyvault secret set   --vault-name "$KEYVAULT_NAME"   --name "FunctionApp-ApiKey"   --value "$(openssl rand -base64 32)"

echo "  ✅ Key Vault: $KEYVAULT_NAME (RBAC-based access, soft delete enabled)"

# --- Step 7: RBAC Assignment ---
echo ""
echo "[7/8] Configuring RBAC — least-privilege at Resource Group scope..."
SCOPE="/subscriptions/$(az account show --query id -o tsv)/resourceGroups/$RESOURCE_GROUP"

if [ -n "$CURRENT_USER" ]; then
  # Key Vault Secrets Officer — scoped to Key Vault only
  KV_SCOPE="$SCOPE/providers/Microsoft.KeyVault/vaults/$KEYVAULT_NAME"
  az role assignment create     --assignee "$CURRENT_USER"     --role "Key Vault Secrets Officer"     --scope "$KV_SCOPE"
  echo "  ✅ Key Vault Secrets Officer — scoped to $KEYVAULT_NAME only"
else
  echo "  ⚠️  Could not retrieve user ID — RBAC skipped"
fi

# --- Step 8: Budget Alert ---
echo ""
echo "[8/8] Creating budget alert..."
az consumption budget create   --budget-name "AzureInfra-Lab-Budget"   --amount 30   --time-grain Monthly   --start-date "$(date +%Y-%m-01)"   --end-date "2026-12-31"   --resource-group "$RESOURCE_GROUP"   --notifications     key=Alert80 enabled=true operator=GreaterThan threshold=80     contactEmails=rahatislamanik@gmail.com 2>/dev/null ||   echo "  ⚠️  Budget alert skipped — requires billing scope permissions"

echo ""
echo "=================================================="
echo " ✅ Deployment Complete"
echo " Resource Group : $RESOURCE_GROUP"
echo " VNet           : $VNET_NAME"
echo " NSG            : $NSG_NAME"
echo " Function App   : $FUNCTION_APP_NAME"
echo " Key Vault      : $KEYVAULT_NAME"
echo ""
echo " ⚠️  COST REMINDER: Delete resources after lab"
echo "    az group delete --name $RESOURCE_GROUP --yes --no-wait"
echo "=================================================="
