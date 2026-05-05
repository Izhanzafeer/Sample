output "Resource_Group_Name" {
  value = module.resource_groups.rg_name_out
}

output "Resource_Group_Location" {
  value = module.resource_groups.rg_location_out
}

output "Resources_Tags" {
  value = module.resource_groups.rg_tags_out
}

output "data_snet_name_out" {
  value = module.data_subnet.data_snet_name_out
}


# output "Windows_Hostaddress" {
#   value = module.virtual_machine_windows.windows_virtual_machine_ip_out
# }

# output "Windows_Username" {
#   value = module.virtual_machine_windows.windows_virtual_machine_username_out
# }
# output "Windows_Password" {
#   sensitive = true
#   value     = module.virtual_machine_windows.windows_virtual_machine_password_out
# }

# output "linux_virtual_machine_ip" {
#   value = module.virtual_machine_linux.linux_virtual_machine_ip_out
# }

# output "linux_virtual_machine_username" {
#   value = module.virtual_machine_linux.linux_virtual_machine_username_out
# }

# output "linux_virtual_machine_password" {
#   sensitive = true
#   value     = module.virtual_machine_linux.linux_virtual_machine_password_out
# }