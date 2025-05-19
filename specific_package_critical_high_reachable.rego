package main

package_names := [
    "npm://pnpm_test@1.0.0", 
    "npm://test-app@1.0.0",
    "npm://@tt-pro/custom-form-service@1.0.0"
]

test_dependency(finding) {
	finding.spec.finding_tags[_] == "FINDING_TAGS_TEST"
}

is_target_package(finding) {
    some i
    package_name := package_names[i]
    
    some j
    data.resources.PackageVersion[j].uuid == finding.meta.parent_uuid
    data.resources.PackageVersion[j].meta.name == package_name
}

match_finding_specific_packages[result] {
	some i
	finding := data.resources.Finding[i]
	finding.context.type == "CONTEXT_TYPE_MAIN"
	severity := ["FINDING_LEVEL_CRITICAL", "FINDING_LEVEL_HIGH"]
	finding.spec.level == severity[_]
	not test_dependency(finding)
	finding.spec.finding_tags[_] == "FINDING_TAGS_FIX_AVAILABLE"
	finding.spec.finding_tags[_] == "FINDING_TAGS_REACHABLE_DEPENDENCY"
	finding.spec.finding_tags[_] == "FINDING_TAGS_REACHABLE_FUNCTION"
    finding.spec.finding_metadata.vulnerability.spec.epss_score.probability_score >= 0.01
    is_target_package(finding)

	result = {
		"Endor" : {
			"Finding" : finding.uuid
		}
	}
}
