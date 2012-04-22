Given /the following comments exist/ do |comments_table|
  comments_table.hashes.each do |comment|
    Comment.create(comment)
  end
end

And /I accept comment ([0-9]*)/ do |id|
  step %{I press "#{id}_accept"}
end

And /I reject comment ([0-9]*)/ do |id|
  step %{I press "#{id}_reject"}
end

And /I should see "(.*)" under "(.*)"/ do |comment, status|
  status = status.downcase
  page.should have_selector("##{status}", :text => comment)
end

And /I should not see "(.*)" under "(.*)"/ do |comment, status|
  status = status.downcase
  page.should_not have_selector("##{status}", :text => comment)
end

And /I should see the comment "(.*)"/ do |comment|
  page.should have_selector(".comment", :text => comment)
end

And /I should not see the comment "(.*)"/ do |comment|
  page.should_not have_selector(".comment", :text => comment)
end
