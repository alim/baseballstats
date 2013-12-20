# Baseball Stats Application Home/Main Page

Feature: In order to navigate the Baseball Statistics Application
  As a public user
  I want to be able to manage batting statistics, player demographic 
  information and search for players with certain statistics.
  
@home_steps
Scenario: Show home page with introduciton
  Given you navigate to the home url
  Then you should see a Welcome in the title

@home_steps
Scenario: Show home page with navigation bar
  Given you navigate to the home url
  Then you should see a navigation bar

@home_steps
Scenario: Navigate to Fantasy points
  Given you navigate to the home url
  And you click on the Fantasy link
  Then you should see the "Fantasy Points" page

Scenario: Navigate to Batting Statistics page

Scenario: Navigate to Players page
