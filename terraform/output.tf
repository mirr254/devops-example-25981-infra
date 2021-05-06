output "web_url" {
  value = "https://${heroku_app.crodbotics_django.name}.herokuapp.com"
}

output "app_name" {
  value = heroku_app.crodbotics_django.name
}

output "app_id" {
  value = heroku_app.crodbotics_django.uuid
}

