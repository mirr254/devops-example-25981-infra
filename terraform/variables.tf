variable "port" {
  description = "specify which port the web server should run on."
  type = number
  default = 8080
}

variable "app_name" {
  description = "Application name"
  type        = string
  default     = "samuel-crowdbotics-django"
}

variable "instance_size" {
  description = "How large our instance should be"
  type = string
  default = "standard-1x"
}

variable "secret_key" {
  description = "secret key to be used by the app"
  type = string
}

variable "heroku_acc_email" {
  
}

variable "heroku_api_key" {
  
}