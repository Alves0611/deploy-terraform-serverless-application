module "website_bucket" {
  source = "github.com/Alves0611/terraform-aws-s3-bucket"

  name     = local.domain_name
  filepath = "${path.module}/website/dist"

  policy = {
    json = jsonencode({
      "Version" : "2008-10-17",
      "Id" : "PolicyForCloudFrontPrivateContent",
      "Statement" : [
        {
          "Sid" : "AllowCloudFrontServicePrincipal",
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "cloudfront.amazonaws.com"
          },
          "Action" : "s3:GetObject",
          "Resource" : "arn:aws:s3:::${local.domain_name}/*",
          "Condition" : {
            "StringEquals" : {
              "AWS:SourceArn" : "arn:aws:cloudfront::${local.account_id}:distribution/${local.distribution_id}"
            }
          }
        }
      ]
    })
  }
}
