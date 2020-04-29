module "databricks-datalake" {
  source                      = "../modules/databricks-datalake"
  databricks_datalake_rg_name = var.databricks_datalake_rg_name
  env                         = "dev"
}
