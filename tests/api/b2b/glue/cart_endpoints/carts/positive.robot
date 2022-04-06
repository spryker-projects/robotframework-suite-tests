*** Settings ***
Suite Setup    SuiteSetup
Test Setup    TestSetup
Resource    ../../../../../../resources/common/common_api.robot
Default Tags    glue

*** Test Cases ***
#GET requests
Get_cart_by_cart_id
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
    ...  AND    I set Headers:    Authorization=${token}
    ...  AND    I send a POST request:    /carts    {"data": {"type": "carts","attributes": {"priceMode": "${gross_mode}","currency": "${currency_code_eur}","store": "${store_de}","name": "${test_cart_name}-${random}"}}}
    ...  AND    Save value to a variable:    [data][id]    cart_id
    ...  AND    Response status code should be:    201
    When I send a GET request:    /carts/${cart_id}
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][type]    carts
    And Response body parameter should be:    [data][id]    ${cart_id}
    And Response body parameter should be:    [data][attributes][priceMode]    ${gross_mode}
    And Response body parameter should be:    [data][attributes][currency]    ${currency_code_eur}
    And Response body parameter should be:    [data][attributes][store]    ${store_de}
    And Response body parameter should be:    [data][attributes][name]    ${test_cart_name}-${random}
    And Response body parameter should be:    [data][attributes][isDefault]    True
    And Response body parameter should be:    [data][attributes][totals][expenseTotal]    None
    And Response body parameter should be:    [data][attributes][totals][discountTotal]    None
    And Response body parameter should be:    [data][attributes][totals][taxTotal]    None
    And Response body parameter should be:    [data][attributes][totals][subtotal]    None
    And Response body parameter should be:    [data][attributes][totals][grandTotal]    None
    And Response body parameter should be:    [data][attributes][totals][priceToPay]    None
    And Response body has correct self link internal
    [Teardown]    Run Keywords    I send a DELETE request:    /carts/${cart_id}
    ...  AND    Response status code should be:    204

Get_cart_without_cart_id
# Spryker is designed so that we can get all carts same as for /customers/{customerId}/carts request
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
    ...  AND    I set Headers:    Authorization=${token}
    ...  AND    I send a POST request:    /carts    {"data": {"type": "carts","attributes": {"priceMode": "${gross_mode}","currency": "${currency_code_eur}","store": "${store_de}","name": "${test_cart_name}-${random}"}}}
    ...  AND    Save value to a variable:    [data][id]    cart_id
    ...  AND    Response status code should be:    201
    When I send a GET request:    /carts
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should contain:    [data]    ${cart_id}
    And Each array element of array in response should contain property:    [data]    type
    And Each array element of array in response should contain property:    [data]    id
    And Each array element of array in response should contain property:    [data]    attributes
    And Response body parameter should not be EMPTY:    [data][attributes]
    [Teardown]    Run Keywords    I send a DELETE request:    /carts/${cart_id}
    ...  AND    Response status code should be:    204

Get_cart_by_cart_id_with_included_items
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
    ...  AND    I set Headers:    Authorization=${token}
    When I send a GET request:    /carts/df11d3f1-eb2f-508c-8a64-95c36b772712?include=items
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][type]    carts
    And Response body parameter should be:    [data][id]    df11d3f1-eb2f-508c-8a64-95c36b772712
    And Response body parameter should be:    [data][attributes][priceMode]    ${gross_mode}
    And Response body parameter should be:    [data][attributes][currency]    ${currency_code_eur}
    And Response body parameter should be:    [data][attributes][store]    ${store_de}
    And Response body parameter should be:    [data][attributes][name]    Newcomers
    And Response body parameter should be:    [data][attributes][isDefault]    False
    And Response body parameter should not be EMPTY:    [data][attributes][totals][expenseTotal]
    And Response body parameter should not be EMPTY:    [data][attributes][totals][discountTotal]
    And Response body parameter should not be EMPTY:    [data][attributes][totals][taxTotal]
    And Response body parameter should not be EMPTY:    [data][attributes][totals][subtotal]
    And Response body parameter should not be EMPTY:    [data][attributes][totals][grandTotal]
    And Response body parameter should not be EMPTY:    [data][attributes][totals][priceToPay]
    And Response body should contain:    discounts
    And Response body has correct self link internal
    And Each array element of array in response should contain property with value:    [data][relationships][items][data]    type    items
    And Each array element of array in response should contain property:    [data][relationships][items][data]    id
    And Each array element of array in response should contain property with value:    [included]    type    items
    And Each array element of array in response should contain property:    [included]    id
    And Each array element of array in response should contain property:    [included]    attributes
    And Each array element of array in response should contain property:    [included]    links
    And Each array element of array in response should contain value:    [included]    sku
    And Each array element of array in response should contain value:    [included]    quantity
    And Each array element of array in response should contain value:    [included]    groupKey
    And Each array element of array in response should contain value:    [included]    abstractSku
    And Each array element of array in response should contain value:    [included]    amount
    And Each array element of array in response should contain value:    [included]    calculations
    And Each array element of array in response should contain value:    [included]    unitPrice
    And Each array element of array in response should contain value:    [included]    sumPrice
    And Each array element of array in response should contain value:    [included]    taxRate
    And Each array element of array in response should contain value:    [included]    unitNetPrice
    And Each array element of array in response should contain value:    [included]    sumNetPrice
    And Each array element of array in response should contain value:    [included]    unitGrossPrice
    And Each array element of array in response should contain value:    [included]    sumGrossPrice
    And Each array element of array in response should contain value:    [included]    unitTaxAmountFullAggregation
    And Each array element of array in response should contain value:    [included]    sumTaxAmountFullAggregation
    And Each array element of array in response should contain value:    [included]    sumSubtotalAggregation
    And Each array element of array in response should contain value:    [included]    unitSubtotalAggregation
    And Each array element of array in response should contain value:    [included]    unitProductOptionPriceAggregation
    And Each array element of array in response should contain value:    [included]    sumProductOptionPriceAggregation
    And Each array element of array in response should contain value:    [included]    unitDiscountAmountAggregation
    And Each array element of array in response should contain value:    [included]    sumDiscountAmountAggregation
    And Each array element of array in response should contain value:    [included]    unitDiscountAmountFullAggregation
    And Each array element of array in response should contain value:    [included]    sumDiscountAmountFullAggregation
    And Each array element of array in response should contain value:    [included]    unitPriceToPayAggregation
    And Each array element of array in response should contain value:    [included]    sumPriceToPayAggregation
    And Each array element of array in response should contain value:    [included]    salesUnit
    And Each array element of array in response should contain value:    [included]    selectedProductOptions

Get_cart_by_customer_id
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
    ...  AND    I set Headers:    Authorization=${token}
    ...  AND    I send a POST request:    /carts    {"data": {"type": "carts","attributes": {"priceMode": "${gross_mode}","currency": "${currency_code_eur}","store": "${store_de}","name": "${test_cart_name}-${random}"}}}
    ...  AND    Save value to a variable:    [data][id]    cart_id
    ...  AND    Response status code should be:    201
    When I send a GET request:    /customers/${yves_user_reference}/carts
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should contain:    [data]    ${cart_id}
    And Each array element of array in response should contain property:    [data]    type
    And Each array element of array in response should contain property:    [data]    id
    And Each array element of array in response should contain property:    [data]    attributes
    And Response body parameter should not be EMPTY:    [data][attributes]
    [Teardown]    Run Keywords    I send a DELETE request:    /carts/${cart_id}
    ...  AND    Response status code should be:    204



#POST requests
Create_cart
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
    ...  AND    I set Headers:    Authorization=${token}
    When I send a POST request:    /carts    {"data": {"type": "carts","attributes": {"priceMode": "${gross_mode}","currency": "${currency_code_eur}","store": "${store_de}","name": "${test_cart_name}-${random}"}}}
    And Save value to a variable:    [data][id]    cart_id
    Then Response status code should be:    201
    And Response reason should be:    Created
    And Response body parameter should be:    [data][type]    carts
    And Response body parameter should be:    [data][id]    ${cart_id}
    And Response body parameter should be:    [data][attributes][priceMode]    ${gross_mode}
    And Response body parameter should be:    [data][attributes][currency]    ${currency_code_eur}
    And Response body parameter should be:    [data][attributes][store]    ${store_de}
    And Response body parameter should be:    [data][attributes][name]    ${test_cart_name}-${random}
    And Response body parameter should be:    [data][attributes][isDefault]    True
    And Response body parameter should be:    [data][attributes][totals][expenseTotal]    None
    And Response body parameter should be:    [data][attributes][totals][discountTotal]    None
    And Response body parameter should be:    [data][attributes][totals][taxTotal]    None
    And Response body parameter should be:    [data][attributes][totals][subtotal]    None
    And Response body parameter should be:    [data][attributes][totals][grandTotal]    None
    And Response body parameter should be:    [data][attributes][totals][priceToPay]    None
    And Response body has correct self link for created entity:    ${cart_id}
    [Teardown]    Run Keywords    I send a DELETE request:    /carts/${cart_id}
    ...  AND    Response status code should be:    204

Create_cart_with_existing_name
# Spryker is designed so that we can send existing name and it will be changed automatically to the unique value on the BE side.
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
    ...  AND    I set Headers:    Authorization=${token}
    ...  AND    I send a POST request:    /carts    {"data": {"type": "carts","attributes": {"priceMode": "${gross_mode}","currency": "${currency_code_eur}","store": "${store_de}","name": "${test_cart_name}-${random}"}}}
    ...  AND    Save value to a variable:    [data][id]    cart_id
    When I send a POST request:    /carts    {"data": {"type": "carts","attributes": {"priceMode": "${gross_mode}","currency": "${currency_code_eur}","store": "${store_de}","name": "${test_cart_name}-${random}"}}}
    And Save value to a variable:    [data][id]    cart_id_2
    Then Response status code should be:    201
    And Response reason should be:    Created
    And Response body parameter should be:    [data][type]    carts
    And Response body parameter should be:    [data][id]    ${cart_id_2}
    And Response body parameter should be:    [data][attributes][priceMode]    ${gross_mode}
    And Response body parameter should be:    [data][attributes][currency]    ${currency_code_eur}
    And Response body parameter should be:    [data][attributes][store]    ${store_de}
    And Response body parameter should NOT be:    [data][attributes][name]    ${test_cart_name}-${random}
    And Response body parameter should be:    [data][attributes][isDefault]    True
    And Response body parameter should be:    [data][attributes][totals][expenseTotal]    None
    And Response body parameter should be:    [data][attributes][totals][discountTotal]    None
    And Response body parameter should be:    [data][attributes][totals][taxTotal]    None
    And Response body parameter should be:    [data][attributes][totals][subtotal]    None
    And Response body parameter should be:    [data][attributes][totals][grandTotal]    None
    And Response body parameter should be:    [data][attributes][totals][priceToPay]    None
    And Response body has correct self link for created entity:    ${cart_id_2}
    [Teardown]    Run Keywords    I send a DELETE request:    /carts/${cart_id}
    ...  AND    Response status code should be:    204
    ...  AND    I send a DELETE request:    /carts/${cart_id_2}
    ...  AND    Response status code should be:    204



#PATCH requests
Update_cart_by_cart_id_with_all_attributes
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
    ...  AND    I set Headers:    Authorization=${token}
    ...  AND    I send a POST request:    /carts    {"data": {"type": "carts","attributes": {"priceMode": "${gross_mode}","currency": "${currency_code_eur}","store": "${store_de}","name": "${test_cart_name}"}}}
    ...  AND    Save value to a variable:    [data][id]    cart_id
    ...  AND    Save Header value to a variable:    ETag    header_tag
    ...  AND    Response status code should be:    201
    ...  AND    I set Headers:    Authorization=${token}    If-Match=${header_tag}
    When I send a PATCH request:    /carts/${cart_id}    {"data": {"type": "carts","attributes": {"priceMode": "${net_mode}","currency": "${currency_code_eur}","store": "${store_de}","name": "${test_cart_name}-${random}"}}}
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][type]    carts
    And Response body parameter should be:    [data][id]    ${cart_id}
    And Response body parameter should be:    [data][attributes][priceMode]    ${net_mode}
    And Response body parameter should be:    [data][attributes][currency]    ${currency_code_eur}
    And Response body parameter should be:    [data][attributes][store]    ${store_de}
    And Response body parameter should be:    [data][attributes][name]    ${test_cart_name}-${random}
    And Response body parameter should be:    [data][attributes][isDefault]    True
    And Response body parameter should be:    [data][attributes][totals][expenseTotal]    0
    And Response body parameter should be:    [data][attributes][totals][discountTotal]    0
    And Response body parameter should be:    [data][attributes][totals][taxTotal]    0
    And Response body parameter should be:    [data][attributes][totals][subtotal]    0
    And Response body parameter should be:    [data][attributes][totals][grandTotal]    0
    And Response body parameter should be:    [data][attributes][totals][priceToPay]    0
    And Response body has correct self link internal
    [Teardown]    Run Keywords    I send a DELETE request:    /carts/${cart_id}
    ...  AND    Response status code should be:    204

Update_cart_with_empty_priceMod_currency_store
# Spryker is designed so that we can send empty attributes: priceMod, currency, store and it will not be changed to the empty values.
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
    ...  AND    I set Headers:    Authorization=${token}
    ...  AND    I send a POST request:    /carts    {"data": {"type": "carts","attributes": {"priceMode": "${gross_mode}","currency": "${currency_code_eur}","store": "${store_de}","name": "${test_cart_name}-${random}"}}}
    ...  AND    Save value to a variable:    [data][id]    cart_id
    ...  AND    Save Header value to a variable:    ETag    header_tag
    ...  AND    Response status code should be:    201
    ...  AND    I set Headers:    Authorization=${token}    If-Match=${header_tag}
    When I send a PATCH request:    /carts/${cart_id}    {"data": {"type": "carts","attributes": {"priceMode": "","currency": "","store": ""}}}
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][type]    carts
    And Response body parameter should be:    [data][id]    ${cart_id}
    And Response body parameter should be:    [data][attributes][priceMode]    ${gross_mode}
    And Response body parameter should be:    [data][attributes][currency]    ${currency_code_eur}
    And Response body parameter should be:    [data][attributes][store]    ${store_de}
    And Response body parameter should be:    [data][attributes][name]    ${test_cart_name}-${random}
    And Response body parameter should be:    [data][attributes][isDefault]    True
    And Response body parameter should be:    [data][attributes][totals][expenseTotal]    0
    And Response body parameter should be:    [data][attributes][totals][discountTotal]    0
    And Response body parameter should be:    [data][attributes][totals][taxTotal]    0
    And Response body parameter should be:    [data][attributes][totals][subtotal]    0
    And Response body parameter should be:    [data][attributes][totals][grandTotal]    0
    And Response body parameter should be:    [data][attributes][totals][priceToPay]    0
    And Response body has correct self link internal
    [Teardown]    Run Keywords    I send a DELETE request:    /carts/${cart_id}
    ...  AND    Response status code should be:    204

Update_cart_with_name_attribute
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
    ...  AND    I set Headers:    Authorization=${token}
    ...  AND    I send a POST request:    /carts    {"data": {"type": "carts","attributes": {"priceMode": "${gross_mode}","currency": "${currency_code_eur}","store": "${store_de}","name": "${test_cart_name}"}}}
    ...  AND    Save value to a variable:    [data][id]    cart_id
    ...  AND    Save Header value to a variable:    ETag    header_tag
    ...  AND    Response status code should be:    201
    ...  AND    I set Headers:    Authorization=${token}    If-Match=${header_tag}
    When I send a PATCH request:    /carts/${cart_id}    {"data": {"type": "carts","attributes": {"name": "${test_cart_name}-${random}"}}}
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][type]    carts
    And Response body parameter should be:    [data][id]    ${cart_id}
    And Response body parameter should be:    [data][attributes][priceMode]    ${gross_mode}
    And Response body parameter should be:    [data][attributes][currency]    ${currency_code_eur}
    And Response body parameter should be:    [data][attributes][store]    ${store_de}
    And Response body parameter should be:    [data][attributes][name]    ${test_cart_name}-${random}
    And Response body parameter should be:    [data][attributes][isDefault]    True
    And Response body parameter should be:    [data][attributes][totals][expenseTotal]    0
    And Response body parameter should be:    [data][attributes][totals][discountTotal]    0
    And Response body parameter should be:    [data][attributes][totals][taxTotal]    0
    And Response body parameter should be:    [data][attributes][totals][subtotal]    0
    And Response body parameter should be:    [data][attributes][totals][grandTotal]    0
    And Response body parameter should be:    [data][attributes][totals][priceToPay]    0
    And Response body has correct self link internal
    [Teardown]    Run Keywords    I send a DELETE request:    /carts/${cart_id}
    ...  AND    Response status code should be:    204

Update_cart_with_existing_name
# Spryker is designed so that we can send existing name and it will be changed automatically to the unique value on the BE side.
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
    ...  AND    I set Headers:    Authorization=${token}
    ...  AND    I send a POST request:    /carts    {"data": {"type": "carts","attributes": {"priceMode": "${gross_mode}","currency": "${currency_code_eur}","store": "${store_de}","name": "${test_cart_name}-${random}"}}}
    ...  AND    Save value to a variable:    [data][id]    cart_id
    ...  AND    Save Header value to a variable:    ETag    header_tag
    ...  AND    Response status code should be:    201
    ...  AND    I set Headers:    Authorization=${token}    If-Match=${header_tag}
    When I send a PATCH request:    /carts/${cart_id}    {"data": {"type": "carts","attributes": {"name": "My Cart"}}}
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][type]    carts
    And Response body parameter should be:    [data][id]    ${cart_id}
    And Response body parameter should be:    [data][attributes][priceMode]    ${gross_mode}
    And Response body parameter should be:    [data][attributes][currency]    ${currency_code_eur}
    And Response body parameter should be:    [data][attributes][store]    ${store_de}
    And Response body parameter should NOT be:    [data][attributes][name]    "My Cart"
    And Response body parameter should be:    [data][attributes][isDefault]    True
    And Response body parameter should be:    [data][attributes][totals][expenseTotal]    0
    And Response body parameter should be:    [data][attributes][totals][discountTotal]    0
    And Response body parameter should be:    [data][attributes][totals][taxTotal]    0
    And Response body parameter should be:    [data][attributes][totals][subtotal]    0
    And Response body parameter should be:    [data][attributes][totals][grandTotal]    0
    And Response body parameter should be:    [data][attributes][totals][priceToPay]    0
    And Response body has correct self link internal
    [Teardown]    Run Keywords    I send a DELETE request:    /carts/${cart_id}
    ...  AND    Response status code should be:    204



#DELETE requests
Delete_cart_by_cart_id
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
    ...  AND    I set Headers:    Authorization=${token}
    ...  AND    I send a POST request:    /carts    {"data": {"type": "carts","attributes": {"priceMode": "${gross_mode}","currency": "${currency_code_eur}","store": "${store_de}","name": "${test_cart_name}-${random}"}}}
    ...  AND    Save value to a variable:    [data][id]    cart_id
    ...  AND    Response status code should be:    201
    When I send a DELETE request:    /carts/${cart_id}
    Then Response status code should be:    204
    And Response reason should be:    No Content
    When I send a GET request:    /carts/${cart_id}
    Then Response status code should be:    404
    And Array in response should contain property with value:    [errors]    detail    Cart with given uuid not found.