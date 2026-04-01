package example

match_package_version[result] {
	some i, j
	data.resources.Metric[i].meta.name == "package_version_scorecard"
	data.resources.Metric[i].meta.parent_kind == "PackageVersion"
	data.resources.Metric[i].meta.parent_uuid == data.resources.PackageVersion[j].uuid
	score := data.resources.Metric[i].spec.metric_values.scorecard.score_card.overall_score
	score < 4
	releasedate := data.resources.PackageVersion[j].spec.release_timestamp


	result = {
		"Endor": {"PackageVersion": data.resources.Metric[i].meta.parent_uuid},
		"Score": sprintf("%v", [score]),
		"YOOOOOOOOO DEEEEETS": "THESE ARE THE DETAILS",
		"Release Date": sprintf("%v", [releasedate])
	}
}
