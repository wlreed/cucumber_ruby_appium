@echo
Feature: echo

    @echo-001 @click_back
    Scenario: Echo a string
        Given I click echo_box on home screen
        And I enter some text
        Then I should see that same text saved
