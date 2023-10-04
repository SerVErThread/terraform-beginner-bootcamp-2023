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



## Dealing with Configuration Drift

### What happens if we lose our state file

If you lose your state file, you most likely will have to tear down all your cloud infrastructre manually.

You can use terraform import but it wont work for all cloud resources. you need to check the terrafrom providers documentation for which resources that support import.

### Fix missing resources with Terraform Import

`terraform import aws_s3_bucket.examplebucket bucket-name` 

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual configuration

If someone goes and deletes or modifies cloud resources manually through ClickOps.

If we run Terraform plan, it will attempt to put our infrastructure back into the expected state fixing Configuration Drift.

## Fix using Terraform Refresh

 ```sh
 terraform apply -refresh-only -auto-approve
 ```


## Terraform Modules

### Terraform Module Structure

It is recomended to place modules in a `modules` directory when locally developing modules but you can name it whatever you like.
### Passing input variables

We can pass inout variables to our module.

The module has to declare these terrafomr variables in its own variables.tf

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid"
  bucket_name = var.bucket_name
}
```

### Modules Sources

Using the source we can import the module from various places eg:
- locally
- Github
- Terraform Registry


```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}

```  

[Module Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

## Consideration when using ChatGPT to write terraform

LLM's such as ChatGPT may not be trained on the latest docusmentation or informartion about terraform.

It may likeky produce older examples that could be deprecated often affecting providers.

## Working with files in Terraform

In Terraform there is a special variable called path that allows us to reference local paths:

- path.module is the filesystem path of the module where the expression is placed. 
- path.root is the filesystem path of the root module of the configuration.

[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)


[](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object)
resource "aws_s3_object" "index-html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"

 etag = filemd5(var.index_html_filepath)
}

### Terraform Locals

A local value assigns a name to an expression, so you can use the name multiple times within a module instead of repeating the expression.

```tf
locals {
  s3_orifin_id = "MyS3Origin"
}
```
[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)
### Terraform Data Sources

This allows us to source data from cloud resources. It is yuseful when we want to reference cloud resources without importing them.

A data source is accessed via a special kind of resource known as a data resource, declared using a data block:

```sh
data "aws_ami" "example" {
  most_recent = true

  owners = ["self"]
  tags = {
    Name   = "app-server"
    Tested = "true"
  }
}
```
[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

## Working with JSON

Encodes a given value to to a string using json syntax

We use the jsonencode to create the json policy inline in the hcl.

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```

[jsoncode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)
