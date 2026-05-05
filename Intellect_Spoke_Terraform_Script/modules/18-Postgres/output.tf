output "psql_name_out" {
  value = azurerm_postgresql_flexible_server.psql.name
}

output "psql_username_out" {
  value = azurerm_postgresql_flexible_server.psql.administrator_login
}

output "psql_password_out" {
  sensitive = true
  value     = azurerm_postgresql_flexible_server.psql.administrator_password
}