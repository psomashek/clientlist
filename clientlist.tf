terraform {
  required_providers {
    akamai = {
      source  = "akamai/akamai"
      version = ">= 6.1.0"
    }
  }
  required_version = ">= 1.8"
}
 
provider "akamai" {
  edgerc         = "~/.edgerc"
  config_section = "default"
}

resource "akamai_clientlist_list" "PSS_CLIENTLIST" {
  name = "PSS_CLIENTLIST"
  type = "IP"
  notes = "Client list creation"
  tags = ["tag1", "tag2", "tag3"]
  contract_id = "F-JOGRUJ"
  group_id = 106383
  items {
    value           = "104.241.203.0/24"
    description     = "Item one"
    tags            = ["tag1", "tag2"]
    expiration_date = "2026-09-06T15:58:39.225+00:00"
  }
  items {
    value           = "104.241.203.123"
    description     = "Item two"
    tags            = ["tag2", "tag3"]
    expiration_date = ""
  }
  items {
    value           = "104.241.203.237"
    description     = "Item three"
    tags            = ["tag1"]
    expiration_date = ""
  }
}

resource "akamai_clientlist_activation" "my_activation" {
  list_id                 = "227594_PSSCLIENTLIST"
  version                 = 1
  network                 = "STAGING"
  comments                = "My activation comments"
  notification_recipients = ["psomashe@akamai.com"]
}

data "akamai_clientlist_lists" "PSS_CLIENTLIST_data" {
  
}

output "my_clientlists" {
  value = data.akamai_clientlist_lists.PSS_CLIENTLIST_data.id
}