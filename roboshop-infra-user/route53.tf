module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  for_each = local.ips
  version = "~> 2.0"

  zone_name = var.zone_name

  records = [
    {
      name    = "${each.key}"
      type    = "A"
      ttl     = 1
      records = [
        each.key == "Web" ? each.value.public_ip : each.value.private_ip
        
      ]
    },
  ]
}