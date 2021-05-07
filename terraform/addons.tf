resource "heroku_addon" "database" {
  app        = heroku_app.crodbotics_django.name
  plan       = "heroku-postgresql:hobby-dev"
}

resource "heroku_addon" "redis" {
  app        = heroku_app.crodbotics_django.name
  plan       = "heroku-redis:hobby-dev"
}

resource "heroku_addon" "papertrail" {
  app  = heroku_app.crodbotics_django.name
  plan = "papertrail:choklad"
}

