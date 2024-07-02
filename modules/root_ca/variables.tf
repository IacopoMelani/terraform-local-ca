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

variable "ttl" {
  type        = number
  description = "TTL for the certificate"
}
