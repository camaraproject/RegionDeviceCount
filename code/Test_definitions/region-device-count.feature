Feature: CAMARA Region Device Count API vwip - Operations for device count in specified area

# Input to be provided by the implementation to the tester
#
# Implementation indications:
# * Min start and end dates allowed
# * Max requested time period allowed
# * Max size of the response(Combination of area, starttime, endtime requested) supported for a sync response
# * Max size of the response(Combination of area, starttime, endtime requested) supported for an async response
# * Limitations about max complexity of requested area allowed
# * API support filtering functionality or not and the supported filter types.
#
# Testing assets:
# * An Area within the supported region
# * An Area partially within the supported region
# * An Area outside the supported region
# * A combination of request parameters including area, start time, and end time, such that the number of connected devices in the area is below the local regulatory privacy threshold
#
# References to OAS spec schemas refer to schemas specifies in region-device-count.yaml

  Background: Common Region Device Count setup
    Given an environment at "apiRoot"
    And the resource "/region-device-count/vwip/count"
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"
    And the request body is set by default to a request body compliant with the schema

    # Happy path scenarios

  @region_device_count_count_01_supported_area_success_scenario
  Scenario: Validate success response for a supported area request
    Given the request body property "$.area" is set to the provided area, starttime, and endtime so that the result of the request is below the density requirement
    When the request "count" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/RegionDeviceCountResponse"
    And the response property "$.status" value is "SUPPORTED_AREA"
    And the response property "$.count" is a non-negative integer

  @region_device_count_count_02_partial_area_success
  Scenario:  Validate success response for  a partial supported area request
    Given the request body property "$.area" is set to a valid testing area partially within supported regions
    When the request "count" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/RegionDeviceCountResponse"
    And the response property "$.status" value is "PART_OF_AREA_NOT_SUPPORTED"
    And the response property "$.count" is a non-negative integer

  @region_device_count_count_03_not_supported_area_success
  Scenario: Validate success response for unsupported area request
    Given the request body property "$.area" is set to a valid testing area outside supported regions
    When the request "count" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/RegionDeviceCountResponse"
    And the response property "$.status" value is "AREA_NOT_SUPPORTED"
    And the response property "$.count" is absent

  @region_device_count_count_04_density_below_privacy_threshold_success
  Scenario: Validate success response for density below privacy threshold request
    Given the request body property "$.area","$.starttime","$.endtime" is set to the provided area, start time, and end time, so that the result of the request is DENSITY_BELOW_PRIVACY_THRESHOLD.
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/RegionDeviceCountResponse"
    And the response property "$.status" value is "DENSITY_BELOW_PRIVACY_THRESHOLD"
    And the response property "$.count" is absent

  @region_device_count_count_05_supported_area_time_interval_success_scenario
  Scenario: Validate success response for a supported area and a supported time interval request
    Given the request body property "$.area" is set to a valid testing area within supported regions
    And the request body property "$.starttime" is set to a valid testing time within the allowed time range
    And the request body property "$.endtime" is set to a valid testing time later than body property "$.starttime"
    When the request "count" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/RegionDeviceCountResponse"
    And the response property "$.status" value is "SUPPORTED_AREA"
    And the response property "$.count" is a non-negative integer

  @region_device_count_count_06_supported_area_filter_success_scenario
  Scenario: Validate success response for a supported area and a supported filter request
    Given the request body property "$.area" is set to a valid testing area within supported regions
    And the request body property "$.filter" is set to a valid testing filter the API supported
    When the request "count" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/RegionDeviceCountResponse"
    And the response property "$.status" value is "SUPPORTED_AREA"
    And the response property "$.count" is a non-negative integer

  @region_device_count_count_07_async_success
  Scenario: Validate success async response for a request when sink is provided
    Given the request body property "$.area" is set to a valid area within supported regions
    And the request body property "$.starttime" is set to a valid time
    And the request body property "$.endtime" is set to a valid time later than "$.starttime"
    And the request property "$.sink" is set to a valid URL
    And the request property "$.sinkCredential.credentialType" is set to "ACCESSTOKEN"
    And the request property "$.sinkCredential.accessTokenType" is set to "bearer"
    And the request property "$.sinkCredential.accessToken" is set to a valid access token
    And the request property "$.sinkCredential.accessTokenExpiresUtc" is set to a value long enough in the future
    When the request "count" is sent
    Then the response status code is 202
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the request with the response body will be received at the address of the request property "$.sink"
    And the request will have header "Authorization" set to "Bearer " + the value of the request property "$.sinkCredential.accessToken"
    And the request body received complies with the OAS schema at "/components/schemas/RegionDeviceCountResponse"

  # Generic errors
  @region_device_count_count_08_missing_required_property
  Scenario: Error response for missing required property in request body
    Given the request body property "<required_property>" is not included
    When the request "count" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text
  @region_device_count_count_09_invalid_date_format
  Scenario Outline: Error 400 when the datetime format is not RFC-3339
    Given the request body property "<date_property>" is not set to a valid RFC-3339 date-time
    When the request "count" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

    Examples:
      | date_property |
      | $.starttime   |
      | $.endtime     |

  @region_device_count_count_10_invalid_sink_credential
  Scenario Outline:  Invalid credential
    Given the request body property "$.sinkCredential.credentialType" is set to "<unsupported_credential_type>"
    When the request "count" is sent
    Then the response status code is 400
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_CREDENTIAL"
    And the response property "$.message" contains a user friendly text

    Examples:
      | unsupported_credential_type |
      | PLAIN                       |
      | REFRESHTOKEN                |

  # Only "bearer" is considered in the schema so a generic schema validator may fail and generate a 400 INVALID_ARGUMENT without further distinction,
  # and both could be accepted
  @region_device_count_count_11_sink_credential_invalid_token
  Scenario: Invalid token
    Given the request body property "$.sinkCredential.accessTokenType" is set to a value other than "bearer"
    When the request "count" is sent
    Then the response status code is 400
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_TOKEN" or "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @region_device_count_count_12_expired_access_token
  Scenario: Error response for expired access token
    Given an expired access token
    And the request body is set to a valid request body
    When the request "count" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @region_device_count_count_13_invalid_access_token
  Scenario: Error response for invalid access token
    Given an invalid access token
    And the request body is set to a valid request body
    When the request "count" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @region_device_count_count_14_missing_authorization_header
  Scenario: Error response for no header "Authorization"
    Given the header "Authorization" is not sent
    And the request body is set to a valid request body
    When the request "count" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  # API Specific Errors
  @region_device_count_count_15_time_interval_not_safisfiable
  Scenario: Error response for Invalid Time Interval
    Given the request body property "$.starttime" is set to a valid time and "$.endtime" is absent
    When the request "count" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "REGION_DEVICE_COUNT.TIME_INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @region_device_count_invalid_end_time
  Scenario: Error 400 when endtime is set to a date earlier than starttime
    Given the request body property "$.endtime" is set to a time earlier than request body property "$.starttime"
    When the request "count" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "REGION_DEVICE_COUNT.INVALID_END_DATE"
    And the response property "$.message" contains a user friendly text

  @region_device_count_count_16_invalid_circle_area
  Scenario: Error response for Invalid Circle Area
    Given the request body property "$.area.areaType" is set to "CIRCLE"
    And the request body property "$.area.center" is missing
    When the request "count" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "REGION_DEVICE_COUNT.INVALID_CIRCLE_AREA"
    And the response property "$.message" contains a user friendly text

  @region_device_count_count_17_invalid_polygon_area
  Scenario: Error response for Invalid Polygon Area
    Given the request body property "$.area.areaType" is set to "POLYGON"
    And the request body property "$.area.boundary" is set to an array of coordinates that does not form a polygon
    When the request "count" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "REGION_DEVICE_COUNT.INVALID_POLYGON_AREA"
    And the response property "$.message" contains a user friendly text

  @region_device_count_count_18_too_complex_area
  Scenario: Error 400 when the requested area is too complex
    Given the request body property "$.area.boundary" is set to an array of coordinates that form a too complex area
    When the request "count" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "REGION_DEVICE_COUNT.INVALID_AREA"
    And the response property "$.message" contains a user friendly text

  @region_device_count_count_19_unsupported_sync_response
  Scenario: Error 400 when the response is unsupported for a sync response
    Given the request body properties "$.area", "$.starttime" and "$.endtime" are set to values that generate a response too big for a synchronous response
    When the request "count" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "REGION_DEVICE_COUNT.UNSUPPORTED_SYNC_RESPONSE"
    And the response property "$.message" contains a user friendly text

  @region_device_count_count_20_unsupported_request
  Scenario: Error 400 when the response is too big for a sync and async response
    Given the request body properties "$.area", "$.starttime" and "$.endtime" are set to values that generate a response too big for both synchronous and asynchronous responses
    When the request "count" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 400
    And the response property "$.code" is "REGION_DEVICE_COUNT.UNSUPPPORTED_REQUEST"
    And the response property "$.message" contains a user friendly text
