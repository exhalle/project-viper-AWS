# Create elastic beanstalk application

resource "aws_elastic_beanstalk_application" "elasticapp" {
  name = var.elasticapp
}

# Create elastic beanstalk Environment

resource "aws_elastic_beanstalk_environment" "appviper-env" {
  name                = var.beanstalkappenv
  application         = aws_elastic_beanstalk_application.elasticapp.name
  solution_stack_name = var.solution_stack_name


  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = aws_vpc.app-vpc-viper.id
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = aws_security_group.SG_Beanstalk.id
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = "True"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "${aws_subnet.app-viper-public-subnet-1.id},${aws_subnet.app-viper-public-subnet-2.id}"

  }
  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "MatcherHTTPCode"
    value     = "200"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.micro"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = "internet facing"
  }
  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "db_name"
    value     = aws_db_instance.app-viper-instance.db_name
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "db_user"
    value     = var.db_username
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "db_host"
    value     = aws_db_instance.app-viper-instance.endpoint
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "db_password"
    value     = var.db_password
  }



}

resource "aws_security_group" "SG_Beanstalk" {
  name   = "app-viper-beanstalk-sg"
  vpc_id = aws_vpc.app-vpc-viper.id
  ingress {
    from_port   = 80
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}