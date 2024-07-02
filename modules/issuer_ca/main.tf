resource "tls_private_key" "this" {
  algorithm = "ED25519"
}

resource "tls_cert_request" "this" {
  private_key_pem = tls_private_key.this.private_key_pem

  subject {
    common_name         = var.issuer.common_name
    organization        = var.issuer.organization
    organizational_unit = var.issuer.organizational_unit
    country             = var.issuer.country
    locality            = var.issuer.locality
  }
}

resource "tls_locally_signed_cert" "this" {
  cert_request_pem   = tls_cert_request.this.cert_request_pem
  ca_cert_pem        = var.parent_signing_cert
  ca_private_key_pem = var.parent_signing_key

  is_ca_certificate = true

  allowed_uses = [
    "cert_signing",
    "crl_signing",
    "digital_signature",
  ]

  validity_period_hours = var.ttl / 3600
}
