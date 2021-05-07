
terraform {
  backend "pg" {
  }
}

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


resource "heroku_build" "django_app" {
  app = heroku_app.crodbotics_django.name
  buildpacks = [ "https://github.com/heroku/heroku-buildpack-python.git" ]

  source {
    url = "https://github.com/mirr254/devops-example-25981/archive/refs/tags/${var.app_version}.tar.gz"
    version = var.app_version
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

# Establish certificate for our application
resource "heroku_cert" "ssl_certificate" {
  app               = heroku_app.crodbotics_django.name
  certificate_chain = tls_self_signed_cert.ssl_cert.cert_pem
  private_key       = tls_private_key.cert_priv_key.private_key_pem
  depends_on        = [heroku_addon.ssl]
}

resource "tls_private_key" "cert_priv_key" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "tls_self_signed_cert" "ssl_cert" {
  key_algorithm   = tls_private_key.cert_priv_key.algorithm
  private_key_pem = tls_private_key.cert_priv_key.private_key_pem

  subject {
    common_name  = "https://${heroku_app.crodbotics_django.name}.herokuapp.com" 
    organization = "TEst, Inc"
  }

  validity_period_hours = 48

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}



