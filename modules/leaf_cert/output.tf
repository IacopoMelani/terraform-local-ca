output "leaf_certificate" {
  value = tls_locally_signed_cert.this.cert_pem
}

output "leaf_private_key" {
  sensitive = true
  value     = tls_private_key.this.private_key_pem
}

output "leaf_ca_chain" {
  value = var.parent_ca_chain
}
