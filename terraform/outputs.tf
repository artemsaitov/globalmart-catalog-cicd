output "ec2_public_ip" {
  value = aws_instance.web.public_ip
}

output "ec2_instance_id" {
  value = aws_instance.web.id
}

output "website_url" {
  value = "http://${aws_instance.web.public_ip}"
}

output "artifact_bucket" {
  value = aws_s3_bucket.artifacts.bucket
}

output "github_actions_role_arn" {
  value = aws_iam_role.github_actions_role.arn
}