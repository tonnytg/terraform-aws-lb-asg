##################################################
##     ___        ______  
##    / \ \      / / ___| 
##   / _ \ \ /\ / /\___ \ 
##  / ___ \ V  V /  ___) |
## /_/   \_\_/\_/  |____/ 
##################################################
##  _     ____              _    ____   ____ 
## | |   | __ )    ___     / \  / ___| / ___|
## | |   |  _ \   / _ \   / _ \ \___ \| |  _ 
## | |___| |_) | |  __/  / ___ \ ___) | |_| |
## |_____|____/   \___| /_/   \_\____/ \____|
##################################################
# Load Balancer e Auto Scaling Group
# After running this terraform,
# you can check URL of your aplication on url-loadbalancer.txt
##################################################
provider "aws" {
  region = var.region
  #access_key = "my-access-key" # Export by AWS CLI
  #secret_key = "my-secret-key" # Export by AWS CLI
}
