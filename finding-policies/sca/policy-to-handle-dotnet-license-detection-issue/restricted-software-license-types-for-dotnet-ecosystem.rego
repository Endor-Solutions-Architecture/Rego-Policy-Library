package license

match_type(type) {
  not input.LicenseTypes
  type == "FORBIDDEN"
}

match_type(type) {
  not input.LicenseTypes
  type == "restricted"
}

match_type(type) {
  input.LicenseTypes[_] == type
}

match_license_type[result] {
  some i, j, k
  data.resources.Metric[i].meta.name == "pkg_version_info_for_license"
  data.resources.Metric[i].meta.parent_kind == "PackageVersion"
  data.resources.Metric[i].meta.parent_uuid == data.resources.PackageVersion[k].uuid
  data.resources.PackageVersion[k].spec.ecosystem == "ECOSYSTEM_NUGET"
  match_type(data.resources.Metric[i].spec.metric_values.licenseInfoType.license_info.package_manager_licenses[j].type)

  result = {
    "Endor": {
      "PackageVersion": data.resources.Metric[i].meta.parent_uuid,
    },
    "License SPDX id": data.resources.Metric[i].spec.metric_values.licenseInfoType.license_info.package_manager_licenses[j].spdxid,
    "License Name": data.resources.Metric[i].spec.metric_values.licenseInfoType.license_info.package_manager_licenses[j].name,
  }
}