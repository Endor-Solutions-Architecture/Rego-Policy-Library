package version

match_exact_package_version[result] {
  some i
  data.resources.Metric[i].meta.name == "pkg_version_stats_for_dependency"
  data.resources.Metric[i].meta.parent_kind == "PackageVersion"
  data.resources.Metric[i].meta.parent_uuid == data.resources.PackageVersion[_].uuid
  data.resources.Metric[i].spec.metric_values.dependencyStatsType.dependency_stats.dependency_specs[_].dependency_name == "django"
  data.resources.Metric[i].spec.metric_values.dependencyStatsType.dependency_stats.dependency_specs[_].dependency_version == "4.2"



  result = {
    "Endor": {
      "PackageVersion": data.resources.Metric[i].meta.parent_uuid,
    }
  }
}