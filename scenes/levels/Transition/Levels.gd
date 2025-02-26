extends Node

var Firsttime = true
var Level1_1 = false
var Level1_2 = false
var Level1_3 = false
var Level2_1 = false
var Level3_1 = false
var Level3_2 = false
var Level3_3 = false
var Level4_1 = false
var Level4_2 = false
var Level4_3 = false
var Level5_1 = false
var Level5_2 = false
var Level5_3 = false
var Level6_66 = false
var save_dict : Dictionary


func setter(variabletoset : String, value ):
	var temp = get(variabletoset)
	temp = value
	set(variabletoset, temp)
	print("Setting ", variabletoset, " to: ", value)

func save():
	save_dict = {
		"Firsttime" : Firsttime,
		"Level1_1" : Level1_1,
		"Level1_2" : Level1_2,
		"Level1_3" : Level1_3,
		"Level2_1" : Level2_1,
		"Level3_1" : Level3_1,
		"Level3_2" : Level3_2,
		"Level3_3" : Level3_3,
		"Level4_1" : Level4_1,
		"Level4_2" : Level4_2,
		"Level4_3" : Level4_3,
		"Level5_1" : Level5_1,
		"Level5_2" : Level5_2,
		"Level5_3" : Level5_3,
		"Level6_66" : Level6_66
	}
	return save_dict

func reset_progress():
	var savefile = save()
	for i in savefile:
		set(i, false)
	save_game()

func save_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var data = save()
	var json_string = JSON.stringify(data)
	save_file.store_line(json_string)
	print(save_file)
	

func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.


	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	print(save_file)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()

		# Creates the helper class to interact with JSON.
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure.
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object.
		var node_data = json.data

		# Firstly, we need to create the object and add it to the tree and set its position.
	
		# Now we set the remaining variables.
		for i in node_data.keys():
			set(i, node_data[i])
