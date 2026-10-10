extends Control

func _ready():
	randomize()
	roll()

var correct = 0

func roll():
	var hour = int(rand_range(13,23))
	var minutes = int(rand_range(0,59))
	if minutes <= 10:
		minutes = str("0" + str(minutes))
	correct = hour-12
	$RichTextLabel.bbcode_text = "[wave] [center]" + str(hour) + ":" + str(minutes)

func _on_Button_pressed():
	if int($LineEdit.text) == correct:
		var right = preload("res://right.tscn")
		$Control2.get_points(int(rand_range(1000, 1500)))
		var right_instance = right.instance()
		add_child(right_instance)
		
		yield(get_tree().create_timer(1.0), "timeout")
		emit_signal("task_completed")
	else:
		var wrong = preload("res://wrong.tscn")
		$Control2.get_points(int(rand_range(-750, -500)))
		var wrong_instance = wrong.instance()
		wrong_instance.current_exercise = "time"
		add_child(wrong_instance)
		yield(get_tree().create_timer(1.0), "timeout")
		get_tree().change_scene("res://actividades/time/time.tscn")
