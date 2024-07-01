package scorecards

match_score_factors[result] {
    some i
    data.resources.Metric[i].meta.parent_uuid == data.resources.PackageVersion[_].uuid
    data.resources.Metric[i].meta.name == "package_version_scorecard"
    data.resources.Metric[i].spec.metric_values.scorefactor.score_factor_list.score_factors[_].id == "hasNoMake"
    data.resources.Metric[i].spec.metric_values.scorefactor.score_factor_list.score_factors[_].id == "repoIsPersonal"
    result = {
        "Endor" : {
            "PackageVersion" : data.resources.Metric[i].meta.parent_uuid
        }
    }
}


# Query: data.scorecards.match_score_factors
# Resource Kinds: Metric,PackageVersion
