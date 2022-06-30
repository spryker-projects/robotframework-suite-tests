*** Settings ***
Suite Setup       SuiteSetup
Test Setup    TestSetup
Default Tags    glue
Resource    ../../../../../../resources/common/common_api.robot

*** Test Cases ***
ENABLER
    TestSetup
Get_product_image_with_abstract_SKU
    When I send a GET request:    /concrete-products/${bundle_product.abstract.product_1_sku}/concrete-product-image-sets
    Then Response status code should be:    404
    And Response reason should be:    Not Found
    And Response should return error code:    304
    And Response should return error message:    Can`t find concrete product image sets.

Get_product_image_with_empty_SKU
    When I send a GET request:    /concrete-products//concrete-product-image-sets
    Then Response status code should be:    404
    And Response reason should be:    Not Found
    And Response should return error code:    302
    And Response should return error message:    Concrete product is not found.

Get_product_image_with_special_characters
    When I send a GET request:    /concrete-products/~!@#$%^&*()_+/concrete-product-image-sets
    Then Response status code should be:    404
    And Response reason should be:    Not Found
    And Response should return error code:    302
    And Response should return error message:     Concrete product is not found.

Get_product_image_by_concrete_sku_product_doesn't_exist
    When I send a GET request:    /concrete-products/4567890/concrete-product-image-sets
    Then Response status code should be:    404
    And Response reason should be:    Not Found
    And Response should return error code:    304
    And Response should return error message:     Can`t find concrete product image sets.
