package action

match_findings[result] {
  some i
  severity := ["FINDING_LEVEL_CRITICAL", "FINDING_LEVEL_HIGH"]
  data.resources.Finding[i].spec.finding_categories[_] == "FINDING_CATEGORY_VULNERABILITY"
  severity[_] == data.resources.Finding[i].spec.level 
  data.resources.Finding[i].spec.finding_tags[_] == "FINDING_TAGS_REACHABLE_FUNCTION"
  result = {
    "Endor" : {
      "Finding" : data.resources.Finding[i].uuid
    }
  }
}