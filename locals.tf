locals {
  repos_yml = yamldecode(file(var.config_path))

  repos = {
    for key, value in local.repos_yml : key => {
      name                 = key
      description          = lookup(value, "description", null)
      visibility           = lookup(value, "visibility", "private")
      topics               = lookup(value, "topics", [])
      has_wiki             = lookup(value, "has_wiki", false)
      has_projects         = lookup(value, "has_projects", false)
      has_issues           = lookup(value, "has_issues", false)
      vulnerability_alerts = lookup(value, "vulnerability_alerts", false)
      is_template          = lookup(value, "is_template", false)
      pages                = lookup(value, "pages", null)
      template             = lookup(value, "template", null)
    }
  }
}
