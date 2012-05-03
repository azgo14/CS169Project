Given /the following messages exist/ do |messages_table|
  messages_table.hashes.each do |message|
    Message.create(message)
  end
end

And /I should see the message "(.*)" with "(.*)"/ do |subject, content|
  page.should have_selector(".message", :text => subject)
  page.should have_selector(".message", :text => content)
end
