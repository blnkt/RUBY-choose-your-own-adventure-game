require './lib/chapter'
require './lib/adventure'	
require './lib/adventurer' 


def welcome
	puts "Welcome to the adventure.\n\nWhat's your name?"
	name = gets.chomp
	user_adventure = Adventure.new({name: name})
	prologue = Chapter.new({id: "0", prompt: "#{name}'s Adventure", :episode => "You awake in a field.  You're clear headed but you remember nothing.  Gaping about, you discover a bicycle, a set of keys, and a baseball hat.", name: "blnkt"})
  user_adventure.add_chapter(0)
  prologue.add_choice("Walk the bike out of the field to a nearby road", user_adventure.id)
  user_adventure.add_chapter(1)
  prologue.add_choice("pick up the keys and walk to the road", user_adventure.id)
  user_adventure.add_chapter(2)
  prologue.add_choice("Put on the hat and head towards the sound of water", user_adventure.id)
  user_adventure.add_chapter(3)
  menu(0, user_adventure.id)
end


def menu(chapter_id, adventure_id)
  clear_screen
  chapter = Chapter.find_by_id(chapter_id)
  puts chapter.prompt
  linebreak
  puts chapter.episode 
  linebreak
  chapter.choices.each do |choice|
  puts Chapter.find_by_id(choice).id.to_s + ": " + Chapter.find_by_id(choice).prompt
  linebreak
  end
  puts "Enter 'choice number' to proceed"
  puts "Enter 'ac' to add an additional choice"
  puts "Enter '<' to turn back"
  puts "Enter 'x' to leave the adventure"
  choice_id = gets.chomp
  if choice_id == 'x'
    exit
  elsif choice_id == 'ac'
    puts "Enter a new choice for this chapter:"
    choice_text = gets.chomp
    chapter.add_choice(choice_text, adventure_id)
  elsif choice_id == 'ae'
    puts "Enter an episode for this chapter:"
    episode = gets.chomp
	  chapter.add_episode(episode)
    puts chapter.id
  elsif Chapter.find_by_id(choice_id) != nil
    Adventure.find_by_id(adventure_id).add_chapter(choice_id)
    menu(choice_id, adventure_id)
	else
	  menu(chapter.id, adventure_id)
  end
  puts chapter.episode
  menu(chapter.id, adventure_id)
end 

def clear_screen
  puts "\e[H\e[2J"
end

def linebreak
	puts "\n"
end

# menu
welcome