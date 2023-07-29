variable "INSTANCE_USERNAME" {
  description = "Username for SSH connection"
  type        = string
  default     = "ubuntu"
}

variable "PATH_TO_PRIVATE_KEY" {
  description = "Path to the private key file"
  type        = string
  default     = "./keys/access.txt"
}

variable "PATH_TO_PUBLIC_KEY" {
  description = "Path to the pubic key file"
  type        = string
  default     = "./keys/access.txt.pub"
}

variable "PATH_TO_SECRET_KEY" {
  description = "secret key to aws account"
  type = string
  default = "./keys/secret_key"
}

variable "PATH_TO_ACCESS_KEY" {
  description = "Access key to aws account"
  type = string
  default = "./keys/access_key"
}