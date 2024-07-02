module "v1" {
  source = "./modules/root_ca"

  issuer = {
    common_name         = "Music Gang Root CA v1"
    organization        = "Music Gang"
    organizational_unit = "Music Gang Certificate Authority"
    locality            = "Prato"
    country             = "IT"
  }

  ttl = 1261440000 # 40 years
}

module "v1_1" {
  source = "./modules/issuer_ca"

  issuer = {
    common_name         = "Music Gang Intermediate CA v1.1"
    organization        = "Music Gang"
    organizational_unit = "Music Gang Certificate Authority"
    locality            = "Prato"
    country             = "IT"
  }

  parent_signing_cert = module.v1.root_ca_certificate
  parent_signing_key  = module.v1.root_ca_private_key
  parent_ca_cert      = module.v1.root_ca_certificate

  ttl = 315360000 # 10 years
}

module "v1_1_1" {
  source = "./modules/issuer_ca"

  issuer = {
    common_name         = "Music Gang Issuer CA v1.1.1"
    organization        = "Music Gang"
    organizational_unit = "Music Gang Certificate Authority"
    locality            = "Prato"
    country             = "IT"
  }

  parent_signing_cert = module.v1_1.issuer_certificate
  parent_signing_key  = module.v1_1.issuer_private_key
  parent_ca_cert      = module.v1_1.issuer_ca_chain

  ttl = 157680000 # 5 years
}


module "music_gang_internal" {
  source = "./modules/leaf_cert"

  issuer = {
    common_name  = "musicgang.internal"
    organization = "Music Gang"
    locality     = "Prato"
    country      = "IT"
  }

  parent_signing_cert = module.v1_1_1.issuer_certificate
  parent_signing_key  = module.v1_1_1.issuer_private_key
  parent_ca_cert      = module.v1_1_1.issuer_ca_chain

  ttl = 31536000 # 1 year
}
