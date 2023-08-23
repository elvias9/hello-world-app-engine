output "load-balancer-ip" {
    value = module.app-engine-ext-lb.external_ip
    description = "HTTP Load Balancer IP address"
}