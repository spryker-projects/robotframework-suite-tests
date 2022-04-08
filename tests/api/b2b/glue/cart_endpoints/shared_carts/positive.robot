*** Settings ***
Suite Setup       SuiteSetup
Test Setup    TestSetup
Resource    ../../../../../../resources/common/common_api.robot
Default Tags    glue

*** Test Cases ***
ENABLER
    TestSetup

# Create_a_shared_shopping_cart_with_read_only_permissions
#     [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
#     ...    AND    I set Headers:    Authorization=${token}  
#     ...    AND    I send a POST request:    /carts    {"data": {"type": "carts","attributes": {"priceMode": "${gross_mode}","currency": "${currency_code_eur}","store": "${store_de}","name": "${test_cart_name}-${random}"}}}
#     ...    AND    Save value to a variable:    [data][id]    cartId
#     ...    AND    I send a POST request:    /carts/${cartId}/items    {"data":{"type":"items","attributes":{"sku":"${concrete_available_product_sku}","quantity":1}}}
#     ...    AND    Response status code should be:    201
#     ...    AND    I send a GET request:    /company-users
#     ...    AND    Save value to a variable:    [data][0][id]    companyUserId
#     When I send a POST request:    /carts/${cartId}/shared-carts    {"data":{"type":"shared-carts","attributes":{"idCompanyUser":"${companyUserId}","idCartPermissionGroup":1}}}
#     Then Response status code should be:    201
#     And Response body parameter should be:    [data][type]    shared-carts
#     And Response body parameter should be:    [data][attributes][idCompanyUser]    ${companyUserId}
#     And Response body parameter should be:    [data][attributes][idCartPermissionGroup]    1
#     Then I get access token for the customer:    ${yves_shared_shopping_cart_user_email}
#     And I set Headers:    Authorization=${token}
#     And I send a GET request:    /carts/${cartId}?include=cart-permission-groups
#     And Response status code should be:    200
#     And Response should contain the array of a certain size:    [included]    1
#     And Response should contain the array of a certain size:    [data][relationships]    1
#     And Response body parameter should be:    [included][0][attributes][name]    READ_ONLY
#     [Teardown]    Run Keywords    I get access token for the customer:    ${yves_user_email}
#     ...    AND    I set Headers:    Authorization=${token}
#     ...    AND    I send a DELETE request:    /carts/${cartId}
#     ...    AND    Response status code should be:    204
#     ...    AND    Response reason should be:    No Content

# Create_a_shared_shopping_cart_with_full_access_permissions
#     [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
#     ...    AND    I set Headers:    Authorization=${token}  
#     ...    AND    I send a POST request:    /carts    {"data": {"type": "carts","attributes": {"priceMode": "${gross_mode}","currency": "${currency_code_eur}","store": "${store_de}","name": "${test_cart_name}-${random}"}}}
#     ...    AND    Save value to a variable:    [data][id]    cartId
#     ...    AND    I send a POST request:    /carts/${cartId}/items    {"data":{"type":"items","attributes":{"sku":"${concrete_available_product_sku}","quantity":1}}}
#     ...    AND    Response status code should be:    201
#     ...    AND    I send a GET request:    /company-users
#     ...    AND    Save value to a variable:    [data][0][id]    companyUserId
#     When I send a POST request:    /carts/${cartId}/shared-carts    {"data":{"type":"shared-carts","attributes":{"idCompanyUser":"${companyUserId}","idCartPermissionGroup":2}}}
#     Then Response status code should be:    201
#     And Save value to a variable:    [data][id]    sharedCardId
#     And Response body parameter should be:    [data][type]    shared-carts
#     And Response body parameter should be:    [data][attributes][idCompanyUser]    ${companyUserId}
#     And Response body parameter should be:    [data][attributes][idCartPermissionGroup]    2
#     Then I get access token for the customer:    ${yves_shared_shopping_cart_user_email}
#     And I set Headers:    Authorization=${token}
#     When I send a GET request:    /carts/${cartId}?include=cart-permission-groups
#     Then Response status code should be:    200
#     And Response should contain the array of a certain size:    [included]    1
#     And Response should contain the array of a certain size:    [data][relationships]    1
#     And Response body parameter should be:    [included][0][attributes][name]    FULL_ACCESS
#     [Teardown]    Run Keywords    I send a DELETE request:    /carts/${cartId}
#     ...    AND    Response status code should be:    204
#     ...    AND    Response reason should be:    No Content

# Update_permissions_of_shared_shopping_cart_by_card_owner
    # [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
    # ...    AND    I set Headers:    Authorization=${token}  
    # ...    AND    I send a POST request:    /carts    {"data": {"type": "carts","attributes": {"priceMode": "${gross_mode}","currency": "${currency_code_eur}","store": "${store_de}","name": "${test_cart_name}-${random}"}}}
    # ...    AND    Save value to a variable:    [data][id]    cartId
    # ...    AND    I send a POST request:    /carts/${cartId}/items    {"data":{"type":"items","attributes":{"sku":"${concrete_available_product_sku}","quantity":1}}}
    # ...    AND    Response status code should be:    201
    # ...    AND    I send a GET request:    /company-users
    # ...    AND    Save value to a variable:    [data][0][id]    companyUserId
    # ...    AND    I send a POST request:    /carts/${cartId}/shared-carts    {"data":{"type":"shared-carts","attributes":{"idCompanyUser":"${companyUserId}","idCartPermissionGroup":2}}}
    # ...    AND    Save value to a variable:    [data][id]    sharedCardId
    # When I send a PATCH request:    /shared-carts/${sharedCardId}    {"data":{"type":"shared-carts","attributes":{"idCartPermissionGroup":1}}}
    # And Response status code should be:    200
    # And Response body parameter should be:    [data][type]    shared-carts
    # And Response body parameter should be:    [data][attributes][idCompanyUser]    ${companyUserId}
    # And Response body parameter should be:    [data][attributes][idCartPermissionGroup]    1
    # Then I get access token for the customer:    ${yves_shared_shopping_cart_user_email}
    # And I set Headers:    Authorization=${token}
    # When I send a GET request:    /carts/${cartId}?include=cart-permission-groups
    # Then Response status code should be:    200
    # And Response body parameter should not be EMPTY:    [data][relationships]
    # And Response body parameter should not be EMPTY:    [data][relationships][cart-permission-groups]
    # And Each array element of array in response should contain property:    [data][relationships][cart-permission-groups][data]    type
    # And Each array element of array in response should contain property:    [data][relationships][cart-permission-groups][data]    id
    # And Response should contain the array of a certain size:    [included]    1
    # And Response should contain the array of a certain size:    [data][relationships]    1
    # And Response body parameter should be:    [included][0][attributes][name]    READ_ONLY
    # [Teardown]    Run Keywords    I get access token for the customer:    ${yves_user_email}
    # ...    AND    I set Headers:    Authorization=${token}
    # ...    AND    I send a DELETE request:    /carts/${cartId}
    # ...    AND    Response status code should be:    204
    # ...    AND    Response reason should be:    No Content

# Add_an_item_to_the_shared_shopping_cart_by_user_with_access
#     [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
#     ...    AND    I set Headers:    Authorization=${token}  
#     ...    AND    I send a POST request:    /carts    {"data": {"type": "carts","attributes": {"priceMode": "${gross_mode}","currency": "${currency_code_eur}","store": "${store_de}","name": "${test_cart_name}-${random}"}}}
#     ...    AND    Save value to a variable:    [data][id]    cartId
#     ...    AND    I send a GET request:    /company-users
#     ...    AND    Save value to a variable:    [data][0][id]    companyUserId
#     ...    AND    I send a POST request:    /carts/${cartId}/shared-carts    {"data":{"type":"shared-carts","attributes":{"idCompanyUser":"${companyUserId}","idCartPermissionGroup":2}}}
#     ...    AND    Response status code should be:    201
#     ...    AND    Then I get access token for the customer:    ${yves_shared_shopping_cart_user_email}
#     ...    AND    I set Headers:    Authorization=${token}
#     When I send a POST request:    /carts/${cartId}/items?include=items    {"data":{"type":"items","attributes":{"sku":"${concrete_available_product_sku}","quantity":1}}}
#     Then Response status code should be:    201
#     And Response body parameter should be:    [data][id]    ${cartId}
#     And Response body parameter should be:    [data][type]    carts
#     And Response body parameter should be:    [included][0][id]    ${concrete_available_product_sku}
#     And Response body parameter should be:    [included][0][attributes][quantity]    1
#     And Response body parameter should be greater than:    [included][0][attributes][calculations][sumPriceToPayAggregation]    0
#     [Teardown]    Run Keywords    I send a DELETE request:    /carts/${cartId}
#     ...    AND    Response status code should be:    204
#     ...    AND    Response reason should be:    No Content

# Update_an_item_quantity_at_the_shared_shopping_cart_with_full_access_permissions_by_user_with_access
#     [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
#     ...    AND    I set Headers:    Authorization=${token}  
#     ...    AND    I send a POST request:    /carts    {"data": {"type": "carts","attributes": {"priceMode": "${gross_mode}","currency": "${currency_code_eur}","store": "${store_de}","name": "${test_cart_name}-${random}"}}}
#     ...    AND    Save value to a variable:    [data][id]    cartId
#     ...    AND    I send a POST request:    /carts/${cartId}/items?include=items    {"data":{"type":"items","attributes":{"sku":"${concrete_available_product_sku}","quantity":1}}}
#     ...    AND    Save value to a variable:    [included][0][id]    itemId
#     ...    AND    Save value to a variable:    [included][0][attributes][calculations][sumPriceToPayAggregation]    itemTotalPrice
#     ...    AND    I send a GET request:    /company-users
#     ...    AND    Save value to a variable:    [data][0][id]    companyUserId
#     ...    AND    I send a POST request:    /carts/${cartId}/shared-carts    {"data":{"type":"shared-carts","attributes":{"idCompanyUser":"${companyUserId}","idCartPermissionGroup":2}}}
#     ...    AND    Response status code should be:    201
#     ...    AND    Then I get access token for the customer:    ${yves_shared_shopping_cart_user_email}
#     ...    AND    I set Headers:    Authorization=${token}
#     When I send a PATCH request:    /carts/${cartId}/items/${itemId}?include=items    {"data":{"type":"items","attributes":{"quantity":2}}}
#     Then Response status code should be:    200
#     And Response reason should be:    OK
#     And Response header parameter should be:    Content-Type    ${default_header_content_type}
#     And Response body parameter should be:    [data][id]    ${cartId}
#     And Response body parameter should be:    [data][type]    carts
#     And Response body parameter should be:    [included][0][id]    ${itemId}
#     And Response body parameter should be:    [included][0][attributes][quantity]    2
#     And Response body parameter should be greater than:    [included][0][attributes][calculations][sumPriceToPayAggregation]    ${itemTotalPrice}
#     [Teardown]    Run Keywords    I send a DELETE request:    /carts/${cartId}
#     ...    AND    Response status code should be:    204
#     ...    AND    Response reason should be:    No Content

# Delete_an_item_from_the_shared_shopping_cart_with_full_access_permissions_by_user_with_access
#     [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
#     ...    AND    I set Headers:    Authorization=${token}  
#     ...    AND    I send a POST request:    /carts    {"data": {"type": "carts","attributes": {"priceMode": "${gross_mode}","currency": "${currency_code_eur}","store": "${store_de}","name": "${test_cart_name}-${random}"}}}
#     ...    AND    Save value to a variable:    [data][id]    cartId
#     ...    AND    I send a POST request:    /carts/${cartId}/items    {"data":{"type":"items","attributes":{"sku":"${concrete_available_product_sku}","quantity":1}}}
#     ...    AND    Response status code should be:    201
#     ...    AND    I send a GET request:    /company-users
#     ...    AND    Save value to a variable:    [data][0][id]    companyUserId
#     ...    AND    I send a POST request:    /carts/${cartId}/shared-carts    {"data":{"type":"shared-carts","attributes":{"idCompanyUser":"${companyUserId}","idCartPermissionGroup":2}}}
#     ...    AND    Response status code should be:    201
#     ...    AND    Then I get access token for the customer:    ${yves_shared_shopping_cart_user_email}
#     ...    AND    I set Headers:    Authorization=${token}
#     ...    AND    I send a GET request:    /carts/${cartId}?include=items
#     ...    AND    Save value to a variable:    [data][relationships][items][data][0][id]    itemId
#     When I send a DELETE request:    /carts/${cartId}/items/${itemId}
#     Then Response status code should be:    204
#     And Response reason should be:    No Content
#     And I send a GET request:    /carts/${cartId}
#     And Response body parameter should be:    [data][attributes][totals][grandTotal]    0 
#     [Teardown]    Run Keywords    I send a DELETE request:    /carts/${cartId}
#     ...    AND    Response status code should be:    204
#     ...    AND    Response reason should be:    No Content

# Delete_a_shared_shopping_cart_with_full_access_permissions_by_user_with_access
#     [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
#     ...    AND    I set Headers:    Authorization=${token}  
#     ...    AND    I send a POST request:    /carts    {"data": {"type": "carts","attributes": {"priceMode": "${gross_mode}","currency": "${currency_code_eur}","store": "${store_de}","name": "${test_cart_name}-${random}"}}}
#     ...    AND    Save value to a variable:    [data][id]    cartId
#     ...    AND    I send a POST request:    /carts/${cartId}/items    {"data":{"type":"items","attributes":{"sku":"${concrete_available_product_sku}","quantity":2}}}
#     ...    AND    Response status code should be:    201
#     ...    AND    I send a GET request:    /company-users
#     ...    AND    Save value to a variable:    [data][0][id]    companyUserId
#     ...    AND    I send a POST request:    /carts/${cartId}/shared-carts    {"data":{"type":"shared-carts","attributes":{"idCompanyUser":"${companyUserId}","idCartPermissionGroup":2}}}
#     ...    AND    Response status code should be:    201
#     ...    AND    I get access token for the customer:    ${yves_shared_shopping_cart_user_email}
#     ...    AND    I set Headers:    Authorization=${token}
#     When I send a DELETE request:    /carts/${cartId}
#     Then Response status code should be:    204
#     And Response reason should be:    No Content
    
# Delete_a_shared_shopping_cart_by_cart_owner
    # [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
    # ...    AND    I set Headers:    Authorization=${token}  
    # ...    AND    I send a POST request:    /carts    {"data": {"type": "carts","attributes": {"priceMode": "${gross_mode}","currency": "${currency_code_eur}","store": "${store_de}","name": "${test_cart_name}-${random}"}}}
    # ...    AND    Save value to a variable:    [data][id]    cartId
    # ...    AND    I send a GET request:    /company-users
    # ...    AND    Save value to a variable:    [data][0][id]    companyUserId
    # ...    AND    I send a POST request:    /carts/${cartId}/shared-carts    {"data":{"type":"shared-carts","attributes":{"idCompanyUser":"${companyUserId}","idCartPermissionGroup":2}}}
    # ...    AND    Save value to a variable:    [data][id]    sharedCardId
    # When I send a DELETE request:    /shared-carts/${sharedCardId}
    # Then Response status code should be:    204
    # And Response reason should be:    No Content
