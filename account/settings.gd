extends Control

var occupation = ""

func _ready():
	$LineEdit.text = PlayerVars.player_data["player_name"]
	
	match PlayerVars.player_data["teacher"]:
		true:
			occupation = "Professor"
		false:
			occupation = "Aluno"
	
	$RichTextLabel2.bbcode_text = "[wave]Nome: \n\nOcupação:\n" + str(occupation) + " \n\nPontuação Máxima:\n" + str(PlayerVars.player_data["max_points"])

func _on_Button_pressed():
	PlayerVars.player_data["player_name"] = $LineEdit.text
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
	"colorblind": false
}
	PlayerVars.save_game_data()
	get_tree().change_scene("res://lan/inicial_screen.tscn")

func _on_Button4_pressed():
	if OS.has_feature("HTML5"):
		JavaScript.eval("window.open('https://github.com/MuriloLimadeSouza/Project-ABC')")
	else:
		OS.shell_open("https://github.com/MuriloLimadeSouza/Project-ABC")

func _on_Button5_pressed():
	match PlayerVars.player_data["colorblind"]:
		false:
			PlayerVars.player_data["colorblind"] = true
		true:
			PlayerVars.player_data["colorblind"] = false
	PlayerVars.save_game_data()
	get_tree().change_scene("res://lan/inicial_screen.tscn")

