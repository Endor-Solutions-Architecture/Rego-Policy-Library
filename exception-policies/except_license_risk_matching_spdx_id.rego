package main

match_finding[result] {
    some i
    finding := data.resources.Finding[i]
    contains(finding.meta.description, "License Compliance Violation")
    contains(finding.spec.summary, "License SPDX id: EDL-1.0")

    result = {
        "Endor" : {
            "Finding" : finding.uuid
        }
    }
}

