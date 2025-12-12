<a href="https://github.com/camaraproject/RegionDeviceCount/commits/" title="Last Commit"><img src="https://img.shields.io/github/last-commit/camaraproject/RegionDeviceCount?style=plastic"></a>
<a href="https://github.com/camaraproject/RegionDeviceCount/issues" title="Open Issues"><img src="https://img.shields.io/github/issues/camaraproject/RegionDeviceCount?style=plastic"></a>
<a href="https://github.com/camaraproject/RegionDeviceCount/pulls" title="Open Pull Requests"><img src="https://img.shields.io/github/issues-pr/camaraproject/RegionDeviceCount?style=plastic"></a>
<a href="https://github.com/camaraproject/RegionDeviceCount/graphs/contributors" title="Contributors"><img src="https://img.shields.io/github/contributors/camaraproject/RegionDeviceCount?style=plastic"></a>
<a href="https://github.com/camaraproject/RegionDeviceCount" title="Repo Size"><img src="https://img.shields.io/github/repo-size/camaraproject/RegionDeviceCount?style=plastic"></a>
<a href="https://github.com/camaraproject/RegionDeviceCount/blob/main/LICENSE" title="License"><img src="https://img.shields.io/badge/License-Apache%202.0-green.svg?style=plastic"></a>
<a href="https://github.com/camaraproject/RegionDeviceCount/releases/latest" title="Latest Release"><img src="https://img.shields.io/github/release/camaraproject/RegionDeviceCount?style=plastic"></a>
<a href="https://github.com/camaraproject/Governance/blob/main/ProjectStructureAndRoles.md" title="Sandbox API Repository"><img src="https://img.shields.io/badge/Sandbox%20API%20Repository-yellow?style=plastic"></a>

# RegionDeviceCount

Sandbox API Repository to describe, develop, document, and test the RegionDeviceCount Service API(s). The repository does not yet belong to a CAMARA Sub Project.

* API Repository [wiki page](https://lf-camaraproject.atlassian.net/wiki/x/JSTe)

## Scope
* Service APIs for “RegionDeviceCount” (see APIBacklog.md)  
* It provides the API consumer with the ability to:  
  * query device count in the specified area during a certain time interval.The query area can be a circle or a polygon composed of longitude and latitude points.In addition, this API also provides a filtering function. Customers can filter devices by passing in different constraints. Currently, it supports two filtering conditions: roaming status and device type, and it is designed to be extended in the future
  * NOTE: The scope of this API should be limited (at least at a first stage) to 4G and 5G.  
* Describe, develop, document and test the APIs (with 1-2 Telcos)  
* Started: December 2023

<!-- CAMARA:RELEASE-INFO:START -->
<!-- This section is automatically maintained by the CAMARA project-administration tooling: https://github.com/camaraproject/project-administration -->

## Release Information

> [!NOTE]
> Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until a new release is created. For example, changes may be reverted before a release is created. **For best results, use the latest available release**.

* **NEW**: The latest public release is [r2.2](https://github.com/camaraproject/RegionDeviceCount/releases/tag/r2.2) (Fall25), with the following API versions:
  * **region-device-count v0.2.0**
  [[YAML]](https://github.com/camaraproject/RegionDeviceCount/blob/r2.2/code/API_definitions/region-device-count.yaml)
  [[ReDoc]](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/RegionDeviceCount/r2.2/code/API_definitions/region-device-count.yaml&nocors)
  [[Swagger]](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/RegionDeviceCount/r2.2/code/API_definitions/region-device-count.yaml)
* The latest public release is always available here: https://github.com/camaraproject/RegionDeviceCount/releases/latest
* Other releases of this repository are available in https://github.com/camaraproject/RegionDeviceCount/releases
* For changes see [CHANGELOG.md](https://github.com/camaraproject/RegionDeviceCount/blob/main/CHANGELOG.md)

_The above section is automatically synchronized by CAMARA project-administration._
<!-- CAMARA:RELEASE-INFO:END -->

## Contributing
* Meetings are held virtually
    * Schedule: Bi-Weekly on Fridays 11:00 CET/CEST / 09:00 UTC
    * [Registration / Join](https://zoom-lfx.platform.linuxfoundation.org/meeting/91734372257?password=28df8c0a-941a-4f41-adc2-fd5de2791a96)
    * Minutes: Access [Meeting minutes](https://wiki.camaraproject.org/display/CAM/RegionDeviceCount)
* Mailing List
    <!-- Note: the $sub-project-mailinglistname$ is either already existing or will be created by the CAMARA Admin Team  -->
    * Subscribe / Unsubscribe to the mailing list of this Sub Project <https://lists.camaraproject.org/g/sp-ruc>.
    * A message to the community of this Sub Project can be sent using <sp-ruc@lists.camaraproject.org>.
