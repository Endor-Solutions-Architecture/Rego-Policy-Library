# Troubleshooting: False Positive License Compliance Violations for .NET Packages

## Problem Encountered

You may encounter numerous license compliance violation findings for .NET packages that appear to be incorrectly flagged. Common symptoms include:

- `System.*` and `Microsoft.Extensions.*` packages being flagged with incorrect licenses (e.g., GPL-2.0 instead of MIT)
- Packages that show MIT license on NuGet.org being detected as having restrictive licenses
- Large numbers of license compliance findings (e.g., 125+ findings in a single project)
- Difficulty identifying legitimate license violations due to the volume of false positives

This occurs because the default license policy evaluates **all** license information collected by Endor Labs, including licenses detected from files, repository metadata, and other sources beyond the package manager declarations.

## Solution

To resolve this issue, switch from the default license policy to the package manager-specific policy:

1. Navigate to **Policies > Finding Policies > License Risk**
2. Create two new finding policies — one to restrict license checks to package manager licenses only for .NET dependencies, and another to run license checks against all license sources for other ecosystems. The rego policies are provided in this folder:
   - [`restricted-software-license-types-for-dotnet-ecosystem.rego`](restricted-software-license-types-for-dotnet-ecosystem.rego) — evaluates only `package_manager_licenses` for NuGet packages
   - [`restricted-software-license-types-for-rest-of-the-ecosystems.rego`](restricted-software-license-types-for-rest-of-the-ecosystems.rego) — evaluates `all_licenses` for non-NuGet packages
3. Toggle **ON** the "Restricted software license types for .NET (package manager licenses)" policy
4. Toggle **ON** the "Restricted software license types for other ecosystem (all licenses)" policy
5. Toggle **OFF** the default "Restricted software license types" policy

### Policy Configuration in the UI

When creating each policy, fill in the following fields:

**Restricted software license types for .NET (package manager licenses)**

| Field | Value |
|-------|-------|
| Query Statement | `data.license.match_license_type` |
| Resource Kinds | `Metric`, `PackageVersion` |
| Summary | Violation of organizational license policy. |
| Explanation | One or more of the licenses associated with this package or package dependency violates organizational license policy. |
| Remediation | Please consult with legal for further instructions or to request an exception. |
| Finding Name | Restricted software license types |
| Finding Category | License |
| Policy Name | Restricted software license types for .NET (package manager licenses) |

**Restricted software license types for other ecosystem (all licenses)**

| Field | Value |
|-------|-------|
| Query Statement | `data.license.match_license_type` |
| Resource Kinds | `Metric`, `PackageVersion` |
| Summary | Violation of organizational license policy. |
| Explanation | One or more of the licenses associated with this package or package dependency violates organizational license policy. |
| Remediation | Please consult with legal for further instructions or to request an exception. |
| Finding Name | Restricted software license types |
| Finding Category | License |
| Policy Name | Restricted software license types for other ecosystem (all licenses) |

## What This Change Does

- **Default policy:** Checks all license information Endor Labs collects (package manager, files, repository metadata, etc.)
- **Package manager policy (.NET):** Checks only licenses reported by package managers via `package_manager_licenses`

## Impact

- Existing findings created by the default policy will be resolved
- New findings will be generated based on the updated policy scope
- You'll see significantly fewer false positives for standard .NET packages
- The license rules themselves remain the same — only the scope of license sources is narrowed

This solution maintains the same license compliance standards while reducing noise from secondary license detection methods that may not accurately reflect the actual package licensing.
