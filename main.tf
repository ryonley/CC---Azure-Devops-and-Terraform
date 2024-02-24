provider "azurerm" {
    features {}
    subscription_id = "fcf5180a-f90c-4e4e-9679-85fe69191285"
    skip_provider_registration = true
}

resource "azurerm_resource_group" "tf_test" {
    name = "devopstest"
    location = "Central US"
}

resource "azurerm_container_group" "tfcg_test" {
    name                = "weatherapi2"
    location            = azurerm_resource_group.tf_test.location
    resource_group_name = azurerm_resource_group.tf_test.name

    ip_address_type = "Public"
    dns_name_label = "codeconduct1"
    os_type  = "Linux"

    container {
        name = "weatherapi2"
        image = "ryonley/weatherapi3:latest"
            cpu = "1"
            memory = "1"

            ports {
                port = 80
                protocol = "TCP"
            }

    }

}