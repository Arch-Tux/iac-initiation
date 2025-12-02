resource "local_file" "exemple" {
  content  = file("${path.module}/${var.web_app}")
  filename = "${path.module}/output/index.html"
}
