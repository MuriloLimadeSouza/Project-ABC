extends Control

func _ready():
	match PlayerVars.player_data["teacher"]:
		true:
			$Button.text = "+ clique aqui\n pra criar\n uma sala"
		false:
			$Button.text = "clique aqui\n para entrar\n numa sala"
	if PlayerVars.player_data["player_name"].empty():
		PlayerVars.player_data["player_name"] == "visitante"
		PlayerVars.save_game_data()
	if OS.has_feature("HTML5"):
		PlayerVars.player_data["player_name"] == "visitante"
		$Button3.hide()
		PlayerVars.save_game_data()
	PlayerVars.load_game_data()
	$RichTextLabel4.bbcode_text = "[center][wave]bem vindo\n" + PlayerVars.player_data["player_name"] + "!!"
	if OS.has_feature("HTML5"):
		$RichTextLabel4.bbcode_text = "[center][wave]bem vindo\n" + "visitante" + "!!"
	
	print(PlayerVars.player_data["player_name"])
func _on_TextureButton_pressed():
	get_tree().change_scene("res://account/settings.tscn")

func _on_Button_pressed():
	get_tree().change_scene("res://lan/question_selection.tscn")

	match PlayerVars.player_data["teacher"]:
		true:
			get_tree().change_scene("res://lan/question_selection.tscn")
		false:
			get_tree().change_scene("res://lan/puppet_screen.tscn")

func _on_Button3_pressed():
	get_tree().quit()

func _on_Button2_pressed():
	Save.solo_run = 1
	Save.mistakes.clear()
	
	Lan.current_lecture.clear()
	
	var QUESTIONS_PER_SUBJECT = 1
	
	var solo_lecture = {}
	for subject in ALL_SUBJECTS:
		solo_lecture[subject] = QUESTIONS_PER_SUBJECT

	# 5. Salva a nova lição gerada no Save global
	Save.lectures = solo_lecture
	
	# 6. Troca direto para o Gerenciador de Lições sem requisição de IP/Rede
	get_tree().change_scene("res://lan/lecture_manager.tscn")
# Lista com todas as atividades disponíveis no seu projeto

const ALL_SUBJECTS = [
	"Addition and subtraction",
	"Times and division",
	"conversion",
	"times",
	"problems",
	"spacial_geometry",
	"drawing",
	"time",
	"division_in_equal_parts",
	"rec_letras",
	"juntar_letras",
	"interpretacao",
	"escrita_correta",
	"generos",
	"maiuscula_minus",
	"pontuacao",
	"acentos",
	"singular_plural",
	"genero_gramatical",
	"verbos",
	"substantivos",
	"analise_ling"
]

func _on_TextureButton_mouse_entered():
	$TextureButton.modulate = Color.darkcyan

func _on_TextureButton_mouse_exited():
	$TextureButton.modulate = Color.white
