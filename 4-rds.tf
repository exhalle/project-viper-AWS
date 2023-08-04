#create a security group for RDS Database Instance
resource "aws_security_group" "app-viper-rds_sg" {
  name   = "app-viper-rds_sg"
  vpc_id = aws_vpc.app-vpc-viper.id
  ingress {
    from_port   = 3306
    to_port     = 3306
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

#create a RDS Database Instance
resource "aws_db_instance" "app-viper-instance" {
  engine                 = "mysql"
  identifier             = var.db_identifier
  allocated_storage      = 20
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  username               = var.db_username
  password               = var.db_password
  db_name                = "viper"
  parameter_group_name   = "default.mysql5.7"
  vpc_security_group_ids = ["${aws_security_group.app-viper-rds_sg.id}"]
  skip_final_snapshot    = true
  publicly_accessible    = true
  db_subnet_group_name   = aws_db_subnet_group.rds-subnet-group.id

}
# create rds subnet group
resource "aws_db_subnet_group" "rds-subnet-group" {
  name       = "aws-subnet-group-rds"
  subnet_ids = [aws_subnet.app-viper-public-subnet-1.id, aws_subnet.app-viper-public-subnet-2.id]
}
