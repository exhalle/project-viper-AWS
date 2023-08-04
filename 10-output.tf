output "vpc_id" {
  value = aws_vpc.app-vpc-viper.arn
}

output "beanstalk-env-name" {
  value = aws_elastic_beanstalk_environment.appviper-env.name

}

output "dns-name-beanstalk" {
  value = aws_elastic_beanstalk_environment.appviper-env.endpoint_url
}
output "rds-host" {
  value = aws_db_instance.app-viper-instance.endpoint
}

output "rds_database" {
  value = aws_db_instance.app-viper-instance.db_name
}

output "db_username" {
  value = aws_db_instance.app-viper-instance.username
}

