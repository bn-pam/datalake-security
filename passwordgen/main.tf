resource "random_password" "defaultpass" {
  length  = 16
  special = true
  override_special = "!@#$%^&*()-_=+[]{}<>?~"
}

output "generated_password" {
  value = random_password.defaultpass.result
  sensitive = true
}

# ci-dessous pour créer un fichier terraform.tfvars et y ajouter le mot de passe créé plus haut
resource "null_resource" "write_env" {
  triggers = {
    password = random_password.defaultpass.result
  }

  provisioner "local-exec" {
    command = <<EOT
      echo "secret_value= \"${random_password.defaultpass.result}\"" > terraform.tfvars
    EOT
  }
}