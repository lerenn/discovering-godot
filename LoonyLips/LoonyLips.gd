extends Control

var player_words = []
var current_story = {}

onready var PlayerText = $VBoxContainer/HBoxContainer/PlayerText
onready var DisplayText = $VBoxContainer/DisplayText
onready var ButtonLabel = $VBoxContainer/HBoxContainer/Label

func _ready():
	set_current_story()
	DisplayText.text = """Welcome to Loony Lips! We're going to tell a story and
		have a wonderful time!"""
	check_player_words_length()

func set_current_story():
	randomize()
	
#	var stories = get_from_json("StoryBook.json")
#	current_story = stories[randi() % stories.size()]
	
	var stories = $StoryBook.get_child_count()
	var selected_story = randi() % stories
	current_story = $StoryBook.get_child(selected_story)

func get_from_json(filename):
	var file = File.new()
	file.open(filename, File.READ)
	var text = file.get_as_text()
	var data = parse_json(text)
	file.close()
	return data

func _on_PlayerText_text_entered(_new_text):
	add_to_player_words()

func _on_TextureButton_pressed():
	if is_story_done():
		# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()
	else:
		add_to_player_words()

func add_to_player_words():
	player_words.append(PlayerText.text)
	PlayerText.clear()
	DisplayText.text = ""
	check_player_words_length()

func is_story_done():
	return player_words.size() == current_story.prompts.size()

func check_player_words_length():
	if is_story_done():
		end_game()
	else:
		prompt_player()
		
func tell_story():
	DisplayText.text = current_story.story % player_words

func prompt_player():
	var position = player_words.size()
	DisplayText.text += " May I have %s ?" % current_story.prompts[position]

func end_game():
	PlayerText.queue_free()
	ButtonLabel.text = "Again!"
	tell_story()
