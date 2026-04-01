package popularity_score

match_popularity_score[result] {
	some i
	data.resources.Metric[i].meta.name == "package_version_scorecard"
	data.resources.Metric[i].meta.parent_kind == "PackageVersion"
	data.resources.Metric[i].meta.parent_uuid == data.resources.PackageVersion[_].uuid
	
	data.resources.Metric[i].spec.raw.scoreCard.Scores.Popularity < 4

	result = {
		"Endor": {"PackageVersion": data.resources.Metric[i].meta.parent_uuid},
		"Details": "Not a popular package!!"
	}
}

# Query: data.popularity_score.match_popularity_score
# Resource Kinds: Metric,PackageVersion
