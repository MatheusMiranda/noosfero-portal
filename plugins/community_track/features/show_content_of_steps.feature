Feature: accept member
  As a user
  I want to see the content of steps

  Background:
    Given the following users
      | login      | name        |
			| joaosilva  | Joao Silva  |
		And plugin CommunityTrack is enabled on environment
    And the following community
      | owner     | identifier  | name         |
      | joaosilva | mycommunity | My Community |
    And the following blocks
      | owner       | type                                 |
      | mycommunity | CommunityTrackPlugin::TrackListBlock |
    And the following categories
      | name | display_in_menu |
      | food | true            |
    And the following tracks
      | profile     | title          | category |
      | mycommunity | noosfero track | food     |
		And the following articles
	    | owner     | name                     | body                | category  | homepage | profile     | author    |
		  | joaosilva | Article of noosfero step | This is an article  | Temáticas | true     | mycommunity | joaosilva |
    And the following steps
      | profile     | title         | parent         | children                 | tool_type      |
			| mycommunity | noosfero step | noosfero track | Article of noosfero step | TextileArticle |
 		Given I am logged in as admin
 		And I go to mycommunity's homepage
 		And I go to mycommunity's control panel
 		And I follow "Edit sideboxes"
 		And I hover over ".track_list"
		And I follow "Edit" within ".community-track-plugin_track-list-block"
		And I check "Show more at another page"

	@selenium
  Scenario: enable visualization of steps content
  And I check "Show content of steps"
	And I press "Save"
	And I follow "Back to control panel"
	Given I click on anything with selector "track-cards-steps-url"
	Then I should see "Article of noosfero step" within ".track-cards-content"

	@selenium
  Scenario: disable visualization of steps content
	And I press "Save"
	And I follow "Back to control panel"
	Given I click on anything with selector "track-cards-steps-url" 
	Then I should see "Article of noosfero step" within ".main-content"
	
