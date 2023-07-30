variable "ami" {
  default = "ami-053b0d53c279acc90"
  type= string
  description = "The id of the machine image (AMI) to use"
    validation {
      condition = substr(var.ami, 0,4) == "ami-"
      error_message= "The AMI should start with \"ami-\"."
    }
}

variable "instance_type" {
  default = "t2.micro"
}

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
