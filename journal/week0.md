# Terraform Beginner Bootcamp 2023 - Week 0

  * [Semantic Versioning](#semantic-versioning)
  * [Install the Terraform CLI](#install-the-terraform-cli)
    + [Considerations with the Terraform CLI changes.](#considerations-with-the-terraform-cli-changes)
    + [Considerations for Linux Distribution](#considerations-for-linux-distribution)
    + [Refactoring into Bash Scripts](#refactoring-into-bash-scripts)
      - [Shebang Considerations](#shebang-considerations)
      - [Execution Considerations](#execution-considerations)
      - [Linux Permissions Considerations](#linux-permissions-considerations)
  * [Gitpod Lifecycle - Before, Init, Command](#gitpod-lifecycle---before--init--command)
  * [Working with Env Vars](#working-with-env-vars)
    + [env command](#env-command)
    + [Setting and Unsetting Env Vars](#setting-and-unsetting-env-vars)
    + [Printing Vars](#printing-vars)
    + [Scoping of Env Vars](#scoping-of-env-vars)
    + [Persisting Env Vars in GitPod](#persisting-env-vars-in-gitpod)
  * [AWS CLI Installation](#aws-cli-installation)
- [Terraform Basics](#terraform-basics)
    + [Terraform Registry](#terraform-registry)
    + [Terraform Console](#terraform-console)
      - [Terraform Init](#terraform-init)
      - [Terraform Plan](#terraform-plan)
      - [Terraform Apply](#terraform-apply)
      - [Terraform Apply](#terraform-apply-1)
      - [Terraform Lock files](#terraform-lock-files)
      - [Terraform State files](#terraform-state-files)
      - [Terraform Directory](#terraform-directory)
  * [Issues with Terraform Cloud Login and Gitpod Workspace.](#issues-with-terraform-cloud-login-and-gitpod-workspace)


## Semantic Versioning

This project is going to utilise semantic versioning for its tagging.
[semver.org](https://semver.org/)

The general format:

 **MAJOR.MINOR.PATCH**, e.g `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

### Considerations with the Terraform CLI changes.

The terraform CLI installation for Linux have changed due to gpg keyring changes. So we needed to refer to the latest install CLI instructions via Terraform Documentation and change the scripting for install.

[Terraform install](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux Distribution

This project is built against Ubuntu.
Please consider checking your Linux Distribution and change according to your needs.

[How To Check OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Examples of checking OS version
```
$ cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="<https://www.ubuntu.com/>"
SUPPORT_URL="<https://help.ubuntu.com/>"
BUG_REPORT_URL="<https://bugs.launchpad.net/ubuntu/>"
PRIVACY_POLICY_URL="<https://www.ubuntu.com/legal/terms-and-policies/privacy-policy>"
UBUNTU_CODENAME=jammy
```

### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg deprecation issues, we noticed the bash script steps were a considerable amount more code. So we decided to create a bash script to install the Terraform CLI.

This bash script is located here: [./bin/install_terraform_cli](,/bin/install_terraform_cli)

- This will keep the Gitpod Task File tidy.([.gitpod.yml](.gitpod.yml))
- This will  enable is to debug easily and execute manually Terraform CLI install.
- This will allow better portabilioty for other projects that need to install Terraform CLI.

#### Shebang Considerations

A Shebang (pronounced Sha-bang) tells the bash script what programe that will interpret the script. eg. `#!/bin/bash`

ChatGPT recomended we use this format eg. `#!/usr/bin/env bash`

- For portability with different OS distributions
- Will search the user's PATH for the bash executable.

[Shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))
#### Execution Considerations
When executing the bash script we can use the `./` shorthand notation to execute the bash script.

eg. `./bin/install_terraform_cli`

If we are using a script in a .gitpod.yml we need to point the script to a program to interprete it.

eg. `source ./bin/install_terraform_cli`
#### Linux Permissions Considerations

In ordet to make our bash script executable we need to change linux permissions for the file to be excutable at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli`
```
alternatively:

```sh
chmod 744 ./bin/install_terraform_cli`
```

[CHMOD](https://en.wikipedia.org/wiki/Chmod)

## Gitpod Lifecycle

We need to be careful using the Init because it will not rerun if we restart an existing workspace.

[GitPod Workspaces Tasks](https://www.gitpod.io/docs/configure/workspaces/tasks)


## Working with Env Vars

### env command

We can list out all Environment variables (Env Vars) using the `env` command

We can filter specific Env Vars using grep eg. `env | grep AWS`

### Setting and Unsetting Env Vars

In the terminal we can set using `export HELLO=world"`

In the terminal we can unset using `unset HELLO`

we can set an env var temporarily when just running a command

```sh
HELLO='world' ./bin/print_message
```
Within a bash script we can set env without writing export eg.

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

### Printing Vars

We can print an env var using echo e.g `echo $HELLO`

### Scoping of Env Vars

When you open a new bash terminals in VSCode. It will not be aware of env vars that you have set in another window.

If you want the Env vars to persist accross all future bash terminals that are open, you will need to set env vars in your bash profile eg. `.bash_profile`

### Persisting Env Vars in GitPod

We can persist env vars in gitpod by storing them in GitPod Secrets Storage

```
gp env HELLO='world'
```

All further workspaces launched will set the env vars for all bash terminals open in those workspaces.

You can also set env vars in the `.gotpod.yml` but this can only contain non-sensitive env vars.

## AWS CLI Installation

AWS CLI is installed for the project via the bash script [`./bin/install_aws-cli`](./bin/install_aws_cli)
[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials is configure correctly by running the following AWS CLI command:

```sh
aws sts get-caller-identity
```

If it is sucessful, you should see a json payload return that looks like this:

```json
{
    "UserId": "AICBXCZPF%KZEDRBKDJYX",
    "Account": "1234356789012",
    "Arn": "arn:aws:iam::1234356789012:user/terraform-beginnner-bootcamp"
}
```
We'll need to generate AWS CLI credentials from IAM user in orfder to use the AWS CLI.


# Terraform Basics

### Terraform Registry 

Terraform sources theeir providers and modules from the Terrafomr Registry which is located at the [registry.terraform.io](https://registry.terraform.io/)

- **Providers** is an interface to API's that allows us to create resources in terraform.

- **Modules** are a way to make large amounts of terraform code modular, portable and shareable.
[Ramdom Terraform Providers](https://registry.terraform.io/providers/hashicorp/random)

### Terraform Console

We can see a list of all the Terrform commands by simply typing `terraform`

#### Terraform Init

`terraform init`

At the start of a new terraform project we will run `terraform init` to download th ebinaries for the terraform providers that we'll use in this project.

#### Terraform Plan

`terraform plan`

This will generate out a changeset, about the state of our infrastrcuture and what will be changed.

We can output this changeset ie. "plan" to be passed to an apply, but often you can just ignore outputting. 

#### Terraform Apply

`terraform apply`

This will run a plan and pass the changeset to be executed by terraform. Apply should prompt us for a yes or no.

If we want to automatically approve an apply we can provide the auto approve flag eg. `terraform apply --auto-approve`

#### Terraform Apply

`terraform destroy`

This will destroy resources already created by terraform.
#### Terraform Lock files

`.terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used with the project.

The terraform Lock file **should be committed** to your Version Control System (VCS) eg. GitHub 
#### Terraform State files

`.terraform.tfstate` contains information about the current state or your infrastructure.

This file **should not be committed** to your VCS as this file can contain sensitive data.

If you lose this file you lose knowing the state of your infrastructure.

`.terraform.tfstate.backup` is the previous file state.

#### Terraform Directory

`.terraform` directory contains binaries of terraform providers.

## Issues with Terraform Cloud Login and Gitpod Workspace.

When attempting to run `terraform login` it will launche in bash a wiswig view to generate a token however it does not work as expected in Gitpod VsCode in the browser.

The workaround is manually generate a token in Terraform Cloud.

```
  https://app.terraform.io/app/settings/tokens?source=terraform-login

```

Then create and open the file manually here:

```sh
 touch /home/gitpod/.terraform.d/credentials.tfrc.json
 open /home/gitpod/.terraform.d/credentials.tfrc.json
```

Provide the forllowing code to replace your token in the file:

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "your-terraform-cloud-token"
    }
  }
}
```
We have automated the process using the following bash script[bin/generate_tfrc_credentials](bin/generate_tfrc_credentials)

<https://developer.hashicorp.com/terraform/language/modules/develop/structure>




## Semantic Versioning

This project is going to utilise semantic versioning for its tagging.
[semver.org](https://semver.org/)

The general format:

 **MAJOR.MINOR.PATCH**, e.g `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

### Considerations with the Terraform CLI changes.

The terraform CLI installation for Linux have changed due to gpg keyring changes. So we needed to refer to the latest install CLI instructions via Terraform Documentation and change the scripting for install.

[Terraform install](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux Distribution

This project is built against Ubuntu.
Please consider checking your Linux Distribution and change according to your needs.

[How To Check OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Examples of checking OS version
```
$ cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="<https://www.ubuntu.com/>"
SUPPORT_URL="<https://help.ubuntu.com/>"
BUG_REPORT_URL="<https://bugs.launchpad.net/ubuntu/>"
PRIVACY_POLICY_URL="<https://www.ubuntu.com/legal/terms-and-policies/privacy-policy>"
UBUNTU_CODENAME=jammy
```

### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg deprecation issues, we noticed the bash script steps were a considerable amount more code. So we decided to create a bash script to install the Terraform CLI.

This bash script is located here: [./bin/install_terraform_cli](,/bin/install_terraform_cli)

- This will keep the Gitpod Task File tidy.([.gitpod.yml](.gitpod.yml))
- This will  enable is to debug easily and execute manually Terraform CLI install.
- This will allow better portabilioty for other projects that need to install Terraform CLI.

#### Shebang Considerations

A Shebang (pronounced Sha-bang) tells the bash script what programe that will interpret the script. eg. `#!/bin/bash`

ChatGPT recomended we use this format eg. `#!/usr/bin/env bash`

- For portability with different OS distributions
- Will search the user's PATH for the bash executable.

[Shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))
#### Execution Considerations
When executing the bash script we can use the `./` shorthand notation to execute the bash script.

eg. `./bin/install_terraform_cli`

If we are using a script in a .gitpod.yml we need to point the script to a program to interprete it.

eg. `source ./bin/install_terraform_cli`
#### Linux Permissions Considerations

In ordet to make our bash script executable we need to change linux permissions for the file to be excutable at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli`
```
alternatively:

```sh
chmod 744 ./bin/install_terraform_cli`
```

[CHMOD](https://en.wikipedia.org/wiki/Chmod)

## Gitpod Lifecycle - Before, Init, Command

We need to be careful using the Init because it will not rerun if we restart an exiting workspace.

[GitPod Workspaces Tasks](https://www.gitpod.io/docs/configure/workspaces/tasks)


## Working with Env Vars

### env command

We can list out all Environment variables (Env Vars) ising the `env` command

We can filter specific Env Vars using grep eg. `env | grep AWS`

### Setting and Unsetting Env Vars

In the terminal we can set using `export HELLO=world"`

In the terminal we can unset using `unset HELLO`

we can set an env var temporarily when just running a command

```sh
HELLO='world' ./bin/print_message
```
Within a bash script we can set env without writing export eg.

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

### Printing Vars

We can print an env var using echo e.g `echo $HELLO`

### Scoping of Env Vars

When you open a new bash terminals in VSCode. It will not be aware of env vars that you have set in another window.

If you want the Env vars to persist accross all future bash terminals that are open, you will need to set env vars in your bash profile eg. `.bash_profile`

### Persisting Env Vars in GitPod

We can persist env vars in gitpod by storing them in GitPod Secrets Storage

```
gp env HELLO='world'
```

All further workspaces launched will set the env vars for all bash terminals open in those workspaces.

You can also set env vars in the `.gotpod.yml` but this can only contain non-sensitive env vars.

## AWS CLI Installation

AWS CLI is installed for the project via the bash script [`./bin/install_aws-cli`](./bin/install_aws_cli)
[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials is configure correctly by running the following AWS CLI command:

```sh
aws sts get-caller-identity
```

If it is sucessful, you should see a json payload return that looks like this:

```json
{
    "UserId": "AICBXCZPF%KZEDRBKDJYX",
    "Account": "1234356789012",
    "Arn": "arn:aws:iam::1234356789012:user/terraform-beginnner-bootcamp"
}
```
We'll need to generate AWS CLI credentials from IAM user in orfder to use the AWS CLI.


# Terraform Basics

### Terraform Registry 

Terraform sources theeir providers and modules from the Terrafomr Registry which is located at the [registry.terraform.io](https://registry.terraform.io/)

- **Providers** is an interface to API's that allows us to create resources in terraform.

- **Modules** are a way to make large amounts of terraform code modular, portable and shareable.
[Ramdom Terraform Providers](https://registry.terraform.io/providers/hashicorp/random)

### Terraform Console

We can see a list of all the Terrform commands by simply typing `terraform`

#### Terraform Init

`terraform init`

At the start of a new terraform project we will run `terraform init` to download th ebinaries for the terraform providers that we'll use in this project.

#### Terraform Plan

`terraform plan`

This will generate out a changeset, about the state of our infrastrcuture and what will be changed.

We can output this changeset ie. "plan" to be passed to an apply, but often you can just ignore outputting. 

#### Terraform Apply

`terraform apply`

This will run a plan and pass the changeset to be executed by terraform. Apply should prompt us for a yes or no.

If we want to automatically approve an apply we can provide the auto approve flag eg. `terraform apply --auto-approve`

#### Terraform Apply

`terraform destroy`

This will destroy resources already created by terraform.
#### Terraform Lock files

`.terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used with the project.

The terraform Lock file **should be committed** to your Version Control System (VCS) eg. GitHub 
#### Terraform State files

`.terraform.tfstate` contains information about the current state or your infrastructure.

This file **should not be committed** to your VCS as this file can contain sensitive data.

If you lose this file you lose knowing the state of your infrastructure.

`.terraform.tfstate.backup` is the previous file state.

#### Terraform Directory

`.terraform` directory contains binaries of terraform providers.

## Issues with Terraform Cloud Login and Gitpod Workspace.

When attempting to run `terraform login` it will launche in bash a wiswig view to generate a token however it does not work as expected in Gitpod VsCode in the browser.

The workaround is manually generate a token in Terraform Cloud.

```
  https://app.terraform.io/app/settings/tokens?source=terraform-login

```

Then create and open the file manually here:

```sh
 touch /home/gitpod/.terraform.d/credentials.tfrc.json
 open /home/gitpod/.terraform.d/credentials.tfrc.json
```

Provide the forllowing code to replace your token in the file:

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "your-terraform-cloud-token"
    }
  }
}
```
We have automated the process using the following bash script[bin/generate_tfrc_credentials](bin/generate_tfrc_credentials)

<https://developer.hashicorp.com/terraform/language/modules/develop/structure>

