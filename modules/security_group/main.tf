#variable "vpc_id" {
#  description = "The VPC ID where the security group will be created"
#  type        = string
#}
#For our module be more dynamic and instead of using 3-5
# variables we can use map or list
variable "security_group" {
    description = " A list of security groups to create"
    type = map(object({
        #name        = string we can't use this because
        #key of the map is web_sg 
        description = string
        vpc_id      = string
        tags        = map(string)
    }))


}
#variable "security_group_name" {
#  description = "The name of the security group"
#  type        = string
#}
#variable "security_group_description" {
#    description = "The description of the security group"
#    type        = string
#}
#variable "tag" {
#  description = "Tags to be applied to the security group"
#  type = object({
#    name = string
#  })
#}

resource "aws_security_group" "allow_tls" {
    for_each = var.security_group
  name        = each.key #then we can put here#each.value.name #var.security_group_name #"allow_tls"
  description = each.value.description #var.security_group_description #"Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = each.value.vpc_id #var.vpc_id

  tags = each.value.tags #var.tag.name
}