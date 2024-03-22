variable "manager_ms_url" {
    type = string
    default = "http://ad205163a8c1b419d94b303141ebd533-1939765825.us-east-1.elb.amazonaws.com:5001"
}

variable "point_record_ms_url" {
    type = string
    default = "http://a0a4b7266346c4b8b9cd496124a20bc4-2007363354.us-east-1.elb.amazonaws.com:5002"
}

variable "reports_ms_url" {
    type = string
    default = "http://a49c9ea4f6edf47d793294a2b1ff4819-372335033.us-east-1.elb.amazonaws.com:5003"
}

variable "db_username" {
  type = string
  default = "root"
}
variable "db_password" {
  type = string
  default = "hackathon_password"
}
