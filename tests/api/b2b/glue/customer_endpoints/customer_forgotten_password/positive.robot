*** Settings ***
Suite Setup       SuiteSetup
Resource    ../../../../../../resources/common/common_api.robot

*** Test Cases ***
Forgot_password_with_all_required_fields_and_valid_data
    I send a POST request:    /customer-forgotten-password    {"data":{"type":"customer-forgotten-password","attributes":{"email":"${yves_user_email}"}}}
    Response status code should be:    204
    And Response reason should be:    No Content