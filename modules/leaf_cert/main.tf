resource "tls_private_key" "this" {
  algorithm = "ED25519"
}

resource "tls_cert_request" "this" {
  private_key_pem = tls_private_key.this.private_key_pem

  subject {
    common_name  = var.issuer.common_name
    organization = var.issuer.organization
    country      = var.issuer.country
    locality     = var.issuer.locality
  }
}

resource "tls_locally_signed_cert" "this" {
  cert_request_pem   = tls_cert_request.this.cert_request_pem
  ca_cert_pem        = var.parent_signing_cert
  ca_private_key_pem = var.parent_signing_key

  allowed_uses = [
    "digital_signature",
    "key_encipherment",
    "server_auth",
    "client_auth",
  ]

  validity_period_hours = var.ttl / 3600
}

resource "local_sensitive_file" "cert" {
  content  = tls_locally_signed_cert.this.cert_pem
  filename = "${path.root}/certs/${var.issuer.common_name}/cert.pem"
}
resource "local_sensitive_file" "key" {
  content  = tls_private_key.this.private_key_pem
  filename = "${path.root}/certs/${var.issuer.common_name}/key.pem"
}
resource "local_sensitive_file" "ca_chain" {
  content  = var.parent_ca_chain
  filename = "${path.root}/certs/${var.issuer.common_name}/ca_chain.pem"
}
