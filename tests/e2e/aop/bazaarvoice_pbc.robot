*** Settings ***
Suite Setup       SuiteSetup
Test Setup        TestSetup
Test Teardown     TestTeardown
Suite Teardown    SuiteTeardown
Resource    ../../../resources/common/common.robot
Resource    ../../../resources/common/common_yves.robot
Resource    ../../../resources/common/common_zed.robot
Resource    ../../../resources/steps/aop_catalog_steps.robot
Resource    ../../../resources/steps/bazaarvoice_steps.robot
Resource    ../../../resources/steps/bazaarvoice_steps.robot
Resource    ../../../resources/steps/pdp_steps.robot

*** Test Cases ***
Bazzarvoice_E2E
    [Documentation]    Checks that bazzarvoice pbc can be connected in the backoffice and is reflected to the storefront
    [Setup]    Zed: login on Zed with provided credentials:    ${zed_admin_email}
    Zed: go to first navigation item level:    Apps
    Zed: AOP catalog page should contain the following apps:    Payone    BazaarVoice
    Zed: go to the PBC details page:    BazaarVoice
    Zed: PBC details page should contain the following elements:    ${appTitle}    ${appShortDescription}    ${appAuthor}   ${appLogo}
    Zed: click button on the PBC details page:    connect
    Zed: PBC details page should contain the following elements:    ${appPendingStatus}
    Zed: click button on the PBC details page:    configure
    Zed: configure bazaarvoice pbc with the following data:
    ...    || clientName      | siteId    | environment | services                                                                              | stores ||
    ...    || partner-spryker | main_site | Staging     | Ratings & Reviews,Questions & Answers,Inline Ratings,Bazaarvoice Pixel,Container Page | EN,DE  ||
    Zed: submit pbc configuration form
    Zed: PBC details page should contain the following elements:    ${appConnectedStatus}
    Yves: go to the 'Home' page
    Yves: go to PDP of the product with sku:    150
    Yves: page should contain the following script:    bazaar-voice
    Yves: PDP contains/doesn't contain:    ${bazaarvoiceWriteReview}
    Yves: post bazaarvoice review with the following data:
    ...    || overallRating | reviewTitle            | review                                               | recommendProduct | nickname        | location | email                       | age      | gender | qualityRating | valueRating ||
    ...    || 5             | Robot Review ${random} | I bought this a month ago and am so happy that I did | yes              | Robot ${random} | New York | sonia+${random}@spryker.com | 25 to 34 | Female | 5             | 1           ||
    [Teardown]    Run Keywords    Zed: login on Zed with provided credentials:    ${zed_admin_email}
    ...    AND    Zed: go to first navigation item level:    Apps
    ...    AND    Zed: go to the PBC details page:    BazaarVoice
    ...    AND    Zed: Disconnect pbc

    # BV ratings & Reviews is displayed
    # BV questions & Answers is displayed (could be checked in elements)
    # BV inline Ratings is displayed 