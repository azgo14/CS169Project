Then /^I should see "([^"]*)" should be selected for "([^"]*)"$/ do |value, field|
  page.find_field(field).value.should =~ /^#{value}$/
end
