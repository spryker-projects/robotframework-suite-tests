*** Settings ***
Suite Setup    SuiteSetup
Test Setup    TestSetup
Resource    ../../../../../../resources/common/common_api.robot
Default Tags    glue

*** Test Cases ***
ENABLER
    TestSetup

# #POST requests
# Provide_checkout_data
#     [Documentation]    Created a new bug https://spryker.atlassian.net/browse/CC-23077
#     [Tags]    skip-due-to-issue  
#     [Setup]    Run Keywords    I get access token for the customer:    ${yves_user.email}
#     ...  AND    I set Headers:    Authorization=${token}
#     ...  AND    Find or create customer cart
#     ...  AND    Cleanup all items in the cart:    ${cart_id}
#     ...  AND    I send a POST request:    /carts/${cart_id}/items?include=items    {"data": {"type": "items","attributes": {"sku": "${product_availability.concrete_available_with_stock_and_never_out_of_stock_sku}","quantity": 1}}}
#     ...  AND    Save value to a variable:    [included][0][id]    checkout_item_1
#     When I send a POST request:    /checkout-data?include=shipments,shipment-methods    {"data": {"type": "checkout-data","attributes": {"customer": {"email": "${yves_user.email}","salutation": "${yves_user.salutation}","firstName": "${yves_user.first_name}","lastName": "${yves_user.last_name}"},"idCart": "${cart_id}","billingAddress": {"salutation": "${yves_user.salutation}","firstName": "${yves_user.first_name}","lastName": "${yves_user.last_name}","address1": "${default.address1}","address2": "${default.address2}","address3": "${default.address3}","zipCode": "${default.zipCode}","city": "${default.city}","iso2Code": "${default.iso2Code}","company": "${default.company}","phone": "${default.phone}","isDefaultBilling": True,"isDefaultShipping": True},"shippingAddress": {"salutation": "${yves_user.salutation}","firstName": "${yves_user.first_name}","lastName": "${yves_user.last_name}","address1": "${default.address1}","address2": "${default.address2}","address3": "${default.address3}","zipCode": "${default.zipCode}","city": "${default.city}","iso2Code": "${default.iso2Code}","company": "${default.company}","phone": "${default.phone}","isDefaultBilling": True,"isDefaultShipping": True},"payments": [{"paymentProviderName": "${payment.provider_name}","paymentMethodName": "${payment.method_name}"}],"shipment": {"idShipmentMethod": 1},"items": ["${checkout_item_1}"]}}}
#     Then Response status code should be:    200
#     And Response reason should be:    OK
#     And Response body parameter should be:    [data][type]    checkout-data
#     And Response body parameter should be:    [data][id]    None
#     And Response should contain the array of a certain size:    [data][attributes][addresses]    0
#     And Response should contain the array of a certain size:    [data][attributes][paymentProviders]    0
#     And Response should contain the array of a certain size:    [data][attributes][shipmentMethods]    0
#     And Response body parameter should be:    [data][attributes][selectedShipmentMethods][0][id]    1
#     And Response body parameter should be:    [data][attributes][selectedShipmentMethods][0][name]    ${shipment.method_name}
#     And Response body parameter should be:    [data][attributes][selectedShipmentMethods][0][carrierName]    ${shipment.carrier_name}
#     And Response body parameter should be greater than:    [data][attributes][selectedShipmentMethods][0][price]    0
#     And Response body parameter should be:    [data][attributes][selectedShipmentMethods][0][taxRate]    None
#     And Response body parameter should be:    [data][attributes][selectedShipmentMethods][0][deliveryTime]    None
#     And Response body parameter should be:    [data][attributes][selectedShipmentMethods][0][currencyIsoCode]    ${currency.eur.code}
#     And Response should contain the array of a certain size:    [data][attributes][selectedPaymentMethods]    0
#     And Response body has correct self link internal

Provide_checkout_data
    [Documentation]    Created a new bug https://spryker.atlassian.net/browse/CC-23077 (not a bug, changed bihavior https://docs.spryker.com/docs/pbc/all/carrier-management/202212.0/manage-via-glue-api/retrieve-shipments-and-shipment-methods-when-submitting-checkout-data.html#response)
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user.email}
    ...  AND    I set Headers:    Authorization=${token}
    ...  AND    Find or create customer cart
    ...  AND    Cleanup all items in the cart:    ${cart_id}
    ...  AND    I send a POST request:    /carts/${cart_id}/items?include=items    {"data": {"type": "items","attributes": {"sku": "${product_availability.concrete_available_with_stock_and_never_out_of_stock_sku}","quantity": 1}}}
    ...  AND    Save value to a variable:    [included][0][id]    checkout_item_1
    When I send a POST request:    /checkout-data?include=shipments   {"data": {"type": "checkout-data","attributes": {"customer": {"email": "${yves_user.email}","salutation": "${yves_user.salutation}","firstName":"${yves_user.first_name}","lastName": "${yves_user.last_name}"},"idCart": "${cart_id}","billingAddress":{"salutation": "${yves_user.salutation}","firstName": "${yves_user.first_name}","lastName": "${yves_user.last_name}","address1": "${default.address1}","address2": "${default.address2}","address3": "${default.address3}","zipCode": "${default.zipCode}","city": "${default.city}","iso2Code": "${default.iso2Code}","company": "${default.company}","phone": "${default.phone}","isDefaultBilling": True,"isDefaultShipping": True},"payments": [{"paymentProviderName": "${payment.provider_name}","paymentMethodName": "${payment.method_name}"}],"shipments": [{"items": ["${checkout_item_1}"],"shippingAddress": {"id": "null","salutation": "${yves_user.salutation}","firstName": "${yves_user.first_name}","lastName": "${yves_user.last_name}","address1": "${default.address1}","address2": "${default.address2}","address3": "${default.address3}","zipCode":"${default.zipCode}","city": "${default.city}","iso2Code": "${default.iso2Code}","company": "${default.company}","phone": "${default.phone}"},"idShipmentMethod": 1,"requestedDeliveryDate": "2021-09-29"}]}}}
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][type]    checkout-data
    And Response body parameter should be:    [data][id]    None
    And Response should contain the array of a certain size:    [data][attributes][addresses]    0
    And Response should contain the array of a certain size:    [data][attributes][paymentProviders]    0
    And Response should contain the array of a certain size:    [data][attributes][shipmentMethods]    0
    And Response body parameter should be:    [included][0][attributes][selectedShipmentMethod][id]    1
    And Response body parameter should be:    [included][0][attributes][selectedShipmentMethod][name]    ${shipment.method_name}
    And Response body parameter should be:    [included][0][attributes][selectedShipmentMethod][carrierName]    ${shipment.carrier_name}
    And Response body parameter should be greater than:    [included][0][attributes][selectedShipmentMethod][price]    400
    And Response body parameter should be:    [included][0][attributes][selectedShipmentMethod][taxRate]    ${tax_rate}
    And Response body parameter should be:    [included][0][attributes][selectedShipmentMethod][deliveryTime]    None
    And Response body parameter should be:    [included][0][attributes][selectedShipmentMethod][currencyIsoCode]    ${currency.eur.code}
    And Response should contain the array of a certain size:    [data][attributes][selectedPaymentMethods]    0
    And Response body has correct self link internal

Provide_checkout_with_only_cart_id
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user.email}
    ...  AND    I set Headers:    Authorization=${token}
    ...  AND    Find or create customer cart
    ...  AND    Cleanup all items in the cart:    ${cart_id}
    ...  AND    I send a POST request:    /carts/${cart_id}/items    {"data": {"type": "items","attributes": {"sku": "${product_availability.concrete_available_with_stock_and_never_out_of_stock_sku}","quantity": 1}}}
    When I send a POST request:    /checkout-data    {"data": {"type": "checkout-data", "attributes": {"idCart": "${cart_id}","payments": []}}}
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][type]    checkout-data
    And Response body parameter should be:    [data][id]    None
    And Response should contain the array of a certain size:    [data][attributes][addresses]    0
    And Response should contain the array of a certain size:    [data][attributes][paymentProviders]    0
    And Response should contain the array of a certain size:    [data][attributes][shipmentMethods]    0
    And Response should contain the array of a certain size:    [data][attributes][selectedShipmentMethods]    0
    And Response should contain the array of a certain size:    [data][attributes][selectedPaymentMethods]    0
    And Response body has correct self link internal


Provide_checkout_data_with_invalid_billing_address_data
    [Documentation]   Created a new bug https://spryker.atlassian.net/browse/CC-23077
    [Tags]    skip-due-to-issue
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user.email}
    ...  AND    I set Headers:    Authorization=${token}
    ...  AND    Find or create customer cart
    ...  AND    Cleanup all items in the cart:    ${cart_id}
    ...  AND    I send a POST request:    /carts/${cart_id}/items    {"data": {"type": "items","attributes": {"sku": "${product_availability.concrete_available_with_stock_and_never_out_of_stock_sku}","quantity": 1}}}
    When I send a POST request:    /checkout-data    {"data": {"type": "checkout-data","attributes": {"customer": {"email": "${yves_user.email}","salutation": "${yves_user.salutation}","firstName": "${yves_user.first_name}","lastName": "${yves_user.last_name}"},"idCart": "${cart_id}","billingAddress": {"salutation": "fake_salutation","firstName": "fake_first_name","lastName": "fake_last_name","address1": "fake_address1","address2": "fake_address2","address3": "fake_address3","zipCode": "fake_zipCode","city": "fake_city","iso2Code": "fake_iso2Code","company": "fake_company","phone": "fake_phone","isDefaultBilling": True,"isDefaultShipping": True},"shippingAddress": {"salutation": "${yves_user.salutation}","firstName": "${yves_user.first_name}","lastName": "${yves_user.last_name}","address1": "${default.address1}","address2": "${default.address2}","address3": "${default.address3}","zipCode": "${default.zipCode}","city": "${default.city}","iso2Code": "${default.iso2Code}","company": "${default.company}","phone": "${default.phone}","isDefaultBilling": True,"isDefaultShipping": True},"payments": [{"paymentProviderName": "${payment.provider_name}","paymentMethodName": "${payment.method_name}"}],"shipment": {"idShipmentMethod": 1},"items": ["${product_availability.concrete_available_with_stock_and_never_out_of_stock_sku}"]}}}
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][type]    checkout-data
    And Response body parameter should be:    [data][id]    None
    And Response should contain the array of a certain size:    [data][attributes][addresses]    0
    And Response should contain the array of a certain size:    [data][attributes][paymentProviders]    0
    And Response should contain the array of a certain size:    [data][attributes][shipmentMethods]    0
    And Response body parameter should be:    [data][attributes][selectedShipmentMethods][0][id]    1
    And Response body parameter should be:    [data][attributes][selectedShipmentMethods][0][name]    ${shipment.method_name}
    And Response body parameter should be:    [data][attributes][selectedShipmentMethods][0][carrierName]    ${shipment.carrier_name}
    And Response body parameter should be greater than:    [data][attributes][selectedShipmentMethods][0][price]    0
    And Response body parameter should be:    [data][attributes][selectedShipmentMethods][0][taxRate]    None
    And Response body parameter should be:    [data][attributes][selectedShipmentMethods][0][deliveryTime]    None
    And Response body parameter should be:    [data][attributes][selectedShipmentMethods][0][currencyIsoCode]    ${currency.eur.code}
    And Response should contain the array of a certain size:    [data][attributes][selectedPaymentMethods]    0
    And Response body has correct self link internal

Provide_checkout_data_with_invalid_shipping_address_data
    [Documentation]   Created a new bug https://spryker.atlassian.net/browse/CC-23077
    [Tags]    skip-due-to-issue
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user.email}
    ...  AND    I set Headers:    Authorization=${token}
    ...  AND    Find or create customer cart
    ...  AND    Cleanup all items in the cart:    ${cart_id}
    ...  AND    I send a POST request:    /carts/${cart_id}/items    {"data": {"type": "items","attributes": {"sku": "${product_availability.concrete_available_with_stock_and_never_out_of_stock_sku}","quantity": 1}}}
    When I send a POST request:    /checkout-data    {"data": {"type": "checkout-data","attributes": {"customer": {"email": "${yves_user.email}","salutation": "${yves_user.salutation}","firstName": "${yves_user.first_name}","lastName": "${yves_user.last_name}"},"idCart": "${cart_id}","billingAddress": {"salutation": "${yves_user.salutation}","firstName": "${yves_user.first_name}","lastName": "${yves_user.last_name}","address1": "${default.address1}","address2": "${default.address2}","address3": "${default.address3}","zipCode": "${default.zipCode}","city": "${default.city}","iso2Code": "${default.iso2Code}","company": "${default.company}","phone": "${default.phone}","isDefaultBilling": True,"isDefaultShipping": True},"shippingAddress": {"salutation": "fake_salutation","firstName": "fake_first_name","lastName": "fake_last_name","address1": "fake_address1","address2": "fake_address2","address3": "fake_address3","zipCode": "fake_zipCode","city": "fake_city","iso2Code": "fake_iso2Code","company": "fake_company","phone": "fake_phone","isDefaultBilling": True,"isDefaultShipping": True},"payments": [{"paymentProviderName": "${payment.provider_name}","paymentMethodName": "${payment.method_name}"}],"shipment": {"idShipmentMethod": 1},"items": ["${product_availability.concrete_available_with_stock_and_never_out_of_stock_sku}"]}}}
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][type]    checkout-data
    And Response body parameter should be:    [data][id]    None
    And Response should contain the array of a certain size:    [data][attributes][addresses]    0
    And Response should contain the array of a certain size:    [data][attributes][paymentProviders]    0
    And Response should contain the array of a certain size:    [data][attributes][shipmentMethods]    0
    And Response body parameter should be:    [data][attributes][selectedShipmentMethods][0][id]    1
    And Response body parameter should be:    [data][attributes][selectedShipmentMethods][0][name]    ${shipment.method_name}
    And Response body parameter should be:    [data][attributes][selectedShipmentMethods][0][carrierName]    ${shipment.carrier_name}
    And Response body parameter should be greater than:    [data][attributes][selectedShipmentMethods][0][price]    0
    And Response body parameter should be:    [data][attributes][selectedShipmentMethods][0][taxRate]    None
    And Response body parameter should be:    [data][attributes][selectedShipmentMethods][0][deliveryTime]    None
    And Response body parameter should be:    [data][attributes][selectedShipmentMethods][0][currencyIsoCode]    ${currency.eur.code}
    And Response should contain the array of a certain size:    [data][attributes][selectedPaymentMethods]    0
    And Response body has correct self link internal


Provide_checkout_data_with_invalid_payments
    [Documentation]    Created a new bug https://spryker.atlassian.net/browse/CC-23077
    [Tags]    skip-due-to-issue
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user.email}
    ...  AND    I set Headers:    Authorization=${token}
    ...  AND    Find or create customer cart
    ...  AND    Cleanup all items in the cart:    ${cart_id}
    ...  AND    I send a POST request:    /carts/${cart_id}/items    {"data": {"type": "items","attributes": {"sku": "${product_availability.concrete_available_with_stock_and_never_out_of_stock_sku}","quantity": 1}}}
    When I send a POST request:    /checkout-data    {"data": {"type": "checkout-data","attributes": {"customer": {"email": "${yves_user.email}","salutation": "${yves_user.salutation}","firstName": "${yves_user.first_name}","lastName": "${yves_user.last_name}"},"idCart": "${cart_id}","billingAddress": {"salutation": "${yves_user.salutation}","firstName": "${yves_user.first_name}","lastName": "${yves_user.last_name}","address1": "${default.address1}","address2": "${default.address2}","address3": "${default.address3}","zipCode": "${default.zipCode}","city": "${default.city}","iso2Code": "${default.iso2Code}","company": "${default.company}","phone": "${default.phone}","isDefaultBilling": True,"isDefaultShipping": True},"shippingAddress": {"salutation": "${yves_user.salutation}","firstName": "${yves_user.first_name}","lastName": "${yves_user.last_name}","address1": "${default.address1}","address2": "${default.address2}","address3": "${default.address3}","zipCode": "${default.zipCode}","city": "${default.city}","iso2Code": "${default.iso2Code}","company": "${default.company}","phone": "${default.phone}","isDefaultBilling": True,"isDefaultShipping": True},"payments": [{"paymentProviderName": "fake_provider_name","paymentMethodName": "fake_method_name"}],"shipment": {"idShipmentMethod": 1},"items": ["${product_availability.concrete_available_with_stock_and_never_out_of_stock_sku}"]}}}
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][type]    checkout-data
    And Response body parameter should be:    [data][id]    None
    And Response should contain the array of a certain size:    [data][attributes][addresses]    0
    And Response should contain the array of a certain size:    [data][attributes][paymentProviders]    0
    And Response should contain the array of a certain size:    [data][attributes][shipmentMethods]    0
    And Response body parameter should be:    [data][attributes][selectedShipmentMethods][0][id]    1
    And Response body parameter should be:    [data][attributes][selectedShipmentMethods][0][name]    ${shipment.method_name}
    And Response body parameter should be:    [data][attributes][selectedShipmentMethods][0][carrierName]    ${shipment.carrier_name}
    And Response body parameter should be greater than:    [data][attributes][selectedShipmentMethods][0][price]    0
    And Response body parameter should be:    [data][attributes][selectedShipmentMethods][0][taxRate]    None
    And Response body parameter should be:    [data][attributes][selectedShipmentMethods][0][deliveryTime]    None
    And Response body parameter should be:    [data][attributes][selectedShipmentMethods][0][currencyIsoCode]    ${currency.eur.code}
    And Response should contain the array of a certain size:    [data][attributes][selectedPaymentMethods]    0
    And Response body has correct self link internal


Provide_checkout_data_with_invalid_shipment_method_id
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user.email}
    ...  AND    I set Headers:    Authorization=${token}
    ...  AND    Find or create customer cart
    ...  AND    Cleanup all items in the cart:    ${cart_id}
    ...  AND    I send a POST request:    /carts/${cart_id}/items    {"data": {"type": "items","attributes": {"sku": "${product_availability.concrete_available_with_stock_and_never_out_of_stock_sku}","quantity": 1}}}
    When I send a POST request:    /checkout-data    {"data": {"type": "checkout-data","attributes": {"customer": {"email": "${yves_user.email}","salutation": "${yves_user.salutation}","firstName": "${yves_user.first_name}","lastName": "${yves_user.last_name}"},"idCart": "${cart_id}","billingAddress": {"salutation": "${yves_user.salutation}","firstName": "${yves_user.first_name}","lastName": "${yves_user.last_name}","address1": "${default.address1}","address2": "${default.address2}","address3": "${default.address3}","zipCode": "${default.zipCode}","city": "${default.city}","iso2Code": "${default.iso2Code}","company": "${default.company}","phone": "${default.phone}","isDefaultBilling": True,"isDefaultShipping": True},"shippingAddress": {"salutation": "${yves_user.salutation}","firstName": "${yves_user.first_name}","lastName": "${yves_user.last_name}","address1": "${default.address1}","address2": "${default.address2}","address3": "${default.address3}","zipCode": "${default.zipCode}","city": "${default.city}","iso2Code": "${default.iso2Code}","company": "${default.company}","phone": "${default.phone}","isDefaultBilling": True,"isDefaultShipping": True},"payments": [{"paymentProviderName": "${payment.provider_name}","paymentMethodName": "${payment.method_name}"}],"shipment": {"idShipmentMethod": 0},"items": ["${product_availability.concrete_available_with_stock_and_never_out_of_stock_sku}"]}}}
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][type]    checkout-data
    And Response body parameter should be:    [data][id]    None
    And Response should contain the array of a certain size:    [data][attributes][addresses]    0
    And Response should contain the array of a certain size:    [data][attributes][paymentProviders]    0
    And Response should contain the array of a certain size:    [data][attributes][shipmentMethods]    0
    And Response should contain the array of a certain size:    [data][attributes][selectedShipmentMethods]    0
    And Response should contain the array of a certain size:    [data][attributes][selectedPaymentMethods]    0
    And Response body has correct self link internal


Provide_checkout_data_with_empty_cart
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user.email}
    ...  AND    I set Headers:    Authorization=${token}
    ...  AND    Find or create customer cart
    ...  AND    Cleanup all items in the cart:    ${cart_id}
    When I send a POST request:    /checkout-data    {"data": {"type": "checkout-data","attributes": {"customer": {"email": "${yves_user.email}","salutation": "${yves_user.salutation}","firstName": "${yves_user.first_name}","lastName": "${yves_user.last_name}"},"idCart": "${cart_id}","billingAddress": {"salutation": "${yves_user.salutation}","firstName": "${yves_user.first_name}","lastName": "${yves_user.last_name}","address1": "${default.address1}","address2": "${default.address2}","address3": "${default.address3}","zipCode": "${default.zipCode}","city": "${default.city}","iso2Code": "${default.iso2Code}","company": "${default.company}","phone": "${default.phone}","isDefaultBilling": True,"isDefaultShipping": True},"shippingAddress": {"salutation": "${yves_user.salutation}","firstName": "${yves_user.first_name}","lastName": "${yves_user.last_name}","address1": "${default.address1}","address2": "${default.address2}","address3": "${default.address3}","zipCode": "${default.zipCode}","city": "${default.city}","iso2Code": "${default.iso2Code}","company": "${default.company}","phone": "${default.phone}","isDefaultBilling": True,"isDefaultShipping": True},"payments": [{"paymentProviderName": "${payment.provider_name}","paymentMethodName": "${payment.method_name}"}],"shipment": {"idShipmentMethod": 1},"items": ["${product_availability.concrete_available_with_stock_and_never_out_of_stock_sku}"]}}}
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][type]    checkout-data
    And Response body parameter should be:    [data][id]    None
    And Response should contain the array of a certain size:    [data][attributes][addresses]    0
    And Response should contain the array of a certain size:    [data][attributes][paymentProviders]    0
    And Response should contain the array of a certain size:    [data][attributes][shipmentMethods]    0
    And Response should contain the array of a certain size:    [data][attributes][selectedShipmentMethods]    0
    And Response should contain the array of a certain size:    [data][attributes][selectedPaymentMethods]    0
    And Response body has correct self link internal


Provide_checkout_data_with_bundle_product
    [Documentation]   Created a new bug https://spryker.atlassian.net/browse/CC-23077
    [Tags]    skip-due-to-issue
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user.email}
    ...  AND    I set Headers:    Authorization=${token}
    ...  AND    Find or create customer cart
    ...  AND    Cleanup all items in the cart:    ${cart_id}
    ...  AND    I send a POST request:    /carts/${cart_id}/items    {"data": {"type": "items","attributes": {"sku": "${bundle_product.concrete_sku}","quantity": 1}}}
    When I send a POST request:    /checkout-data    {"data": {"type": "checkout-data","attributes": {"customer": {"email": "${yves_user.email}","salutation": "${yves_user.salutation}","firstName": "${yves_user.first_name}","lastName": "${yves_user.last_name}"},"idCart": "${cart_id}","billingAddress": {"salutation": "${yves_user.salutation}","firstName": "${yves_user.first_name}","lastName": "${yves_user.last_name}","address1": "${default.address1}","address2": "${default.address2}","address3": "${default.address3}","zipCode": "${default.zipCode}","city": "${default.city}","iso2Code": "${default.iso2Code}","company": "${default.company}","phone": "${default.phone}","isDefaultBilling": True,"isDefaultShipping": True},"shippingAddress": {"salutation": "${yves_user.salutation}","firstName": "${yves_user.first_name}","lastName": "${yves_user.last_name}","address1": "${default.address1}","address2": "${default.address2}","address3": "${default.address3}","zipCode": "${default.zipCode}","city": "${default.city}","iso2Code": "${default.iso2Code}","company": "${default.company}","phone": "${default.phone}","isDefaultBilling": True,"isDefaultShipping": True},"payments": [{"paymentProviderName": "${payment.provider_name}","paymentMethodName": "${payment.method_name}"}],"shipment": {"idShipmentMethod": 1},"items": ["${product_availability.concrete_available_with_stock_and_never_out_of_stock_sku}"]}}}
    Then Response status code should be:    200
    And Response reason should be:    OK
    And Response body parameter should be:    [data][type]    checkout-data
    And Response body parameter should be:    [data][id]    None
    And Response should contain the array of a certain size:    [data][attributes][addresses]    0
    And Response should contain the array of a certain size:    [data][attributes][paymentProviders]    0
    And Response should contain the array of a certain size:    [data][attributes][shipmentMethods]    0
    And Response body parameter should be:    [data][attributes][selectedShipmentMethods][0][id]    1
    And Response body parameter should be:    [data][attributes][selectedShipmentMethods][0][name]    ${shipment.method_name}
    And Response body parameter should be:    [data][attributes][selectedShipmentMethods][0][carrierName]    ${shipment.carrier_name}
    And Response body parameter should be greater than:    [data][attributes][selectedShipmentMethods][0][price]    0
    And Response body parameter should be:    [data][attributes][selectedShipmentMethods][0][taxRate]    None
    And Response body parameter should be:    [data][attributes][selectedShipmentMethods][0][deliveryTime]    None
    And Response body parameter should be:    [data][attributes][selectedShipmentMethods][0][currencyIsoCode]    ${currency.eur.code}
    And Response should contain the array of a certain size:    [data][attributes][selectedPaymentMethods]    0
    And Response body has correct self link internal
