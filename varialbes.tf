variable "public_subnet_id" {
  type = string
}

variable "sg-id" {
  type = string
}

variable "key_name" {
  type    = string
  default = "CHANGE_KEY_PAIR_NAME"
}
