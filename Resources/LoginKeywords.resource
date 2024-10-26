
*** Settings ***
Resource            all_resources.resource

*** Variables ***

*** Keywords ***


Create Browser Instance
    [Documentation]  Custom KW: Initiates a new browser with any settings specified.
    ${Browser Id} =  New Browser  ${browser}  headless=${headless}
    Set Global Variable  ${Browser Id}
    Set the users device  ${required_device}
    New Page

Set the users device
    [Documentation]  Custom KW: Gets the variable from the user settings and uses this variable to get the required
    ...              settings from the playwright device list hosted on github and import them to the framework.
    [Arguments]  ${device_to_use}
    IF    $required_device != "Default"
      ${device} =  Get Device  ${device_to_use}
      New context  &{device}
    END

Open the Website
    [Documentation]  Custom KW: Opens the default url
    [Arguments]  ${url}=${baseURL}
    Go to  ${url}

Open the browser and go to the website
    [Documentation]  Custom KW: Start the browser with user settings, open the website and clear pop ups
    Create Browser Instance
    Open the Website
    Select Cookies pop up  Deny

Select Cookies pop up
    [Documentation]  Custom KW: Click "Allow All" by default on the cookies pop up or pass in the locator/text
    ...              of an alernative option button
    [Arguments]  ${Option}=Allow All
    sleep  750ms
    ${isExist} =  Does Element Exist    text=${Option}
    IF    ${isExist} == ${True}
         JS Click  text=${Option}
    END

