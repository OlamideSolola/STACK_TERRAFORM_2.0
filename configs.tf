data "template_file" "bootstrap_clixx" {
  template = file(format("%s/scripts/bootstrap_clixx.tpl", path.module))
  vars={
    GIT_REPO="https://github.com/stackitgit/CliXX_Retail_Repository.git",
    MOUNT_POINT ="/var/www/html"
    file_system_id=aws_efs_file_system.web-app-efs.id
    region = local.creds.AWS_REGION
    AWS_REGION = local.creds.AWS_REGION
    DB_NAME=local.creds.DB_NAME
    DB_USER=local.creds.DB_USER
    DB_PASSWORD=local.creds.DB_PASSWORD
    DB_EMAIL=var.DB_EMAIL
    LB_DNS=aws_lb.Clixx-App-lb.dns_name
    EBS-vol1=var.EBS-vol1
    EBS-vol2=var.EBS-vol2
    EBS-vol3=var.EBS-vol3
    EBS-vol4=var.EBS-vol4
    EBS-vol-backup=var.EBS-vol-backup
    DB_HOST=split(":", aws_db_instance.Clixx_database_instance[0].endpoint)[0]
  }
}
