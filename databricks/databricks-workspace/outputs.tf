output "cluster_url" {
  value = "https://${azurerm_databricks_workspace.databricks_workspace.name}.azuredatabricks.net#cluster/${databricks_cluster.cluster-databricks.id}"
}

output "workspace_url" {
  value = azurerm_databricks_workspace.databricks_workspace.workspace_url
  }