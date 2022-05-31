resource "github_repository" "this" {
  for_each = { for key, value in local.repos : key => value if key != var.root_repo }

  name                 = each.value.name
  description          = each.value.description
  topics               = each.value.topics
  visibility           = each.value.visibility
  has_wiki             = each.value.has_wiki
  has_projects         = each.value.has_projects
  has_issues           = each.value.has_issues
  vulnerability_alerts = each.value.vulnerability_alerts
  is_template          = each.value.is_template

  dynamic "template" {
    for_each = each.value.template != null ? [1] : []
    content {
      owner      = each.value.template.owner
      repository = each.value.template.repository
    }
  }

  dynamic "pages" {
    for_each = each.value.pages != null ? [1] : []
    content {
      source {
        branch = each.value.pages.branch
        path   = each.value.pages.path
      }
      cname = each.value.pages.cname
    }
  }

  lifecycle {
    ignore_changes = [
      template
    ]
  }
}
