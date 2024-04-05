terraform{
         backend "s3"{
                bucket= "stackbuckstateolamideclixx12"
                key = "terraform.tfsate"
                region="us-east-1"
                dynamodb_table = "clixxstatelock-tf"
                 }
 }
