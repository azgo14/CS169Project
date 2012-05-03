Given /the following messages exist/ do |messages_table|
  messages_table.hashes.each do |message|
    Message.create(message)
  end
end

And /I should see the message "(.*)"/ do |subject|
  page.should have_selector(".message", :text => subject)
end

And /I should not see the message "(.*)"/ do |subject|
  page.should_not have_selector(".message", :text => subject)
end
