# Copy this file to terraform.tfvars and fill in your values.
# terraform.tfvars is gitignored — never commit real values.

aws_region   = "eu-north-1"
environment  = "lab"
project_name = "lab4"

# Must be globally unique across all of AWS.
# Convention: <your-name>-lab4-<random-suffix>  e.g. "alice-lab4-a3f9"
bucket_name  = "mohammad-marmash-lab4-a3f9"

# state bucket_name = "mohammad-marmash-lab4-tf-state-284483510847-eu-north-1-an"
