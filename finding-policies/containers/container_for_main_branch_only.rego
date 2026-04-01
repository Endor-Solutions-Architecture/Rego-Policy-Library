package main

match_finding[result] {
	some i
	finding := data.resources.Finding[i]
	finding.context.type == "CONTEXT_TYPE_MAIN"
  finding.spec.level == "FINDING_LEVEL_CRITICAL"
	finding.spec.finding_tags[_] == "FINDING_TAGS_FIX_AVAILABLE"
  finding.spec.finding_categories[_] == "FINDING_CATEGORY_CONTAINER"
	result = {
		"Endor" : {
			"Finding" : finding.uuid
		}
	}
} 