module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 9.0"

  project_id   = var.project_id
  network_name = local.cluster_name

  subnets = [
    {
      subnet_name           = "public-subnet-1"
      subnet_ip             = "172.16.1.0/24"
      subnet_region         = var.region
      subnet_private_access = false
      subnet_flow_logs      = false
    },
    {
      subnet_name           = "public-subnet-2"
      subnet_ip             = "172.16.2.0/24"
      subnet_region         = var.region
      subnet_private_access = false
      subnet_flow_logs      = false
    },
    {
      subnet_name           = "public-subnet-3"
      subnet_ip             = "172.16.3.0/24"
      subnet_region         = var.region
      subnet_private_access = false
      subnet_flow_logs      = false
    },
    {
      subnet_name           = "private-subnet-1"
      subnet_ip             = "172.16.4.0/24"
      subnet_region         = var.region
      subnet_private_access = true
      subnet_flow_logs      = false
    },
    {
      subnet_name           = "private-subnet-2"
      subnet_ip             = "172.16.5.0/24"
      subnet_region         = var.region
      subnet_private_access = true
      subnet_flow_logs      = false
    },
    {
      subnet_name           = "private-subnet-3"
      subnet_ip             = "172.16.6.0/24"
      subnet_region         = var.region
      subnet_private_access = true
      subnet_flow_logs      = false
    }
  ]

  secondary_ranges = {
    public-subnet-2 = [
      {
        range_name    = "pods-range"
        ip_cidr_range = "192.168.0.0/20"
      },
      {
        range_name    = "services-range"
        ip_cidr_range = "10.0.0.0/20"
      }
    ]
  }

  routes = [
        {
            name                   = "multicloud-aks-routes"
            description            = "route through IGW to access internet"
            destination_range      = "0.0.0.0/0"
            tags                   = "egress-inet"
            next_hop_internet      = "true"
        }
  ]
}

resource "google_compute_network" "network" {
  name                    = "multicloud-gke-network"
  project = var.project_id
  auto_create_subnetworks = false
}

resource "google_compute_router" "router" {
  name    = "multicloud-gke-router"
  network = google_compute_network.network.name
  project = var.project_id
  region  = var.region
}

resource "google_compute_router_nat" "nat_manual" {
  name   = "multicloud-gke-nat"
  router = google_compute_router.router.name
  region = var.region
  project = var.project_id

  nat_ip_allocate_option = "AUTO_ONLY"

  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_PRIMARY_IP_RANGES"
}

resource "google_dns_managed_zone" "multicloud-gke-dns" {
  name        = "multicloud-gke-dns"
  dns_name    = "rrsinfo.xyz."
  project = var.project_id
  description = "Multicloud DNS zone"
}