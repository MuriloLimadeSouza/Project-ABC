extends Control

var possible_colors = [
	"#0098db", "#b5db00", "#FF0546", "#00db50", "#a100db"
]

func _ready():
	PlayerVars.load_game_data()
	if PlayerVars.player_data["number"] == possible_colors.size():
		PlayerVars.player_data["number"] = 0
	if PlayerVars.player_data["contrast"] == true:
		self.modulate = Color.black
		self.color = Color.black
	else:
		self.modulate = Color(possible_colors[PlayerVars.player_data["number"]])
		self.color = Color.white
