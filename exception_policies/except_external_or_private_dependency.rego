# Policy to match and ignore findings for transitive dependencies that can only be reached via external/private dependency

## Policy to match and ignore findings for transitive dependencies that can only be reached via any external/private dependency

package main

match_finding[result] {
    some i
    finding := data.resources.Finding[i]
    finding.spec.finding_tags[_] == "FINDING_TAGS_PATH_EXTERNAL"
    result = {
        "Endor" : {
            "Finding" : finding.uuid
        }
    }
}

## Policy to match and ignore findings for transitive dependencies that can only be reached via specific external/private dependency
### Below rego policy will ignore findings for transitive dependencies that can only be reached via "com.customer.platform.integration.commons:logger"

package main

match_finding[result] {
    some i
    finding := data.resources.Finding[i]
    finding.spec.finding_tags[_] == "FINDING_TAGS_PATH_EXTERNAL"
    contains(finding.spec.relationship, "com.customer.platform.integration.commons:logger")

    result = {
        "Endor" : {
            "Finding" : finding.uuid
        }
    }
}

## Policy to match and ignore findings for transitive dependencies that can only be reached via selective multiple external/private dependency
### Below rego policy will ignore findings for transitive dependencies that can only be reached via "com.customer.platform.integration.commons:obs-example1", "com.customer.platform.integration.commons:obs-example1" or "com.customer.platform.integration.commons:obs-example1"

package main

match_finding[result] {
    some i
    finding := data.resources.Finding[i]
    finding.spec.finding_tags[_] == "FINDING_TAGS_PATH_EXTERNAL"
    is_match(finding.spec.relationship)

    result = {
        "Endor" : {
            "Finding" : finding.uuid
        }
    }
}

### Helper function to check for multiple conditions
is_match(relationship) {
    contains(relationship, "com.customer.platform.integration.commons:obs-example1")
} else {
    contains(relationship, "com.customer.platform.integration.commons:obs-example2")
} else {
    contains(relationship, "com.customer.platform.integration.commons:obs-example3")
}
