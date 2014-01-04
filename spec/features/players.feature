# Player Record features

Feature: In order to use player records
  As a public user
  I want to be able to upload, create, edit, and destroy player records
  
@player_steps
Scenario: See the player records page
  Given you navigate to the players page
  And there are player records
  Then you should see the "Baseball Players" page

@player_steps
Scenario: Upload a CSV file
  Given you navigate to the players page
  And you fill in file with "spec/data/player_test.csv"
  And you click on the "Import" link
  Then you should see the "Baseball Players" page
  And you should see a "Success!" message
