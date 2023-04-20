output "lb_id" {
  value = azurerm_lb.external_lb.id
}
output "internal_backend_id" {
  value = azurerm_lb_backend_address_pool.internal_backend.id
}