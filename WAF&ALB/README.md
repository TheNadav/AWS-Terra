# AWS Infrastructure with AWS ALB, Linux Instances, WAF, Logstash, and Microsoft Sentinel Integration

This repository contains Terraform code to deploy a scalable and secure infrastructure on AWS using the Application Load Balancer (ALB), Linux instances, Web Application Firewall (WAF), Logstash, and integration with Microsoft Sentinel SIEM.

## Infrastructure Components

### 1. AWS ALB and Linux Instances

The Terraform deploy an AWS Application Load Balancer (ALB) along with Linux instances to host your application.

### 2. AWS WAF

Web Application Firewall (WAF) is integrated into the infrastructure to protect the web applications from common web exploits that could affect application availability, compromise security, or consume excessive resources.

### 3. Logstash

Logstash is deployed as part of the infrastructure to collect, process, and forward logs. It is configured to receive logs from the waf s3 bucket and ship them to Azure log analytics workspace.

### 4. Microsoft Sentinel Integration

Logs collected by Logstash are forwarded to Microsoft Sentinel, a cloud-native SIEM (Security Information and Event Management) solution. This integration enhances the security posture of your infrastructure by providing real-time threat intelligence and advanced analytics.
