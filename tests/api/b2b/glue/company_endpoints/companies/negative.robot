*** Settings ***
Suite Setup       SuiteSetup
Resource    ../../../../../../resources/common/common_api.robot

*** Test Cases ***
Request_company_by_wrong_ID
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
    ...    AND    I set Headers:    Content-Type=${default_header_content_type}    Authorization=${token}  
    When I send a GET request:    /companies/3525626
    Then Response status code should be:    404
    And Response should return error code:    1801
    And Response reason should be:    Not Found
    And Response body parameter should be:    [errors][0][detail]    Company not found.
    
Request_company_without_access_token 
    When I send a GET request:    /companies/${company_id}
    Then Response status code should be:    403
    And Response should return error code:    002
    And Response reason should be:    Forbidden
    And Response body parameter should be:    [errors][0][detail]    Missing access token.

Request_company_with_empty_company_id
    When I send a GET request:    /companies/
    Then Response status code should be:    403
    And Response should return error code:    002
    And Response reason should be:    Forbidden
    And Response body parameter should be:    [errors][0][detail]    Missing access token.
