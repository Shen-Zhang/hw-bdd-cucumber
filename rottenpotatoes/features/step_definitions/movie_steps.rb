# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create(movie)
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
end


# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  first = (/#{e1}/ =~ page.body)
  second = (/#{e2}/ =~ page.body)
  
  first.should <= second
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  
  ratings = rating_list.split(", ")
  
  ratings.each do |nextRating|
    if(uncheck == 'un')
      uncheck("ratings_" + nextRating)
    else
      check("ratings_" + nextRating)
    end
  end
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  #fail "Unimplemented"
end

Then /I should see all the movies/ do
  #We add one because it counts the header row (which is not a movie)
  expected = Movie.count + 1
  page.should have_css("table#movies tr", :count=>expected)
  
  # Make sure that all the movies in the app are visible in the table
end
