resource "aws_s3_bucket" "bucket" {
  count = 2
  bucket = "kashipuram-yadav01-${uuid()}"  
  tags = {
    Name  = "My bucket-${count.index}."
  }
  # this will not change destroy the bucket {best-practice }
  lifecycle {
    ignore_changes = [
      bucket
    ]
  }

}


