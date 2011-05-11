Given /^I have the tags "([^"]*)"$/ do |tags|
  tags.split(', ').each do |tag_name|
    @tags = Tag.create!(:name => tag_name, :user => current_user)
  end
end

Then /^the tag should be successfully created$/ do
  page.should have_content 'Tag was successfully created.'
end
