resource "aws_ecr_repository" "manager" {
  name                 = "fiat-postech-hackatchon-manager"
  image_tag_mutability = "MUTABLE"
  force_delete = true

  image_scanning_configuration {
    scan_on_push = true
  }

  tags ={
    fiap = "hackathon"
  }
}

resource "aws_ecr_repository" "point_record" {
  name                 = "fiat-postech-hackatchon-point-record"
  image_tag_mutability = "MUTABLE"
  force_delete = true

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    fiap = "hackathon"
  }
}

resource "aws_ecr_repository" "reports" {
  name                 = "fiat-postech-hackatchon-reports"
  image_tag_mutability = "MUTABLE"
  force_delete = true
  
  image_scanning_configuration {
    scan_on_push = true
  }

  tags ={
    fiap = "hackathon"
  }
}