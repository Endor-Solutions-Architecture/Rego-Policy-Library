package newdeps

match_new_dependency_version[result] {
  some i
  release := data.resources.PackageVersion[i].spec.release_timestamp
  difference := (time.now_ns() - time.parse_rfc3339_ns(release)) / 1000000000
  difference <=  2592000
  

  result = {
    "Endor": {
      "PackageVersion": data.resources.PackageVersion[i].uuid
    },
    "Age of Dependency in Days": sprintf("%v", [difference / 60 / 60 / 24 ])
  }
}

# Query: data.newdeps.match_new_dependency_version
# Resource Kinds: PackageVersion
