#INSTANCES
resource "aws_instance" "dep4-pub-sub1" {
    ami                     = lookup(var.ec2-properties, "ami")
    instance_type           = lookup(var.ec2-properties, "instance_type")
    key_name                = lookup(var.ec2-properties, "key_name")
    subnet_id               = var.subnet1_id
    vpc_security_group_ids  = [aws_security_group.dep4-sg.id]

    user_data               = "${file("deploy-app.sh")}"

    tags                    = {"Name" = "Dep4_AZ1_Server"}
}

resource "aws_instance" "dep4-pub-sub2" {
    ami                     = lookup(var.ec2-properties, "ami")
    instance_type           = lookup(var.ec2-properties, "instance_type")
    key_name                = lookup(var.ec2-properties, "key_name")
    subnet_id               = var.subnet2_id
    vpc_security_group_ids  = [aws_security_group.dep4-sg.id]

    user_data               = "${file("deploy-app.sh")}"

    tags                    = {"Name" = "Dep4_AZ2_Server"}
}


# SECURITY GROUP
resource "aws_security_group" "dep4-sg" {
    name            = lookup(var.ec2-properties, "sg_name")
    description     = lookup(var.ec2-properties, "sg_name")
    vpc_id          = var.vpc_id
    
    // To allow SSH connection
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    // To allow connection to Gunicorn
    ingress {
        from_port   = 8000
        to_port     = 8000
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        "Name" : "specifically for deployment4"
        "Terraform" : "true"
    }
}
