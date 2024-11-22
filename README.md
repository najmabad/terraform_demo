# Terraform Project Setup Guide

## Initial Setup

1. First, define your providers in `providers.tf`. You can get the provider configuration from:
   - Visit [Terraform Registry](https://registry.terraform.io)
   - Find your provider
   - Click "Use Provider"
   - Copy the configuration code

2. Initialize Terraform:
   ```bash
   terraform init
   ```
   This command must be run in the project root and will:
   - Create the `.terraform` directory
   - Download specified providers
   - Set up the working directory

3. Configure your resources in `main.tf`

## Useful Commands

### Check Provider Status

#### List providers used in your configuration
```terraform providers```

#### Show Terraform and provider versions
```terraform version```

#### Provider Location
Terraform stores provider files in the `.terraform`

---
### [Docs] Understanding Terraform Providers
Providers are plugins that allow Terraform to interact with various service APIs. They act as translators between your Terraform configuration and the actual service endpoints.

For example, the AWS provider enables Terraform to create and manage AWS resources by translating your configuration into AWS API calls.

Key points about providers:

1. **Installation**: 
   - Providers are not bundled with Terraform
   - They must be installed separately via `terraform init`
   - This modular approach keeps Terraform lightweight while supporting thousands of providers

2. **Storage and Versioning**:
   - Provider binaries are downloaded to the `.terraform` directory
   - Versions are locked in `.terraform.lock.hcl` to ensure consistency across team members
   - Version locking prevents unexpected changes when running Terraform on different machines

3. **Configuration**:
   - Providers are typically declared in `providers.tf`
   - Resource definitions go in `main.tf` or other configuration files
   - Provider configuration may include authentication details and regional settings

4. **Provider Types**:
   - Official providers (maintained by HashiCorp)
   - Partner providers (maintained by technology partners)
   - Community providers (maintained by individuals)

5. **Provider Sources**:
   - Official providers from the Terraform Registry can be used without explicit source definitions in `providers.tf`
   - Partner/Community providers (e.g. Linode) require explicit source declarations in `providers.tf`

Each provider exposes a set of resource types and data sources that correspond to the features of its respective service API.


## AWS Credentials

In order to connect to your AWS account, you need to provide your AWS credentials.
These are the credentials for the admin user that we previously created in AWS

You can set your AWS credentials in the following ways:
1. Set the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables.
2. Use the `aws configure` command to set your credentials. This will store your credentials in the `~/.aws/credentials` file.

NB: in order to run the `aws configure` command, you need to have the AWS CLI installed on your machine. You can install it by following the instructions  [here](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

In both cases, when you run `terraform plan` or `terraform apply`, Terraform will pick up these credentials without you having to specify the in the Terraform code.


The instructions on how to set credentials for any provider, are typically found in the provider's documentation.
For AWS, you can find them [here](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration)


