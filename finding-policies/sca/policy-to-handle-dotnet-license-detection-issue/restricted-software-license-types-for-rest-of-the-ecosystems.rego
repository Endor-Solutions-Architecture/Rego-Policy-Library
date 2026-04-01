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
  some i, j
  data.resources.Metric[i].meta.name == "pkg_version_info_for_license"
  data.resources.Metric[i].meta.parent_kind == "PackageVersion"
  data.resources.Metric[i].meta.parent_uuid == data.resources.PackageVersion[_].uuid
  data.resources.PackageVersion[_].spec.ecosystem != "ECOSYSTEM_NUGET"
  match_type(data.resources.Metric[i].spec.metric_values.licenseInfoType.license_info.all_licenses[j].type)

  result = {
    "Endor": {
      "PackageVersion": data.resources.Metric[i].meta.parent_uuid,
    },
    "License SPDX id": data.resources.Metric[i].spec.metric_values.licenseInfoType.license_info.all_licenses[j].spdxid,
    "License Name": data.resources.Metric[i].spec.metric_values.licenseInfoType.license_info.all_licenses[j].name,
  }
}