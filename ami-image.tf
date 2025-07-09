resource "aws_ami_from_instance" "my-images" {
  name               = "tf-image"
  source_instance_id = "i-0c00af2d6317189e2"

  tags = {
    Name = "terra-image"
  }
}
