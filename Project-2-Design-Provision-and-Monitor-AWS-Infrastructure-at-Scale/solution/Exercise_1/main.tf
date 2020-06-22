# Designate a cloud provider, region, and credentials
provider "aws" {
    shared_credentials_file = "/Users/d441303/.aws/credentials"
    profile = "personal"
    region = "us-east-1"
}


# provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "micro_instance"{
    count = 4
    ami = "ami-09d95fab7fff3776c"
    instance_type = "t2.micro"
    tags = {
        Name = "Udacity T2"
    }
}

# provision 2 m4.large EC2 instances named Udacity M4
/* resource "aws_instance" "large_instance"{
    count = 2
    ami = "ami-09d95fab7fff3776c"
    instance_type = "m4.large"
    tags = {
        Name = "Udacity M4"
    }
} */