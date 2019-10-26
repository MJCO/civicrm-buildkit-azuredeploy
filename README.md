# Deployment of [CiviCRM BuildKit](https://docs.civicrm.org/dev/en/latest/tools/buildkit) on [Microsoft Azure](https://www.azure.com)

[![Deploy to Azure](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.png)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMJCO%2Fcivicrm-buildkit-azuredeploy%2Fmaster%2Fazuredeploy.json)

This template allows you to deploy a simple Linux VM with [CiviCRM BuildKit](https://docs.civicrm.org/dev/en/latest/tools/buildkit) installed.

This template will provide you with configurable options for:

* Ubuntu Linux version
* CiviCRM Buildkit URL pattern
* Azure DNS name
* VM UserName

This template will deploy an A1 size VM in the resource group location and return the FQDN of the VM and an SSH command example.

## Deployment Instructions

### Using the [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/) (`az`)

1. Make sure you have [installed the latest version of the Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest).
1. [Login to Azure](https://docs.microsoft.com/en-us/cli/azure/get-started-with-azure-cli?view=azure-cli-latest#sign-in) with `az login`.
1. (Optional) You may need to [change the active subscription](https://docs.microsoft.com/en-us/cli/azure/manage-azure-subscriptions-azure-cli?view=azure-cli-latest#change-the-active-subscription).

    Get a list of Azure Subscriptions:

    ``` pwsh
    az account list --output table
    ```

   Set the subscription to your chosen subscription:

   ``` pwsh
   az account set --subscription "Your Subscription Name"
   ```

1. (Optional) Copy the file `azuredeploy.parameters.json.example` to `azuredeploy.parameters.json` and adjust the values as required.
1. (Optional) [Create a Resource Group](https://docs.microsoft.com/en-us/cli/azure/azure-cli-vm-tutorial?view=azure-cli-latest&tutorial-step=2) to hold your new deployment:

    ``` pwsh
    az group create --name YourResourceGroup --location uksouth
    ```

1. Deploy the Template
    1. Clone this repository:

        ``` sh
        git clone https://github.com/MJCO/civicrm-buildkit-azuredeploy/
        ```

    1. Change into the directory:

        ``` sh
        cd civicrm-buildkit-azuredeploy
        ```

    1. Deploy the template to Azure:

        ``` pwsh
        az group deployment create `
        --name <YourDeploymentName> `
        --resource-group <YourResourceGroup> `
        --template-file azuredeploy.json `
        --parameters `@azuredeploy.parameters.json
        ```

        **Notes:**
        * Replace anything wrapped in "<" and ">" with the values you used previously or your chosen value - avoid spaces in names.
        * The ` preceeding the @ symbol in the command is required for PowerShell but *must* be ommitted for CMD, MacOS and Linux terminal emulators.
        * You can omit the `--parameters` option and you will be asked for required values - *not recommended*.
        * The example above has been split over multiple lines for readability. It should still be copy/paste ready but for convenience the single line command is:

            ``` pwsh
            az group deployment create --name <YourDeploymentName> --resource-group <YourResourceGroup> --template-file azuredeploy.json --parameters `@azuredeploy.parameters.json
            ```

### Using the [Azure UI](https://portal.azure.com) (`https://portal.azure.com`) - Automatic Steps

1. Click on the **Deploy to Azure** button above.
1. Complete the requested information, including the following required fields:
    * Resource Group - *You can select an existing group or create a new one.*
    * Location - *The Azure region/datacenter you wish to host your deployment.*
    * Admin Username - *The Linux username you wish to use for your account.*
    * Admin Password or Key - *The **single line** SSH public key you wish to use for your user.*
    * DNS Label Prefix - *The **single word or hyphen-separated phrase** you wish to use as your Azure DNS label*

### Using the [Azure UI](https://portal.azure.com) (`https://portal.azure.com`) - Manual Steps

1. Navigate to the [Azure Portal](https://portal.azure.com).
1. Login to the Azure portal.
1. Create a new resource from a template by clicking on **Create a Resource**, searching for **Template** and selecting **Template deployment (deploy using custom templates)**.
1. Click on **Build your own template in the editor**.
1. Copy and Paste the contents of `azuredeploy.json` into the editor, *replacing the existing contents*.
1. Click on **Save**.
1. Complete the requested information, including the following required fields:
    * Resource Group - *You can select an existing group or create a new one.*
    * Location - *The Azure region/datacenter you wish to host your deployment.*
    * Admin Username - *The Linux username you wish to use for your account.*
    * Admin Password or Key - *The **single line** SSH public key you wish to use for your user.*
    * DNS Label Prefix - *The **single word or hyphen-separated phrase** you wish to use as your Azure DNS label*

## Other Help

If you are new to Azure virtual machines, see:

* [Azure Virtual Machines](https://azure.microsoft.com/services/virtual-machines/).
* [Azure Linux Virtual Machines documentation](https://docs.microsoft.com/azure/virtual-machines/linux/)
* [Azure Windows Virtual Machines documentation](https://docs.microsoft.com/azure/virtual-machines/windows/)
* [Template reference](https://docs.microsoft.com/azure/templates/microsoft.compute/allversions)
* [Quickstart templates](https://azure.microsoft.com/resources/templates/?resourceType=Microsoft.Compute&pageNumber=1&sort=Popular)

If you are new to template deployment, see:

* [Azure Resource Manager documentation](https://docs.microsoft.com/azure/azure-resource-manager/)

If you are new to CiviCRM development or BuildKit, see:

* [CiviCRM Developer documentation](https://docs.civicrm.org/dev/en/latest)
