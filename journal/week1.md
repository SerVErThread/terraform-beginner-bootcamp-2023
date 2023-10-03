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
