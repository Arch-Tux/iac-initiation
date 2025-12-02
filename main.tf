resource "local_file" "exemple" {
  content = var.web_app
  filename = "${path.module}/output/index.html"
}
