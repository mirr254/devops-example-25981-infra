variable "port" {
  description = "specify which port the web server should run on."
  type = number
  default = 8080
}

variable "app_name" {
  description = "Application name"
  type        = string
  default     = "samuel-crowdbotics-main"
}

variable "instance_size" {
  description = "How large our instance should be"
  type = string
  default = "standard-1x"
}

variable "app_version" {
  description = "Github app version to deploy"
  type = string
  default = "v1.0.1"
}

variable "secret_key" {
  description = "secret key to be used by the app"
  type = string
}

variable "heroku_acc_email" {
  
}

variable "heroku_api_key" {
  
}