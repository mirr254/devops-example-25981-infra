terraform {
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

#TODO: FInish this
resource "heroku_build" "django_app" {
  app = heroku_app.crodbotics_django.name

  
}

# Launch the app's web process by scaling-up
resource "heroku_formation" "django-formation" {
  app        = heroku_app.crodbotics_django.name
  type       = "web"
  quantity   = 1
  size       = var.instance_size
  depends_on = [heroku_build.django_app]
}