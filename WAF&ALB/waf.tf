resource "aws_wafv2_web_acl" "WafWebAcl" {
  name  = "Testing-WAF-ACL"
  description = "OWASP top 10 detection and prevention ACL"
  scope = "REGIONAL"
  
  default_action {
    allow {
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "WAF_Common_Protections"
    sampled_requests_enabled   = true
  }

# --------------------AWSManagedRulesCommonRuleSet--------------------

  rule {
    name     = "AWS-AWSManagedRulesCommonRuleSet"
    priority = 20

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
        version = "Version_1.8"
# -----------------------
        dynamic "rule_action_override" {
          for_each = var.CommonRuleSet_actions_override
           content {
             name = rule_action_override.value
             action_to_use {
             block {}
              }
            }
          }
# -----------------------
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesCommonRuleSet"
      sampled_requests_enabled   = true
    }
  }

# ---------------AWSManagedRulesLinuxRuleSet-----------------------

  rule {
    name     = "AWS-AWSManagedRulesLinuxRuleSet"
    priority = 50

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesLinuxRuleSet"
        vendor_name = "AWS"
        version = "Version_2.2"
# -----------------------
        dynamic "rule_action_override" {
          for_each = var.LinuxRuleSet_actions_override
           content {
             name = rule_action_override.value
             action_to_use {
             block {}
              }
            }
          }
# -----------------------
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesLinuxRuleSet"
      sampled_requests_enabled   = true
    }
  }

# ---------------WSManagedRulesAmazonIpReputationList----------------

  rule {
    name     = "AWS-AWSManagedRulesAmazonIpReputationList"
    priority = 10

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAmazonIpReputationList"
        vendor_name = "AWS"
# -----------------------
        dynamic "rule_action_override" {
          for_each = var.IpReputationList_actions_override
           content {
             name = rule_action_override.value
             action_to_use {
             block {}
              }
            }
          }
# -----------------------
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesAmazonIpReputationList"
      sampled_requests_enabled   = true
    }
  }

# ---------------AWSManagedRulesKnownBadInputsRuleSet-----------------

  rule {
    name     = "AWS-AWSManagedRulesKnownBadInputsRuleSet"
    priority = 40

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
        version = "Version_1.19"
# -----------------------
        dynamic "rule_action_override" {
          for_each = var.BadInputsRule_actions_override
           content {
             name = rule_action_override.value
             action_to_use {
             block {}
              }
            }
          }
# -----------------------
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesKnownBadInputsRuleSet"
      sampled_requests_enabled   = true
    }
  }
# ---------------AWSManagedRulesUnixRuleSet-----------------

  rule {
    name     = "AWS-AWSManagedRulesUnixRuleSet"
    priority = 60

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesUnixRuleSet"
        vendor_name = "AWS"
        version = "Version_2.1"
# -----------------------
        dynamic "rule_action_override" {
          for_each = var.UnixRuleSet_actions_override
           content {
             name = rule_action_override.value
             action_to_use {
             block {}
              }
            }
          }
# -----------------------
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesKnownBadInputsRuleSet"
      sampled_requests_enabled   = true
    }
  }
# ---------------AWSManagedRulesSQLiRuleSet------------------------

  rule {
    name     = "AWS-AWSManagedRulesSQLiRuleSet"
    priority = 30

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
        version = "Version_2.0"
# -----------------------
        dynamic "rule_action_override" {
          for_each = var.SQLiRule_actions_override
           content {
             name = rule_action_override.value
             action_to_use {
             block {}
              }
            }
          }
# -----------------------
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesSQLiRuleSet"
      sampled_requests_enabled   = true
    }
  }


}
# --------------------------------logging-------------------------------------
resource "aws_s3_bucket" "aws-waf-logs-s3" {
  bucket = "aws-waf-logs-${random_uuid.uuid.result}"
  tags = {
    Environment = "Dev"
  }
}
resource "random_uuid" "uuid" {}

resource "aws_wafv2_web_acl_logging_configuration" "example" {
  log_destination_configs = [aws_s3_bucket.aws-waf-logs-s3.arn]
  resource_arn            = aws_wafv2_web_acl.WafWebAcl.arn
}

# --------------------------------association-------------------------------------

resource "aws_wafv2_web_acl_association" "association" {
  web_acl_arn = aws_wafv2_web_acl.WafWebAcl.arn
  resource_arn = aws_lb.front.arn
}