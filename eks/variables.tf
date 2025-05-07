
# ----------- variables -----------

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}
# variable "instanc_type" {
#   description = "Instance type"
#   default     = ["t4g.small"]
# }
# variable "ami_type" {
#   description = "ami type which is of arch arm64"
#   default     = ["AL2_ARM_64"]
# }
#  ----------------- Data -------------------

# Filter out local zones, which are not currently supported 
# with managed node groups
data "aws_availability_zones" "available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}


# --------- Locals ----------------

locals {
  cluster_name = "chan-eks-${random_string.suffix.result}"
}



# ----------- Resource ----------

resource "random_string" "suffix" {
  length  = 8
  special = false
}
