package version

match_exact_package_version[result] {

some i, j

data.resources.DependencyMetadata[i].spec.dependency_data.package_name == "pypi://django"
data.resources.DependencyMetadata[i].spec.dependency_data.resolved_version == "4.2"
data.resources.PackageVersion[j].meta.name == data.resources.DependencyMetadata[i].spec.dependency_data.parent_version_name

result = {
  "Endor": {
    "PackageVersion": data.resources.PackageVersion[j].uuid,
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