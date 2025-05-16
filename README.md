# AWS S3 Static Website Deployment with Terraform

This project demonstrates how to deploy a static website on AWS S3 using Terraform. The infrastructure creates an S3 bucket configured for static website hosting with proper public access and uploads the website files.

## Project Structure

```
.
├── .terraform/              # Terraform state directory
├── pages/                   # Static website files
│   ├── error.html           # Error page
│   ├── index.html           # Main page
│   └── logo.png             # Website logo
├── .terraform.lock.hcl      # Terraform dependency lock file
├── main.tf                  # Main Terraform configuration
├── provider.tf              # AWS provider configuration
├── README.md                # This documentation file
├── terraform.tf             # Terraform settings
├── terraform.tfstate        # Terraform state file
├── terraform.tfstate.backup # Terraform state backup
└── variables.tf             # Variable definitions
```

## Prerequisites

- AWS Account with appropriate permissions
- Terraform installed (v1.0.0+)
- AWS CLI configured with appropriate credentials

## Features

- Creates an S3 bucket for website hosting
- Configures bucket for public read access
- Sets up proper ownership controls
- Uploads website files (HTML and images)
- Configures S3 website endpoints with index and error documents

## Deployment Steps

1. Clone this repository:
   ```
   git clone https://github.com/yourusername/terra-s3-static-deployment.git
   cd terra-s3-static-deployment
   ```

2. Initialize Terraform:
   ```
   terraform init
   ```

3. Review the planned changes:
   ```
   terraform plan
   ```

4. Apply the configuration:
   ```
   terraform apply
   ```

5. After successful deployment, Terraform will output the website URL.

## Customization

To customize this project:

1. Replace the HTML files in the `pages` directory with your own website files
2. Modify the bucket name in `variables.tf`
3. Add additional S3 objects as needed in `main.tf`

## Cleaning Up

To remove all resources created by this project:

```
terraform destroy
```

## Security Considerations

This configuration makes the S3 bucket and its contents publicly accessible. For production use, consider implementing stricter access controls and enabling S3 bucket logging.

## License

This project is licensed under the MIT License - see the LICENSE file for details.