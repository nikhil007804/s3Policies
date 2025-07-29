# Terraform CI/CD: S3 Bucket with Policies, Cost Estimation & Manual Approval

## What This Project Does

This project automates the creation of:
- An **S3 bucket**
- **Lifecycle rules** to move objects to `STANDARD_IA` after 30 days
- **Bucket policies** for access control
- **Tagging** (e.g., `env = "dev"`)
- **Remote backend** support for Terraform state
- CI/CD pipeline using **GitHub Actions**
- **Cost estimation** using **Infracost**
- **Manual approval** before applying changes

---

## File Structure

```
.
├── main.tf                    # S3 bucket + policies + lifecycle rules
├── provider.tf                # AWS provider configuration
├── variables.tf               # Input variable definitions
├── terraform.tfvars           # Default values (optional)
├── outputs.tf                 # Outputs like bucket name
├── environments/
│   ├── dev.tfvars
│   ├── uat.tfvars
│   └── prod.tfvars
└── .github/workflows/
    └── deploy.yml             # GitHub Actions CI/CD workflow
```

---

## Setup Steps

### 1. Clone the Repository

```bash
git clone https://github.com/<your-username>/<your-repo-name>.git
cd <your-repo-name>
```

### 2. Add GitHub Secrets

Go to your repository → **Settings** → **Secrets** → **Actions** and add:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `INFRACOST_API_KEY`

**To get the Infracost API key:**
1. Go to https://dashboard.infracost.io
2. Sign up and copy your API key

### 3. Add a GitHub Environment

1. Go to **Settings** → **Environments**
2. Create a new environment named `dev-approval`
3. Add yourself or a teammate as a **Required Reviewer**

### 4. Add Collaborators (Optional)

1. Go to **Settings** → **Collaborators**
2. Click **Invite a collaborator**
3. Add your teammate's GitHub username

### 5. Push Your Code

```bash
git add .
git commit -m "initial commit"
git push origin main
```

This will trigger the GitHub Actions workflow.

---

## How the Workflow Works

1. **Runs** on every push to the `main` branch
2. **Creates** backend S3 bucket (if not exists)
3. **Runs** `terraform init` and `terraform plan`
4. **Infracost** generates a cost estimate
5. **Waits** for manual approval (via `dev-approval`)
6. **If approved**, runs `terraform apply`

---

## Cleanup

To destroy the resources:

```bash
terraform destroy -var-file="environments/dev.tfvars"
```