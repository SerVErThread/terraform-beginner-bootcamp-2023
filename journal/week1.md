# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

Our root module structure is as follows:

```
Project_ROOT/
│
├── main.tf                 # everything else
├── providers.tf            # defines required providers and their configuration
├── outputs.tf              # stores out outputs
├── variables.tf            # stores the structure of input variables
├── terraform.tfvars        # the data of variables we want to load into our terraform project
└── README.md               # required for root modules
```


[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variables

### Terraform Cloud Variables

In terraform we can set two kinds of variables:
- Environement Variables - Those you will normally set in your bash terminal eg. AWS credentials.
- Terraform Variables - Those you you normallly set in tf vars file.

We can set Terraform Cloud variables to be sensitive so they are not shown visibly in the UI.

### Loading Terraform Input Variables

### var flag
We can use the `var` flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_uuid="my-user_id"`.

### var-file flag

- TODO: Document this flag

### terraform.tfvars

This is the default file to load terraform variables in bulk.

### auto.tfvars

- TODO: Document this functionality for Terraform Cloud.

### order of terrraform variables

- TODO: Document which terraform variables takes precedence
[Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)
