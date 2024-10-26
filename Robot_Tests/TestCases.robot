*** Settings ***
Documentation       Describe this suite of test cases

Resource        ../Resources/all_resources.resource

Suite Setup  Open the browser and go to the website
Suite Teardown  Close Browser

*** Variables ***

${SCREENSHOT_DIR}  ./screenshots/${required_device}  # Folder to save screenshots
${SCROLL_STEP}  500
# @{NAVIGATION_ITEMS}  Blog
${Exception}  Blog
@{NAVIGATION_ITEMS}  Home  About Us  Our People  Our Culture  Careers  Our Services  Enterprise Data  Artificial Intelligence  Software Delivery  How We Engage  Our Customers & Case Studies  Why Work With Us  Blog

*** Tasks ***
 
Take screenshots of the users viewport for all pages on the website
    [Documentation]  Opens the web page and using the navigation flyout, visits each page
    ...              and takes rolling screenshots
    [Tags]  Display


    # Empty the directory at the start of each run
    Create Directory   ${SCREENSHOT_DIR}
    Empty Directory    ${SCREENSHOT_DIR}

    # Open the Navigation menu
    JS Click  ${Nav_Burger_Menu}
    Take Screenshot  ${SCREENSHOT_DIR}/screenshot_nav.png

    #Hide the overlay in .nav-overlay {display:none}
    #Evaluate JavaScript    .nav-overlay.active    (elem) => elem.display = "none"


    # Get all the ul/li Items
    # ${Nav} =  Get Elements   nav.nav-main.active span.label   # xpath=//*[@class='nav-main active']//span[@class='label']

    # WClick    //*[@class='nav-main active']//a//span[text()="Our Services."]


    FOR    ${element}    IN    @{NAVIGATION_ITEMS}
        #Get Value From User    Are You in  Yes

        IF    $element == "Home"
            JS Click    //button[@aria-label="Menu Toggle - Close"]
        ELSE
            JS Click    //*[@class='nav-main active']//a//span[contains(text(),"${element}")]
        END


        IF    $element == "Blog"
            sleep  2s
            Select Cookies pop up
        END
        ${scroll_height} =  Get Scroll Size  //body
        ${height} =  Get From Dictionary    ${scroll_height}    height
        ${current_position} =  Set Variable  0
                  FOR    ${i}    IN RANGE    0    ${height}    ${SCROLL_STEP}
                    Scroll To    ${None}  ${current_position}  behavior=smooth
                    sleep  500ms
                    Take Screenshot    ${SCREENSHOT_DIR}/${element}_screenshot_${i}.png
                    ${current_position} =  Evaluate  ${current_position} + ${SCROLL_STEP}
                  END





        # Evaluate JavaScript    .nav-overlay.active    (elem) => elem.display = "none"

        JS Click  //button[@aria-label="Menu Toggle - Open"]
        Sleep  500ms
    END

  
*** Keywords ***





