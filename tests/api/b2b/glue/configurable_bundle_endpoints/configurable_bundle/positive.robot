*** Settings ***
Suite Setup       SuiteSetup
Test Setup        TestSetup
Resource    ../../../../../../resources/common/common_api.robot
Default Tags    glue

*** Test Cases ***
ENABLER
    TestSetup

Get_configurable_bundle_templates
    When I send a GET request:    /configurable-bundle-templates
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response header parameter should be:    Content-Type    ${default_header_content_type}
    And Response should contain the array of a certain size:    [data]    2
    And Each array element of array in response should contain property with value:    [data]    type    configurable-bundle-templates
    And Each Array Element Of Array In Response Should Contain Property:    [data]    id
    And Each Array Element Of Array In Response Should Contain Property:    [data]    attributes
    And Each Array Element Of Array In Response Should Contain Property:    [data]    links
    And Each array element of array in response should contain nested property:    [data]    [attributes]    name
    And Each array element of array in response should contain nested property:    [data]    [links]    self
    And Response body has correct self link

Get_configurable_bundle_templates_including_configurable_bundle_template_slots
    When I send a GET request:    /configurable-bundle-templates?include=configurable-bundle-template-slots
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response header parameter should be:    Content-Type    ${default_header_content_type}
    And Response should contain the array of a certain size:    [data]    2
    And Each array element of array in response should contain property with value:    [data]    type    configurable-bundle-templates
    And Each Array Element Of Array In Response Should Contain Property:    [data]    id
    And Each Array Element Of Array In Response Should Contain Property:    [data]    attributes
    And Each Array Element Of Array In Response Should Contain Property:    [data]    links
    And Each array element of array in response should contain nested property:    [data]    relationships    configurable-bundle-template-slots
    And Each array element of array in response should contain property with value:    [included]    type    configurable-bundle-template-slots
    And Each Array Element Of Array In Response Should Contain Property:    [included]    id
    And Each Array Element Of Array In Response Should Contain Property:    [included]    links
    And Response body has correct self link

Get_configurable_bundle_templates_including_configurable_bundle_template_image_sets
    When I send a GET request:    /configurable-bundle-templates?include=configurable-bundle-template-image-sets
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response header parameter should be:    Content-Type    ${default_header_content_type}
    And Response should contain the array of a certain size:    [data]    2
    And Each array element of array in response should contain property with value:    [data]    type    configurable-bundle-templates
    And Each Array Element Of Array In Response Should Contain Property:    [data]    id
    And Each Array Element Of Array In Response Should Contain Property:    [data]    attributes
    And Each Array Element Of Array In Response Should Contain Property:    [data]    links
    And Each array element of array in response should contain nested property:    [data]    relationships    configurable-bundle-template-image-sets
    And Each array element of array in response should contain nested property:    [included]    attributes    name
    And Each array element of array in response should contain nested property:    [included]    attributes    images
    And Each array element of array in response should contain nested property:    [included]    [attributes][images]    externalUrlLarge
    And Each array element of array in response should contain nested property:    [included]    [attributes][images]    externalUrlSmall
    And Each array element of array in response should contain property with value:    [included]    type    configurable-bundle-template-image-sets
    And Each Array Element Of Array In Response Should Contain Property:    [included]    id
    And Each Array Element Of Array In Response Should Contain Property:    [included]    links
    And Response body has correct self link

Get_configurable_bundle_templates_by_configurable_bundle_template_id
    When I send a GET request:    /configurable-bundle-templates/${configurable_bundle_template_id}?include=configurable-bundle-template-slots,configurable-bundle-template-image-sets
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response header parameter should be:    Content-Type    ${default_header_content_type}
    And Response body parameter should be:    [data][type]    configurable-bundle-templates
    And Response body parameter should be:    [data][id]    ${configurable_bundle_template_id}
    And Response body parameter should be:    [data][attributes][name]    ${configurable_bundle_template_name}
    Response should contain the array of a certain size:    [data][relationships][configurable-bundle-template-slots][data]    4
    And Each array element of array in response should contain property with value:    [data][relationships][configurable-bundle-template-slots][data]    type    configurable-bundle-template-slots
    And Each array element of array in response should contain property:    [data][relationships][configurable-bundle-template-slots][data]    id
    Response should contain the array of a certain size:    [data][relationships][configurable-bundle-template-image-sets][data]    1
    And Each array element of array in response should contain property with value:    [data][relationships][configurable-bundle-template-image-sets][data]    type    configurable-bundle-template-image-sets
    And Each array element of array in response should contain property:    [data][relationships][configurable-bundle-template-slots][data]    id
    And Response body has correct self link internal
    And Each array element of array in response should contain property:    [included]    id
    And Each array element of array in response should contain nested property:    [included]    attributes    name
    And And Response body parameter should be:    [included][0][type]    configurable-bundle-template-slots
    And And Response body parameter should be:    [included][1][type]    configurable-bundle-template-slots
    And And Response body parameter should be:    [included][2][type]    configurable-bundle-template-slots
    And And Response body parameter should be:    [included][3][type]    configurable-bundle-template-slots
    And And Response body parameter should be:    [included][4][type]    configurable-bundle-template-image-sets
    And Each array element of array in response should contain property:    [included][4][attributes][images]    externalUrlLarge
    And Each array element of array in response should contain property:    [included][4][attributes][images]    externalUrlSmall

# BUG CC-16634
Get_configurable_bundle_templates_including_concrete_products_concrete_product_prices_concrete_product_image_sets
    When I send a GET request:    /configurable-bundle-templates/${configurable_bundle_template_id}?include=configurable-bundle-template-slots,concrete-products,concrete-product-prices,concrete-product-image-sets
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response header parameter should be:    Content-Type    ${default_header_content_type}
    And Each array element of array in response should contain property with value:    [data]    type    configurable-bundle-templates
    And Each Array Element Of Array In Response Should Contain Property:    [data]    id
    And Each Array Element Of Array In Response Should Contain Property:    [data]    attributes
    And Each Array Element Of Array In Response Should Contain Property:    [data]    links
    And Each array element of array in response should contain nested property:    [data]    relationships    configurable-bundle-template-image-sets
   # TODO check included concrete-products,configurable-bundle-template-slots,concrete-product-prices,concrete-product-image-sets
    And Response body has correct self link

Add_configured_bundle_item_to_the_cart_with_included_items
  [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
    ...  AND    I set Headers:    Authorization=${token}
    ...  AND    I send a POST request:    /carts    {"data": {"type": "carts","attributes": {"priceMode": "${gross_mode}","currency": "${currency_code_eur}","store": "${store_de}","name": "${test_cart_name}-${random}"}}}
    ...  AND    Save value to a variable:    [data][id]    cart_id
    ...  AND    Response status code should be:    201
    When I send a POST request:    /carts/${cart_id}/configured-bundles?include=items    {"data": {"type": "configured-bundles","attributes": {"quantity": "${configured_bundle_quantity}","templateUuid": "${configurable_bundle_template_id}","items": [{"sku": "${configurable_bundle_first_slot_item_sku}","quantity": 2,"slotUuid": "${configurable_bundle_first_slot_uuid}"}]}}}
    Then Response status code should be:    201
    And Response reason should be:    Created
    And Response header parameter should be:    Content-Type    ${default_header_content_type}
    And Response body parameter should be:    [data][type]    carts
    And Response body parameter should be:    [data][id]    ${cart_id}
    And Response body parameter should be:    [data][attributes][priceMode]    ${gross_mode}
    And Response body parameter should be:    [data][attributes][currency]    ${currency_code_eur}
    And Response body parameter should be:    [data][attributes][store]    ${store_de}
    And Response body parameter should be:    [data][attributes][name]    ${test_cart_name}-${random}
    And Response should contain the array of a certain size:    [data][relationships][items]   1
    And Each array element of array in response should contain property with value:    [data][relationships][items][data]    type    items
    And Each Array Element Of Array In Response Should Contain Property:    [data][relationships][items][data]    id
    And Each Array Element Of Array In Response Should Contain Property:    [data][relationships][items][data]    id
    And Response should contain the array of a certain size:    [included]    1
    And Response body parameter should be:    [included][0][type]    items
    And Response body parameter should be:    [included][0][attributes][sku]    ${configurable_bundle_first_slot_item_sku}
    And Response body parameter should be:    [included][0][attributes][quantity]   2
    And Response body parameter should not be EMPTY:    [included][0][attributes][calculations][unitPrice]
    And Response body parameter should not be EMPTY:    [included][0][attributes][calculations][sumPrice]
    And Response body parameter should not be EMPTY:    [included][0][attributes][calculations][taxRate]
    And Response body parameter should not be EMPTY:    [included][0][attributes][calculations][unitNetPrice]
    And Response body parameter should not be EMPTY:    [included][0][attributes][calculations][sumNetPrice]
    And Response body parameter should not be EMPTY:    [included][0][attributes][calculations][unitGrossPrice]
    And Response body parameter should not be EMPTY:    [included][0][attributes][calculations][sumGrossPrice]
    And Response body parameter should not be EMPTY:    [included][0][attributes][calculations][unitTaxAmountFullAggregation]
    And Response body parameter should not be EMPTY:    [included][0][attributes][calculations][sumTaxAmountFullAggregation]
    And Response body parameter should not be EMPTY:    [included][0][attributes][calculations][sumSubtotalAggregation]
    And Response body parameter should not be EMPTY:    [included][0][attributes][calculations][unitSubtotalAggregation]
    And Response body parameter should not be EMPTY:    [included][0][attributes][calculations][unitProductOptionPriceAggregation]
    And Response body parameter should not be EMPTY:    [included][0][attributes][calculations][sumProductOptionPriceAggregation]
    And Response body parameter should not be EMPTY:    [included][0][attributes][calculations][unitDiscountAmountAggregation]
    And Response body parameter should not be EMPTY:    [included][0][attributes][calculations][sumDiscountAmountAggregation]
    And Response body parameter should not be EMPTY:    [included][0][attributes][calculations][unitDiscountAmountFullAggregation]
    And Response body parameter should not be EMPTY:    [included][0][attributes][calculations][sumDiscountAmountFullAggregation]
    And Response body parameter should not be EMPTY:    [included][0][attributes][calculations][unitPriceToPayAggregation]
    And Response body parameter should not be EMPTY:    [included][0][attributes][calculations][sumPriceToPayAggregation]
    [Teardown]    Run Keywords    I send a DELETE request:     /carts/${cart_id}
    ...    AND    Response status code should be:    204

Update_configured_bundle_quantity_in_the cart_to_the_cart
  [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
    ...  AND    I set Headers:    Authorization=${token}
    ...  AND    I send a POST request:    /carts    {"data": {"type": "carts","attributes": {"priceMode": "${gross_mode}","currency": "${currency_code_eur}","store": "${store_de}","name": "${test_cart_name}-${random}"}}}
    ...  AND    Save value to a variable:    [data][id]    cart_id
    ...  AND    Response status code should be:    201
    ...  AND    I send a POST request:    /carts/${cart_id}/configured-bundles?include=items    {"data": {"type": "configured-bundles","attributes": {"quantity": "${configured_bundle_quantity}","templateUuid": "${configurable_bundle_template_id}","items": [{"sku": "${configurable_bundle_first_slot_item_sku}","quantity": 2,"slotUuid": "${configurable_bundle_first_slot_uuid}"}]}}}
    ...  AND    Save value to a variable:    [included][0][attributes][configuredBundle][groupKey]    bundle_group_key
    ...  AND    Response status code should be:    201
    When I send a PATCH request:    /carts/${cart_id}/configured-bundles/${bundle_group_key}?include=items    {"data": {"type": "configured-bundles","attributes": {"quantity": "12"}}}
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response header parameter should be:    Content-Type    ${default_header_content_type}
    And Response body parameter should be:    [data][type]    carts
    And Response body parameter should be:    [data][id]    ${cart_id}
    And Response body parameter should be:    [data][attributes][priceMode]    ${gross_mode}
    And Response body parameter should be:    [data][attributes][currency]    ${currency_code_eur}
    And Response body parameter should be:    [data][attributes][store]    ${store_de}
    And Response body parameter should be:    [included][0][type]    items
    And Response body parameter should be:    [included][0][attributes][sku]    ${configurable_bundle_first_slot_item_sku}
    And Response body parameter should be:    [included][0][attributes][configuredBundle][quantity]   12
    And Response body parameter should be greater than:    [data][attributes][totals][priceToPay]    1
    And Response body parameter should be greater than:    [data][attributes][totals][grandTotal]    1
    [Teardown]    Run Keywords    I send a DELETE request:     /carts/${cart_id}
    ...    AND    Response status code should be:    204

Delete_configured_bundle_item_from_the_cart
  [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
    ...  AND    I set Headers:    Authorization=${token}
    ...  AND    I send a POST request:    /carts    {"data": {"type": "carts","attributes": {"priceMode": "${gross_mode}","currency": "${currency_code_eur}","store": "${store_de}","name": "${test_cart_name}-${random}"}}}
    ...  AND    Save value to a variable:    [data][id]    cart_id
    ...  AND    Response status code should be:    201
    ...  AND    I send a POST request:    /carts/${cart_id}/configured-bundles?include=items    {"data": {"type": "configured-bundles","attributes": {"quantity": "${configured_bundle_quantity}","templateUuid": "${configurable_bundle_template_id}","items": [{"sku": "${configurable_bundle_first_slot_item_sku}","quantity": 2,"slotUuid": "${configurable_bundle_first_slot_uuid}"}]}}}
    ...  AND    Save value to a variable:    [included][0][attributes][configuredBundle][groupKey]    bundle_group_key
    ...  AND    Response status code should be:    201
    When I send a DELETE request:    /carts/${cart_id}/configured-bundles/${bundle_group_key}
    Then Response status code should be:    204
    And Response reason should be:    No Content
    And I send a GET request:    /carts/${cart_id}
    And Response body parameter should be:    [data][attributes][totals][priceToPay]    0
    And Response body parameter should be:    [data][attributes][totals][grandTotal]    0
