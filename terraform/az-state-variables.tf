# company
variable "company" {
  type = string
  description = "This variable defines the name of the company"
  default = "terraform"
}

# environment - tags
variable "environment" {
  type = string
  description = "This variable defines the environment to be built"
  default = "test"
}

# azure region
variable "location" {
  type = string
  description = "Azure region where resources will be created"
  default = "west europe"
}
