variable "issuer" {
  type = object({
    common_name         = string
    organization        = string
    organizational_unit = string
    country             = string
    locality            = string
  })
  description = "Issuer configuration"
}

variable "parent_signing_cert" {
  type        = string
  description = "PEM-encoded parent certificate"
}

variable "parent_signing_key" {
  type        = string
  description = "PEM-encoded parent key"
}

variable "parent_ca_chain" {
  type        = string
  description = "PEM-encoded parent CA certificate"
}

variable "ttl" {
  type        = number
  description = "TTL for the certificate"
}
