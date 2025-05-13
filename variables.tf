variable "rg_name" {
  type = string
}

variable "law_id" {
  type = string
  description = "log analytics full id url"
}
variable "metadata" {
  type = object({
    correlative = string
    location = string
    proj = string
  })
}