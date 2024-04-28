*** Settings ***
Resource            keyword_API.robot

Library             RequestsLibrary
Library             Collections
Library             OperatingSystem
Library             String
Library             Process
Library             jsonschema
Library             JSONLibrary

Variables           env.py
Variables           ../test_cases/typicode_data.py