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

# Do not add this and the below to the rego statement - settings for Endor UI

# Query statement:
# data.version.match_exact_package_version

# Resource kinds:
# Metric, Package Version

# Summary:
# This finding of Django will be EOL in April 2026

# Finding Categories:
# Operational

# Name:
# EOL version of Django

# Description:
# Identifies and recommends an update of an EOL version of Django