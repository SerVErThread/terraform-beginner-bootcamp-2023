# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

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

### Github Lifecycle (Before, Init, Command)

We need to be careful using the Init because it will not rerun if we restart an exiting workspace.

[GitPod Workspaces Tasks](https://www.gitpod.io/docs/configure/workspaces/tasks)


### Working with Env Vars

#### env command

We can list out all Environment variables (Env Vars) ising the `env` command

We can filter specific Env Vars using grep eg. `env | grep AWS`

#### Setting and Unsetting Env Vars

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

#### Printing Vars

We can print an env var using echo e.g `echo $HELLO`

#### Scoping of Env Vars

When you open a new bash terminals in VSCode. It will not be aware of env vars that you have set in another window.

If you want the Env vars to persist accross all future bash terminals that are open, you will need to set env vars in your bash profile eg. `.bash_profile`

#### Persisting Env Vars in GitPod

We can persist env vars in gotpod by storing them in GitPod Secrets Storage

```
gp env HELLO='world'
```

All furtuer workspaces launched will set the env vars for all bash terminals open in those workspaces.

You can also set env vars in the `.gotpod.yml` but this can only contain non-sensitive env vars.

### Persisting Env Vars in GitPod

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
