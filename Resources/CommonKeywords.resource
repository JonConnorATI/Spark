
*** Settings ***
Resource            all_resources.resource

*** Variables ***

*** Keywords ***


# Pass element locator as an arguement
# returns True if the element exists, else False
Does Element Exist
   [Documentation]
   [Arguments]  ${Element Locator}
   ${count}  Get element Count  ${Element Locator}
   ${isExists} =  Set variable if  ${count} == 1  ${True}  ${False}
   RETURN  ${isExists}


Element Should Exist
   [Documentation]
   [Arguments]  ${Element Locator}
   ${isExist}  Does Element Exist  ${Element Locator}
   run keyword if  not ${isExist}  Fail  ${Element Locator} IS NOT PRESENT

Element Should Not Exist
   [Documentation]
   [Arguments]  ${Element Locator}
   ${isExist}  Does Element Exist  ${Element Locator}
   run keyword if  ${isExist}  Fail  ${Element Locator} IS PRESENT


# Waits for an element to be Hidden within max 1m30s
Wait For Element To Be Hidden
    [Arguments]  ${locator}  ${time}=10s
    Wait For Elements State  ${locator}  hidden  timeout=${time}

# Waits for an element to be Visible within max 1m30s
Wait For Element To Be Visible
    [Arguments]  ${locator}  ${time}=10s
    Wait For Elements State  ${locator}  visible  timeout=${time}


JS Click
    [Documentation]  Custom KW: Use Javascript to click an element. Pass in the locator of the required element.
    ...              Waits a default time for the element.
    [Arguments]  ${locator}
    # Wait For Element To Be Visible    ${locator}
    Evaluate JavaScript  ${locator}  (elem) => elem.click()
    sleep  500ms



