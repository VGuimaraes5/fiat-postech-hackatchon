variable "manager_ms_url" {
    type = string
    default = "http://aba6fbdaef42b4f9e9c7609d0230c12b-2092708295.us-east-1.elb.amazonaws.com:5001"
}

variable "point_record_ms_url" {
    type = string
    default = "http://ad4b614f9d972488db2d7dc67e8b8810-1651513005.us-east-1.elb.amazonaws.com:5002"
}

variable "reports_ms_url" {
    type = string
    default = "http://a41e93fec6497499e84422f36c017f69-1952889263.us-east-1.elb.amazonaws.com:5003"
}

variable "db_username" {
  type = string
  default = "root"
}
variable "db_password" {
  type = string
  default = "hackathon_password"
}
