variable "resource_group_name" {
  description = "Resource group fourni par l'école"
  type        = string
  default     = "rg-AHamon2023_cours-projet-eadl"
}

variable "tfstate_storage_account_name" {
  type    = string
  default = "sttfstateenervision"
}

variable "data_storage_account_name" {
  type    = string
  default = "stenervisiondata"
}

variable "common_tags" {
  type = map(string)
  default = {
    cours     = "cours-projet-eadl"
    promotion = "HEADL_001"
    user      = "AHamon2023"
  }
}