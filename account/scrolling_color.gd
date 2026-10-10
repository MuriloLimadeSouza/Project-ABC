extends CanvasLayer

func _ready():
	if PlayerVars.player_data["colorblind"] == true:
		self.module = "#FF0546"
	else:
		self.module = "#0098DB"
