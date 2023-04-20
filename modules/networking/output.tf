output "internal_subnet_id" {
  value = module.snet.internal_subnet_id
}
output "external_subnet_id" {
  value = module.snet.external_subnet_id
}
output "lb_id" {
  value = module.lb.lb_id
}
output "internal_backend_id" {
  value = module.lb.internal_backend_id
}
output "vnet_id" {
  value = module.vnet.vnet_id
}