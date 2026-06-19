variable "aws_region" {
  description = "The AWS region for the project"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name prefix"
  type        = string
  default     = "globalmart"
}

variable "github_owner" {
  description = "The GitHub owner of the repository"
  type        = string
}

variable "github_repo" {
  description = "The GitHub repository name"
  type        = string
}

variable "ssh_allowed_ip" {
  description = "The IP address allowed to access the EC2 instance via SSH"
  type        = string
}