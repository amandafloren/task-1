*** Settings ***
Resource            ../../main/importer.robot
*** Test Cases ***

Get List of Items
    [Tags]    SmokeTest    PositiveCase    Bids
    GET List of Posts