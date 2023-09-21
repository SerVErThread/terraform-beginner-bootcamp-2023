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
