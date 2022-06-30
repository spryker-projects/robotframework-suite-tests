*** Settings ***
Suite Setup       SuiteSetup
Test Setup    TestSetup
Default Tags    glue
Resource    ../../../../../../resources/common/common_api.robot

*** Test Cases ***
ENABLER
    TestSetup
Get_concrete_product_availability_by_abstract_SKU
    When I send a GET request:    /concrete-products/${abstract_product_with_alternative.sku}/concrete-product-availabilities
    Then Response status code should be:    404
    And Response reason should be:    Not Found
    And Response should return error code:    306
    And Response should return error message:    Availability is not found.

Get_concrete_product_availability_by_invalid_SKU
    When I send a GET request:    /concrete-products/124124/concrete-product-availabilities
    Then Response status code should be:    404
    And Response reason should be:    Not Found
    And Response should return error code:    306
    And Response should return error message:    Availability is not found.

Get_concrete_product_availability_with_missing_concrete_SKU
    When I send a GET request:    /concrete-products//concrete-product-availabilities
    Then Response status code should be:    400
    And Response reason should be:   Bad Request
    And Response should return error code:    312
    And Response should return error message:    Concrete product sku is not specified.

Get_concrete_product_availability_by_special_characters
    When I send a GET request:    /concrete-products/±!@#$%^&*()/concrete-product-availabilities
    Then Response status code should be:    404
    And Response reason should be:   Not Found
    And Response should return error code:    302
    And Response should return error message:    Concrete product is not found.
