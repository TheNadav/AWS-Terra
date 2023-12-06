# Rules----------------------------------------------

variable "CommonRuleSet_actions_override" {
   type    = list(any)
   default = [
"GenericRFI_URIPATH_RC_COUNT",
"GenericRFI_BODY_RC_COUNT",
"GenericRFI_QUERYARGUMENTS_RC_COUNT",
"RestrictedExtensions_QUERYARGUMENTS_RC_COUNT",
"RestrictedExtensions_URIPATH_RC_COUNT",
"GenericLFI_BODY_RC_COUNT",
"GenericLFI_URIPATH_RC_COUNT",
"GenericLFI_QUERYARGUMENTS_RC_COUNT",
"EC2MetaDataSSRF_QUERYARGUMENTS_RC_COUNT",
"EC2MetaDataSSRF_URIPATH_RC_COUNT",
"EC2MetaDataSSRF_COOKIE_RC_COUNT",
"EC2MetaDataSSRF_BODY_RC_COUNT",
"UserAgent_BadBots_HEADER_RC_COUNT",
"NoUserAgent_HEADER",
"UserAgent_BadBots_HEADER",
"SizeRestrictions_QUERYSTRING",
"SizeRestrictions_Cookie_HEADER",
"SizeRestrictions_BODY",
"SizeRestrictions_URIPATH",
"EC2MetaDataSSRF_BODY",
"EC2MetaDataSSRF_COOKIE",
"EC2MetaDataSSRF_URIPATH",
"EC2MetaDataSSRF_QUERYARGUMENTS",
"GenericLFI_QUERYARGUMENTS",
"GenericLFI_URIPATH",
"GenericLFI_BODY",
"RestrictedExtensions_URIPATH",
"RestrictedExtensions_QUERYARGUMENTS",
"GenericRFI_QUERYARGUMENTS",
"GenericRFI_BODY",
"GenericRFI_URIPATH",
"CrossSiteScripting_COOKIE",
"CrossSiteScripting_QUERYARGUMENTS",
"CrossSiteScripting_BODY",
"CrossSiteScripting_URIPATH"
]
}

variable "LinuxRuleSet_actions_override" {
   type    = list(any)
   default = [
"LFI_URIPATH",
"LFI_QUERYSTRING",
"LFI_HEADER"
]
}

variable "IpReputationList_actions_override" {
   type    = list(any)
   default = [
"AWSManagedIPReputationList",
"AWSManagedReconnaissanceList",
"AWSManagedIPDDoSList"
]
}

variable "BadInputsRule_actions_override" {
   type    = list(any)
   default = [
"JavaDeserializationRCE_BODY",
"JavaDeserializationRCE_URIPATH",
"JavaDeserializationRCE_QUERYSTRING",
"JavaDeserializationRCE_HEADER",
"Host_localhost_HEADER",
"PROPFIND_METHOD",
"ExploitablePaths_URIPATH",
"Log4JRCE_QUERYSTRING",
"Log4JRCE_BODY",
"Log4JRCE_URIPATH",
"Log4JRCE_HEADER"
]
}

variable "SQLiRule_actions_override" {
   type    = list(any)
   default = [
"SQLiExtendedPatterns_QUERYARGUMENTS",
"SQLi_QUERYARGUMENTS",
"SQLi_BODY",
"SQLi_COOKIE",
"SQLi_URIPATH",
"SQLiExtendedPatterns_BODY"
]
}

variable "UnixRuleSet_actions_override" {
   type    = list(any)
   default = [
"UNIXShellCommandsVariables_QUERYARGUMENTS",
"UNIXShellCommandsVariables_BODY"
]
}

