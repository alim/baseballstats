# Batting Statistics features

Feature: In order to use batting statistics
  As a public user
  I want to be able to upload, create, edit, and destroy batting statistics
  
@batting_steps
Scenario: See batting statistics
  Given you navigate to the batting statistics page
  And there are batting statistics
  Then you should see the "Batting Statistics" page

@batting_steps
Scenario: Upload a CSV file
  Given you navigate to the batting statistics page
  And you fill in file with "spec/data/batting_stats_test.csv"
  And you click on the "Import" link
  Then you should see the "Batting Statistics" page
  And you should see a "Success!" message
