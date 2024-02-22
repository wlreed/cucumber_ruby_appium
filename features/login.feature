@login
Feature: login

    @log-001 @click_back
    Scenario: Login to app
        Given I click login on home screen
        And I enter valid username and password
        Then I should see that I am logged in with username
