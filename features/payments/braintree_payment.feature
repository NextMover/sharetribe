Feature: User pays accepted request

  Background:
    Given there are following users:
      | person |
      | kassi_testperson1 |
      | kassi_testperson2 |
    And there are following Braintree accounts:
      | person            | status | community |
      | kassi_testperson1 | active | test      |
    And community "test" has payments in use via BraintreePaymentGateway
    And Braintree transaction is mocked
    And there is a listing with title "math book" from "kassi_testperson1" with category "Items" and with transaction type "Selling"
    And the price of that listing is "12"
    And there is an accepted request for "math book" with price "101" from "kassi_testperson2"

  @javascript
  Scenario: User pays accepted request
    Given I am logged in as "kassi_testperson2"
    And I want to pay "math book"
    When I fill in my payment details for Braintree
    And I press submit
    Then I should be see that the payment was successful
    Then "kassi_testperson1" should receive email about payment