output "issuer_certificate" {
  value = tls_locally_signed_cert.this.cert_pem
}

output "issuer_private_key" {
  sensitive = true
  value     = tls_private_key.this.private_key_pem
}

output "issuer_ca_chain" {
  value = format("%s\n%s", tls_locally_signed_cert.this.cert_pem, var.parent_ca_cert)
}
