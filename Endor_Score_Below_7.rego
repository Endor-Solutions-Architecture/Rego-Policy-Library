package example

match_package_version[result] {
	some i
	data.resources.Metric[i].meta.name == "package_version_scorecard"
	data.resources.Metric[i].meta.parent_kind == "PackageVersion"
	data.resources.Metric[i].meta.parent_uuid == data.resources.PackageVersion[_].uuid
	score := data.resources.Metric[i].spec.metric_values.scorecard.score_card.overall_score
	score < 7

	result = {
		"Endor": {"PackageVersion": data.resources.Metric[i].meta.parent_uuid},
		"Score": sprintf("%v", [score]),
	}
}
