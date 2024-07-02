output "root_ca_certificate" {
  value = tls_self_signed_cert.this.cert_pem
}

output "root_ca_private_key" {
  sensitive = true
  value     = tls_private_key.this.private_key_pem
}
