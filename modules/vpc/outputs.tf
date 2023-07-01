output "vpc_id" {
  value = aws_vpc.webapp_vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnet[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnet[*].id
}

output "nat_gateway_ids" {
  value = aws_nat_gateway.webapp_ngw[*].id
}

output "public_route_table_id" {
  value = aws_route_table.public_rt.id
}

output "private_route_table_id" {
  value = aws_route_table.private_rt[*].id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.webapp_igw.id
}
