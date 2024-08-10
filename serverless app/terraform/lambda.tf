# --------------- LAMBDA CODE --------------------
resource "terraform_data" "build" {
  triggers_replace = {
    code_hash = local.code_hash
  }

  provisioner "local-exec" {
    command     = "npm run build"
    working_dir = "${path.module}/../"
  }
}

resource "random_uuid" "build_id" {
  keepers = {
    code_hash = local.code_hash
  }
}

data "archive_file" "codebase" {
  depends_on = [terraform_data.build]

  type        = "zip"
  source_dir  = "${path.module}/../dist"
  output_path = "files/${random_uuid.build_id.result}.zip"
}