##  Repository description

This repo contains a test deployement of a aws lambda function using:
- terraform (Infrastructure as Code)
- poetry (Package manager)


## :bug: For developement

##### Tool list

- pyenv (Python Installation Management)
- virtualenvWrapper (VirtualEnv wrapper to manage python virtual env when developping)
- poetry (projects specification and package dependency management)
- pip (local package manager)


## :wrench: How to

**Add pip packages to poetry**

```
pip freeze > requirements.txt
poetry add $(cat requirements.txt)
```

:warning: When using `virtualenvwrapper` pip may include package that are not necessary for your project

**Deploy your lambda function to AWS**

To simplify (`using Makefile`): run `make redeploy-lambda`


**Package the lambda function**

:warning: Execute these commands from the root of the repo (beware of python version if you reuse)

```bash
rm -rf package
mkdir package
cp -R $$(poetry env info -p)/lib/python3.9/site-packages* package/
cp -R ./src/ ./package
```

**Provision with Terraform**

:exclamation: Don't forget to define your AWS env. variables from the CLI or by`source` a `.sh` file. Example:
```bash
source ./set-env.sh
```
with a file that looks like 
```bash
export AWS_ACCESS_KEY_ID="<AWS_ACCESS_KEY_ID>"
export AWS_SECRET_ACCESS_KEY="<AWS_ACCESS_KEY>"
```

To deploy the terraform config

```bash
cd ./tf/
source ./set-env.sh;
terraform plan
```

Validate the deployement and run (do this after packaging your lambda function with poetry)

```bash
terraform apply
```

