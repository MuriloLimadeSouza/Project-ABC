extends Control

var occupation = ""

func _ready():
	$ScrollContainer/VBoxContainer/HBoxContainer/LineEdit.text = PlayerVars.player_data["player_name"]
	
	match PlayerVars.player_data["teacher"]:
		true:
			occupation = "Professor"
		false:
			occupation = "Aluno"
	
	$ScrollContainer/VBoxContainer/HBoxContainer2/RichTextLabel4.bbcode_text = "[wave]Ocupação:" + str(occupation)
	$ScrollContainer/VBoxContainer/RichTextLabel5.bbcode_text = "Pontuação Máxima:" + "[rainbow] " + str(PlayerVars.player_data["max_points"])

func _on_Button_pressed():
	PlayerVars.player_data["player_name"] = $ScrollContainer/VBoxContainer/HBoxContainer/LineEdit.text
	PlayerVars.save_game_data()
	get_tree().change_scene("res://account/account_main_scene.tscn")

func _on_Button2_pressed():
	match PlayerVars.player_data["teacher"]:
		true:
			PlayerVars.player_data["teacher"] = false
			PlayerVars.save_game_data()
		false:
			PlayerVars.player_data["teacher"] = true
			PlayerVars.save_game_data()
	get_tree().change_scene("res://account/settings.tscn")


func _on_Button3_pressed():
	PlayerVars.player_data = {
	"first_time": true,
	"player_name": "",
	"max_points": 0,
	"teacher": false,
	"number": 1,
	"reversed": false
}
	PlayerVars.save_game_data()
	get_tree().change_scene("res://lan/inicial_screen.tscn")

func _on_Button4_pressed():
	if OS.has_feature("HTML5"):
		JavaScript.eval("window.open('https://github.com/MuriloLimadeSouza/Project-ABC')")
	else:
		OS.shell_open("https://github.com/MuriloLimadeSouza/Project-ABC")

func _on_Button5_pressed():
	PlayerVars.player_data["number"] += 1
	PlayerVars.save_game_data()
	get_tree().change_scene("res://account/settings.tscn")

func _on_Button6_pressed():
	if OS.has_feature("HTML5"):
		JavaScript.eval("window.open('https://www.instagram.com/abcsimpesedu?cplk=NTFjY2lrMTBnMTg2')")
	else:
		OS.shell_open("https://www.instagram.com/abcsimpesedu?cplk=NTFjY2lrMTBnMTg2")

var texts = ["desativar tela cheia", "ativar tela cheia"]

func _on_Button9_pressed():
	texts.invert()
	$ScrollContainer/VBoxContainer/RichTextLabel6/Button9.text = texts[1]
	if $ScrollContainer/VBoxContainer/RichTextLabel6/Button9.text == "desativar tela cheia":
		OS.window_fullscreen = true
	else:
		OS.window_fullscreen = false
