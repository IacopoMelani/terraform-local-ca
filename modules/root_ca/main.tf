resource "tls_private_key" "this" {
  algorithm = "ED25519"
}

resource "tls_self_signed_cert" "this" {
  private_key_pem = tls_private_key.this.private_key_pem

  is_ca_certificate = true

  subject {
    common_name         = var.issuer.common_name
    organization        = var.issuer.organization
    organizational_unit = var.issuer.organizational_unit
    country             = var.issuer.country
    locality            = var.issuer.locality
  }

  allowed_uses = [
    "cert_signing",
    "crl_signing",
    "digital_signature",
  ]

  validity_period_hours = var.ttl / 3600
}
