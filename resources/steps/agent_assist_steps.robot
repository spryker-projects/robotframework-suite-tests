*** Settings ***
Resource    ../pages/zed/zed_create_zed_user_page.robot
Resource    ../common/common_zed.robot
Resource    ../common/common.robot

*** Keywords ***
Zed: create new Zed user with the following data:
    [Arguments]    ${zedUserEmail}    ${zedUserPassword}   ${zedUserFirstName}    ${zedUserLastName}    ${checkboxGroup}   ${checkboxAgent}    ${userInterfaceLanguage}
    ${currentURL}=    Get Location        
    Run Keyword Unless    '/user' in '${currentURL}'    Zed: go to second navigation item level:    Users    Users
    Zed: click button in Header:    Add New User
    Wait Until Element Is Visible    ${zed_user_email_field}
    Type Text    ${zed_user_email_field}    ${zedUserEmail}
    Type Text    ${zed_user_password_filed}    ${zedUserPassword}
    Type Text    ${zed_user_repeat_password_field}    ${zedUserPassword}
    Type Text    ${zed_user_first_name_field}    ${zedUserFirstName}
    Type Text    ${zed_user_last_name_field}    ${zedUserLastName}
    Zed: Check checkbox by Label:    ${checkboxGroup}
    Zed: Check checkbox by Label:    ${checkboxAgent}
    Select From List By Label    ${zed_user_interface_language}    ${userInterfaceLanguage}
    Zed: submit the form
    Zed: table should contain:    ${zedUserEmail}  

Yves: perform search by customer:
    [Arguments]    ${searchQuery}
    Type Text    ${agent_customer_search_widget}    ${searchQuery}
        
        

Yves: agent widget contains:
    [Arguments]    ${searchQuery}
    Wait Until Element Is Visible    xpath=//ul[@data-qa='component customer-list']/li[@data-value='${searchQuery}']
    Page Should Contain Element    xpath=//ul[@data-qa='component customer-list']/li[@data-value='${searchQuery}']

Yves: As an Agent login under the customer:
    [Arguments]    ${searchQuery} 
    Yves: perform search by customer:    ${searchQuery}
    Wait Until Element Is Visible    //ul[@data-qa='component customer-list']/li[@data-value='${searchQuery}']
    Click    xpath=//ul[@data-qa='component customer-list']/li[@data-value='${searchQuery}']
    Click    ${agent_confirm_login_button}
        
     