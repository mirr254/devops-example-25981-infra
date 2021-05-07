
terraform {
#   backend "pg" {
#   }

  required_providers {
    heroku = {
      source  = "heroku/heroku"
      version = "~> 4.0"
    }
  }
}

resource "heroku_app" "crodbotics_django" {
  name   = var.app_name
  region = "us"
  stack  = "container"

  config_vars = {
    SECRET_KEY = var.secret_key
  }
}


resource "heroku_build" "django_app" {
  app = heroku_app.crodbotics_django.name
 
  source {
    path = "../"
  }
  
}

# Scale up to launch app
resource "heroku_formation" "django-formation" {
  app        = heroku_app.crodbotics_django.name
  type       = "web"
  quantity   = 1
  size       = var.instance_size
  depends_on = [heroku_build.django_app]
}