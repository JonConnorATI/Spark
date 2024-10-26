# Add all files needed for your framework. They do not need to be called in tests or keywords as this file makes
# as will be globally available in the framework

*** Settings ***
Variables  user01.py
Variables  ../PageObjects/locators-common.py


Library  String
Library  Collections
Library  DateTime
Library  Browser  auto_closing_level=MANUAL
Library  OperatingSystem
Library  RequestsLibrary


Resource  CommonKeywords.resource
Resource  LoginKeywords.resource

