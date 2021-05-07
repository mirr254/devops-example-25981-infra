# devops-example-25981-infra

# Instructions on how to run the terraform config manually.

## Prerequisites
- Heroku CLI
- Terraform version 0.14.9 or greater

# Instructions

- Create a Heroku app with a Heroku Postgres add-on. Use its DATABASE_URL config variable as the backend storage for terraform configurations
```
    # Pick an app name
    export APP_NAME=my-terraform-backend

    # Create the database
    heroku create $APP_NAME
    heroku addons:create heroku-postgresql:hobby-dev --app $APP_NAME

    # with the database credentials
    export DATABASE_URL=`heroku config:get DATABASE_URL --app $APP_NAME`
    terraform init -backend-config="conn_str=$DATABASE_URL"
```
my-samuel-crowdb-tf
courtsey: [Heroku](heroku.com)

- `terraform plan` to see what resource will be created. 
- Rename the file `terraform.tfvars.example` to `terraform.tfvars` and populate the required variables
- Make sure to tag the application being deployed since the build is using tags for deployment.
- Once sure run `terraform apply --auto-approve` to deploy the resources
- Grab a coffee. Will take a min or 2 to create.

Once terraform completes successfully, it will output app url.

```
  
    Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

    Outputs:

    app_id = "900e44cd-396a-41b9-a034-e0a4801de1dc"
    app_name = "samuel-crowdbotics-t1"
    web_url = "https://samuel-crowdbotics-t1.herokuapp.com"
```

App may take a few secs to load up.

