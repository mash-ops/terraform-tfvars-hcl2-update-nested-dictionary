prefix        = "dc01"
component_name = "yourProduct"
location      = "Your Location"
tags = {
  Server_Type = "virtual"
  datacenter  = "DC01"
  Enviornment = "PROD"
  Tier        = "App/DB"
  Owner      = "Manjesh Munegowda"
  Application = "yourProduct DC01 Prod"
  PatternID  = "D8s v3"
  usageHours  = "24X7"
  availTier  = "99.99%"
  regulatory  = "NA"
  createDate  = "2022-06-09"
  reviewDate  = "2022-06-09"
  costCenter  = "costCenterL4"
  builtByTool = "terraform"
  VPCName    = "dc01-app-vnet"
  subnet      = "dc01-yourProduct-sbn"
  exposure    = "private"
  business    = "corporate"
}

####################################### Network Configuration #######################################
vnet_name              = "dc01-app-vnet"
app_subnet_name        = "dc01-yourProduct-sbn"
backup_subnet_name      = "dc01-backup-sbn"
availability_set        = "dc01myProdas"
resource_group_name    = "dc01-yourProduct-rg"
asg_name                = "dc01-ecp-prd-customer106"
asg_resource_group_name = "dc01-network-rg"
nsg_name                = "dc01-ecp-prd-customer106-nsg"
nsg_resource_group_name = "pb01-network-rg"
product                = "yourProduct"
managed_identity_type = "SystemAssigned"
network_resource_group_name = "dc01-network-rg"
sids = {
  dev  = "c1u"
  qa  = "c1v"
  prod = "c1w"
}

####################################### Bootstrap Configuration #######################################
bootstrap_config = {
  automation_username      = "automationUser"
  automation_user_id      = "4001"
  automation_environment  = "dc01_yourProduct_prod"
  automation_template_path = "/automation/github/dc01_yourProduct_prod/hcm-chef-automation/platform/rundeck-jobs/chef-full.erb"
  name_servers            = "10.232.135.4,10.232.135.5"
  automation_mount        = "10.66.99.4,dc01-automation-vol01"
  roaming_mount            = "10.66.99.4,dc01-home-roaming-vol01"
  suse_repo                = "ss01mgtsupx01.dc01.yourDomain"
  chef_server_url          = "https://chef.dc01.yourDomain:443/organizations/dc01"
  yum_repo_url            = "http://yum.dc01.yourDomain/xyz/"
}
image_resource_id = "/subscriptions/89fe98e7-0242-4608-a261-f61fc59990c5/resourceGroups/ss60-shared-imagegallery-rg/providers/Microsoft.Compute/galleries/HXMSharedImages/images/SLES12SP5-Payroll-Image-Definition/versions/latest"

####################################### VM Creation #######################################


myProd_db = {
  vm_count        = 1
  hostname_pattern = "myProd<SID>d"
  availability_set_name_pattern = "myProdc1wd"
  vm_size          = "Standard_D8s_v3"
  cloud_netconfig = "no"
}

myProd_ai_ci = {
  hostname_list                = ["dc01myProdc1wa01","dc01myProdc1wc01"]
  availability_set_name_pattern = "myProdc1wc"
  vm_size                      = "Standard_D8s_v3"
  cloud_netconfig = "no"
}


nfs_mounts = {
  basmnt_nfs_repository = {
    volume = "10.66.99.5:/dc01-basmnt-repository-vol02"
    mount  = "/basmnt/repository"
    options = "rw,vers=4.1,hard,timeo=600,rsize=65536,wsize=65536,intr,noatime,lock,_netdev,sec=sys"
  }
  basmnt_nfs_audit = {
    volume = "10.66.99.5:/dc01-basmnt-audit-vol02"
    mount = "/basmnt/audit"
    options = "rw,vers=4.1,hard,timeo=600,rsize=65536,wsize=65536,intr,noatime,lock,_netdev,sec=sys"
  }
}


##====================================== QA server =======================================#

myProd_qa = {
  vm_count        = 1
  hostname_pattern = "myProd<SID>"
  availability_set_name_pattern = "myProdc1v"
  vm_size          = "Standard_D8s_v3"
  cloud_netconfig = "no"
  managed_identity_type  = ""

nfs_mounts = {
  basmnt_nfs_repository = {
    volume = "10.66.99.5:/dc01-basmnt-repository-vol02"
    mount  = "/basmnt/repository"
    options = "rw,vers=4.1,hard,timeo=600,rsize=65536,wsize=65536,intr,noatime,lock,_netdev,sec=sys"
  }
  basmnt_nfs_audit = {
    volume = "10.66.99.5:/dc01-basmnt-audit-vol02"
    mount = "/basmnt/audit"
    options = "rw,vers=4.1,hard,timeo=600,rsize=65536,wsize=65536,intr,noatime,lock,_netdev,sec=sys"
  }
}
}

##====================================== DEV server =======================================#

myProd_dev = {
  vm_count        = 1
  hostname_pattern = "myProd<SID>"
  availability_set_name_pattern = "myProdc1u"
  vm_size          = "Standard_D8s_v3"
  cloud_netconfig = "no"
  managed_identity_type  = ""

nfs_mounts = {
  basmnt_nfs_repository = {
    volume = "10.66.99.5:/dc01-basmnt-repository-vol02"
    mount  = "/basmnt/repository"
    options = "rw,vers=4.1,hard,timeo=600,rsize=65536,wsize=65536,intr,noatime,lock,_netdev,sec=sys"
  }
  basmnt_nfs_audit = {
    volume = "10.66.99.5:/dc01-basmnt-audit-vol02"
    mount = "/basmnt/audit"
    options = "rw,vers=4.1,hard,timeo=600,rsize=65536,wsize=65536,intr,noatime,lock,_netdev,sec=sys"
  }
}
}

#################################### Local Disk ###############################################
##=================================== prod disks=============================================##
myProd_ai_ci_disks = {
  app = {
    size    = 1
    type    = "Premium_LRS"
    lun    = 5
  }
}

myProd_db_disks = {
  myProd_yourCompanydb = {
    size    = 32
    type    = "Premium_LRS"
    lun    = 5
    vg      = "VG_yourCompanyDB01"
    lv      = "yourCompany_DB01"
    mount  = "/yourCompanydb"
    caching = "ReadWrite"
  },
  myProd_yourCompanydb_arch = {
    size    = 64
    type    = "Premium_LRS"
    lun    = 6
    vg      = "VG_yourCompanyARCH01"
    lv      = "yourCompany_ARCH01"
    mount  = "/yourCompanydb/<SID>/yourCompanyarch"
    caching = "ReadWrite"
  },
  myProd_yourCompanydb_log = {
    size    = 32
    type    = "Premium_LRS"
    lun    = 7
    vg      = "VG_yourCompanyLOG01"
    lv      = "yourCompany_LOG01"
    mount  = "/yourCompanydb/<SID>/yourCompanylog1"
    caching = "ReadWrite"
  },
  myProd_yourCompanydb_data_disk = {
    size    = 512
    type    = "Premium_LRS"
    lun    = 8
    vg      = "VG_yourCompanyDATA01"
    lv      = "yourCompany_DATA01"
    mount  = "/yourCompanydb/<SID>/yourCompanydata1"
    caching = "ReadWrite"
  },
  myProd_trans_disk = {
    size    = 128
    type    = "Premium_LRS"
    lun    = 9
    vg      = "VG_yourCompanyTRANS01"
    lv      = "yourCompany_TRANS01"
    mount  = "/usr/yourCompany/trans"
    caching = "ReadWrite"
  },
  nfs_share = {
    size    = 128
    type    = "Premium_LRS"
    lun    = 11
    vg      = "VG_NFS01"
    lv      = "NFS01"
    mount  = "/nfs_share"
    caching = "ReadWrite"
  }
}

##=================================== Qa disks=============================================##

myProd_qa_disks = {
  myProd_yourCompanydb = {
    size    = 32
    type    = "Premium_LRS"
    lun    = 5
    vg      = "VG_yourCompanyDB01"
    lv      = "yourCompany_DB01"
    mount  = "/yourCompanydb"
    caching = "ReadWrite"
  },
  myProd_yourCompanydb_arch = {
    size    = 64
    type    = "Premium_LRS"
    lun    = 6
    vg      = "VG_yourCompanyARCH01"
    lv      = "yourCompany_ARCH01"
    mount  = "/yourCompanydb/<SID>/yourCompanyarch"
    caching = "ReadWrite"
  },
  myProd_yourCompanydb_log = {
    size    = 32
    type    = "Premium_LRS"
    lun    = 7
    vg      = "VG_yourCompanyLOG01"
    lv      = "yourCompany_LOG01"
    mount  = "/yourCompanydb/<SID>/yourCompanylog1"
    caching = "ReadWrite"
  },
  myProd_yourCompanydb_data_disk = {
    size    = 512
    type    = "Premium_LRS"
    lun    = 8
    vg      = "VG_yourCompanyDATA01"
    lv      = "yourCompany_DATA01"
    mount  = "/yourCompanydb/<SID>/yourCompanydata1"
    caching = "ReadWrite"
  },
  nfs_share = {
    size    = 128
    type    = "Premium_LRS"
    lun    = 11
    vg      = "VG_NFS01"
    lv      = "NFS01"
    mount  = "/nfs_share"
    caching = "ReadWrite"
  }
}


##=================================== Dev disks=============================================##

myProd_dev_disks = {
  myProd_yourCompanydb = {
    size    = 32
    type    = "Premium_LRS"
    lun    = 5
    vg      = "VG_yourCompanyDB01"
    lv      = "yourCompany_DB01"
    mount  = "/yourCompanydb"
    caching = "ReadWrite"
  },
  myProd_yourCompanydb_arch = {
    size    = 64
    type    = "Premium_LRS"
    lun    = 6
    vg      = "VG_yourCompanyARCH01"
    lv      = "yourCompany_ARCH01"
    mount  = "/yourCompanydb/<SID>/yourCompanyarch"
    caching = "ReadWrite"
  },
  myProd_yourCompanydb_log = {
    size    = 32
    type    = "Premium_LRS"
    lun    = 7
    vg      = "VG_yourCompanyLOG01"
    lv      = "yourCompany_LOG01"
    mount  = "/yourCompanydb/<SID>/yourCompanylog1"
    caching = "ReadWrite"
  },
  myProd_yourCompanydb_data_disk = {
    size    = 512
    type    = "Premium_LRS"
    lun    = 8
    vg      = "VG_yourCompanyDATA01"
    lv      = "yourCompany_DATA01"
    mount  = "/yourCompanydb/<SID>/yourCompanydata1"
    caching = "ReadWrite"
  },
 
  nfs_share = {
    size    = 128
    type    = "Premium_LRS"
    lun    = 11
    vg      = "VG_NFS01"
    lv      = "NFS01"
    mount  = "/nfs_share"
    caching = "ReadWrite"
  }
}

nfs_exports = ["/yourCompanymnt/<SID>", "/usr/yourCompany/<SID>", "/yourCompanydb"]
nfs_exports_qa = ["/yourCompanymnt/<SID>", "/usr/yourCompany/<SID>"]
nfs_exports_dev = ["/yourCompanymnt/<SID>", "/usr/yourCompany/<SID>"]
