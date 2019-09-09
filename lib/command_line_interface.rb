def welcome
  puts "Welcome to the Star Wars archives!"
end

def get_character_from_user
  puts "Which character would you like to learn about today? Enter quit to exit."
  # use gets to capture the user's input. This method should return that input, downcased.
  gets.chomp.downcase
end
