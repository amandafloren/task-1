*** Settings ***
Resource            importer.robot
Library             Collections


*** Variables ***
${uri_item}             /posts

*** Keywords ***
GET List of Posts
    [Arguments]
    Create Session            get_posts                    ${base_url_typicode}                  verify=True
    ${headers}=               Create Dictionary            Content-Type=application/json
    ${resp}=                  GET On Session               get_posts                             ${uri_item}         headers=${headers}
    ${schema}                 Get Binary File              ./tests/api-robot/main/schema/item-posts-schema.json  
    ${schema}                 Evaluate                     json.loads('''${schema}''')           json  
    ${status_code}=           Convert To String            ${resp.status_code}
    Should Be Equal           ${status_code}               200
    Validate                  instance=${resp.json()}      schema=${schema}

POST Post
    [Arguments]               ${ARG_title}                ${ARG_body}                            ${ARG_userId}
    Create Session            post_post                    ${base_url_typicode}                 verify=True
    ${headers}=               Create Dictionary            Content-Type=application/json


    ${resp}=                  POST On Session              post_post                            ${uri_item}        headers=${headers}        json=${post_data}                    expected_status=anything
    ${post_userId}=           Get From Dictionary          ${resp.json()}    userId   default
    ${post_title}=            Get From Dictionary          ${resp.json()}    title    default
    ${post_body}=             Get From Dictionary          ${resp.json()}    body     default
    ${status_code}=           Convert To String            ${resp.status_code}
    Should Be Equal           ${status_code}               201

    Should Be Equal    ${ARG_title}     ${post_title}
    Should Be Equal    ${ARG_body}      ${post_body}
    Should Be Equal    ${ARG_userId}    ${post_userId}

POST Post Empty
    [Arguments]               ${ARG_TEST_TYPE}
    Create Session            post_post                    ${base_url_typicode}                  verify=True
    ${headers}=               Create Dictionary            Content-Type=application/json

    IF    $ARG_TEST_TYPE == 'Success'
        ${resp}=                  POST On Session              post_post                            ${uri_item}        headers=${headers}        json=${post_data}                    expected_status=anything
    ELSE IF    $ARG_TEST_TYPE == 'value'
        ${resp}=                  POST On Session              post_post                            ${uri_item}        headers=${headers}        json=${post_data_empty_value}        expected_status=anything
    ELSE IF    $ARG_TEST_TYPE == 'userId'
        ${resp}=                  POST On Session              post_post                            ${uri_item}        headers=${headers}        json=${post_data_empty_userId}       expected_status=anything
    ELSE IF    $ARG_TEST_TYPE == 'body'
        ${resp}=                  POST On Session              post_post                            ${uri_item}        headers=${headers}        json=${post_data_empty_body}         expected_status=anything
    ELSE IF    $ARG_TEST_TYPE == 'title'
        ${resp}=                  POST On Session              post_post                            ${uri_item}        headers=${headers}        json=${post_data_empty_title}        expected_status=anything
    ELSE IF    $ARG_TEST_TYPE == 'payload'
        ${resp}=                  POST On Session              post_post                            ${uri_item}        headers=${headers}        expected_status=anything
    END
    ${status_code}=           Convert To String            ${resp.status_code}
    Should Be Equal           ${status_code}               201