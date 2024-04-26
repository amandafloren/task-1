*** Settings ***
Resource            ../../main/importer.robot


*** Test Cases ***

POST Post
    [Tags]    SmokeTest    PositiveCase    Post
    POST Post    recommendation    motorcycle    12

POST with no value in payload
    [Tags]    SmokeTest    NegativeCase    Post
    POST Post Empty    value

POST with empty userId in payload
    [Tags]    SmokeTest    NegativeCase    Post
    POST Post Empty    userId

POST with empty body in payload
    [Tags]    SmokeTest    NegativeCase    Post
    POST Post Empty    body

POST with empty title in payload
    [Tags]    SmokeTest    NegativeCase    Post
    POST Post Empty    title

POST without payload body
    [Tags]    SmokeTest    NegativeCase    Post
    POST Post Empty    payload