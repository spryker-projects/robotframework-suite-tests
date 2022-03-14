*** Settings ***
Suite Setup       SuiteSetup
Resource    ../../../../../../resources/common/common_api.robot

*** Test Cases ***
Request_company_user_by_wrong_ID
    [Setup]    Run Keywords    I get access token for the customer:    ${yves_user_email}
    ...    AND    I set Headers:    Content-Type=${default_header_content_type}    Authorization=${token}  
    When I send a GET request:    /company-users/645647
    Then Response status code should be:    404
    And Response should return error code:    1404
    And Response reason should be:    Not Found
    And Response body parameter should be:    [errors][0][detail]    Company user not found

Request_company_user_without_access_token 
    When I send a GET request:    /company-users/
    Then Response status code should be:    403
    And Response should return error code:    002
    And Response reason should be:    Forbidden
    And Response body parameter should be:    [errors][0][detail]    Missing access token.

Request_company_user_with_wrong_access_token 
    [Setup]    I set Headers:    Authorization=sdrtfuygiuhoi 
    When I send a GET request:    /company-users/
    Then Response status code should be:    401
    And Response should return error code:    001
    And Response reason should be:    Unauthorized
    And Response body parameter should be:    [errors][0][detail]    Invalid access token.