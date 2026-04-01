package exclude_finding

exclude_by_location[result] {
  some i
  data.resources.Finding[i].spec.finding_categories[_] == "FINDING_CATEGORY_SECRETS"
  locations := [
    "https://github.com/foo/bar/blob/1234/test#L1", 
    "https://github.com/foo/bar/blob/1234/src/main/log.csv#L1" ]
  locations[_] == data.resources.Finding[i].spec.finding_metadata.source_policy_info.results[_].fields["Secret Location"] 

  result = {
    "Endor" : {
      "Finding" : data.resources.Finding[i].uuid
    }
  }
}


# Query: data.exclude_finding.exclude_by_location
# Resource Kinds: Finding
# Validate: endorctl validate policy -n <namespace> --policy secrets_exception_by_location.rego --query data.exclude_finding.exclude_by_location --uuid <project_uuid>
