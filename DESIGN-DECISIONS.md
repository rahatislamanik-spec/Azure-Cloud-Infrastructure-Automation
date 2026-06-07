# Azure Cloud Infrastructure & Automation — Design Decisions

> Architectural rationale for the decisions made in this case study.

---

## ARM Templates over Bicep

**Decision:** Infrastructure as Code implemented using ARM JSON templates.

**Rationale:** ARM templates are the native Azure IaC format — every Bicep template compiles to ARM JSON before deployment. Understanding ARM directly means understanding what Bicep produces under the hood. For a lab environment demonstrating Azure fundamentals, ARM templates are more appropriate than Bicep, which adds a layer of abstraction that can obscure the underlying resource model. In a production environment with a larger codebase, Bicep would be the correct choice for readability and module reuse.

---

## Network Security Groups over Azure Firewall

**Decision:** NSGs for network traffic control, not Azure Firewall.

**Rationale:** Azure Firewall costs approximately $1,200/month. An NSG costs nothing. For a lab environment demonstrating network segmentation principles, NSGs provide subnet-level and NIC-level traffic filtering that covers the core security requirement — restricting inbound access to HTTPS only with an explicit deny-all rule. Azure Firewall adds centralized logging, FQDN filtering, and threat intelligence that are valuable in production but unnecessary for demonstrating NSG fundamentals.

**NSG rule design:** HTTPS (443) explicitly allowed, AzureCloud service tag allowed for platform traffic, deny-all at priority 4096. The explicit deny-all makes the security intent clear — nothing is implicitly permitted.

---

## Azure Functions over App Service

**Decision:** Azure Functions (Consumption plan) for serverless compute.

**Rationale:** Consumption plan Functions cost nothing when idle — billing is per execution. An App Service plan costs $13–55/month regardless of whether any code runs. For a lab demonstrating serverless compute patterns, the Consumption plan correctly demonstrates the operational model: no idle compute cost, automatic scaling, pay-per-execution. A production workload with consistent traffic would warrant a Premium plan for VNet integration and cold start elimination.

---

## Key Vault with RBAC Authorization

**Decision:** Key Vault configured with RBAC-based access (`--enable-rbac-authorization true`) rather than legacy access policies.

**Rationale:** Key Vault access policies are a legacy model that grants access at the vault level — one policy controls all secrets, keys, and certificates. RBAC authorization allows granular role assignments: a Function App can be granted `Key Vault Secrets User` for secrets only, with no access to keys or certificates. This aligns with least-privilege at a more granular level than the legacy policy model and integrates with standard Azure RBAC tooling.

---

## Resource Group Scope for RBAC

**Decision:** All role assignments scoped to the Resource Group, not the Subscription.

**Rationale:** Subscription-scoped Contributor grants write access to every resource in the subscription. Resource Group scope limits blast radius to this project only. The Key Vault Secrets Officer role is scoped even further — to the Key Vault resource itself — because secrets management access should not extend to any other resource in the group.

---

## Resource Tags at Deployment Time

**Decision:** All resources tagged with Environment, Project, Owner, and ManagedBy at creation.

**Rationale:** Tags applied retroactively are incomplete. Tags applied via ARM template or CLI at creation time are consistent across every resource. In a production environment, Azure Policy would enforce tagging requirements — this lab demonstrates the tagging habit that Policy would enforce.

---

*Azure Cloud Infrastructure & Automation — portfolio case study.*
*All resources deployed in a temporary Azure lab environment.*
