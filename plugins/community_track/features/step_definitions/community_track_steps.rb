Given(/^the following tracks$/) do |table|
  table.hashes.each do |row|
    profile = row.delete("profile")
    title = row.delete("title")
    category = row.delete("category")

    community_track = CommunityTrackPlugin::Track.new
    community_track.name = title
    community_track.profile = Profile.find_by_identifier(profile)
    community_track.categories << Category.find_by_name(category)
    community_track.save!
  end
end

Given(/^the following steps$/) do |table|
  table.hashes.each do |row|
    profile = row.delete("profile")
    title = row.delete("title")
    parent = row.delete("parent")
		children = row.delete("children")
		tool_type = row.delete("tool_type")
	
    community_track_step = CommunityTrackPlugin::Step.new
    community_track_step.name = title
    community_track_step.profile = Profile.find_by_identifier(profile)
    community_track_step.parent = CommunityTrackPlugin::Track.find_by_name(parent)
		community_track_step.children << Article.find_by_name(children)
   	community_track_step.tool_type = tool_type
	 	community_track_step.save!
		end
end

Given /^I click on anything with selector "([^"]*)"$/ do |selector|
  page.evaluate_script("jQuery('.#{selector}').click();")
end

Given(/^I hover over "([^"]*)"$/) do |arg|
	el = find(arg)
	page.driver.browser.action.move_to(el.native).perform
	page.execute_script "window.scrollBy(0, $(window).height())"
end

