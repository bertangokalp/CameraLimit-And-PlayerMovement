extends Node

var data
var current_level



func save_game():
	data = {
		"current_level"          : current_level,
	}
	
	var file = File.new()
	file.open("Kullanıcılar://save.json", File.WRITE)
	var json = to_json(data)
	file.store_string(json)
	file.close()

func load_game():
	pass
