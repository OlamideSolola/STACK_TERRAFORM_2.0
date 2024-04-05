
#------------Declaring Key Pair --------------
resource "aws_key_pair" "Stack_KP" {
  key_name   = "stackkp_ola2"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}


# resource "aws_key_pair" "my_key_pair" {
#   key_name   = "my-key-pair"
#   public_key = data.local_file.private_key.content
# }