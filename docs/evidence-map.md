# Azure Cloud Infrastructure Evidence Map

This file maps the available screenshots to the claims supported by this repository.

| Evidence | File | What It Demonstrates | Boundary |
|---|---|---|---|
| ARM deployment completion | `screenshots/ARM_Deployment_Complete.png` | Azure deployment details page showing a completed ARM deployment in a temporary lab subscription | Source ARM template is not included |
| Resource group overview | `screenshots/Resource_Group_Overview.png` | Azure resource group view with deployed resources | Lab resource group identifiers are visible |
| Network Security Group overview | `screenshots/Network_Security_Group_Overview.png` | NSG resource view and default inbound/outbound rules | Does not prove custom security hardening |
| Azure Function App overview | `screenshots/Azure_Function_App_Overview.png` | Azure Function App resource overview | Does not show function code or trigger validation |
| Azure Cloud Shell output | `screenshots/Azure_Cloud_Shell_CLI.png` | Cloud Shell command output used to inspect Azure resources | Lab provider instructions are visible |

## Evidence Boundaries

- This is a guided Azure lab converted into a professional cloud operations case study.
- The screenshots prove Azure Portal and Cloud Shell exposure, not production deployment ownership.
- RBAC, Key Vault, Azure Monitor, and Cost Management are discussed as production requirements but are not evidenced by the current screenshot set.
- No ARM template source, Bicep files, shell scripts, or PowerShell automation files are included in this repository.
- A stronger future version should add source templates/scripts, RBAC screenshots, Key Vault screenshots, Monitor alerts/metrics, and Cost Management screenshots.
