extends HBoxContainer

var bar1 = 0
var bar2 = 0
var bar3 = 0
var bar4 = 0

var rng = [1,2,3,4,5,6,7,8,9,10]

var bar = preload("res://actividades/bars/bar.tscn")

var loops = 0

func _ready():
	randomize()
	roll()

var biggest = 0
var smallest = 0
var correct = 0

func roll():
	rng.shuffle()
	for child in get_children():
		child.queue_free()
	
	var loops = 4
	var bar_counts = [] 
	var created_bars = [] 

	for i in range(loops):
		var bar_instance = bar.instance()
		add_child(bar_instance)
		created_bars.append(bar_instance)
		bar_instance.connect("check", self, "bar_check")

	var available_values = [1, 2, 3, 4, 5, 6, 7, 8, 9]
	available_values.shuffle()

	for i in range(created_bars.size()):
		var child = created_bars[i]
		var unique_value = available_values[i]
		
		child.less(unique_value) 
		
		# Give the bar a tiny moment to finish freeing queued nodes
		yield(get_tree().create_timer(0.1), "timeout")
		
		# Read the ACTUAL remaining block count on the bar
		var actual_count = child.get_child_count()
		
		# Safety check: if it somehow went wrong, use the expected count
		if actual_count == 0:
			actual_count = unique_value
			
		bar_counts.append(actual_count)
		
		# Attach the real physical count as the metadata for the click check
		child.set_meta("bar_value", actual_count)

	# Keep your custom min/max configuration
	biggest = bar_counts.max()
	smallest = bar_counts.min()
	
	correct = [smallest, biggest][randi() % 2]
	
	if correct == smallest:
		$"../../RichTextLabel".bbcode_text = "selecione o menor número"
	else:
		$"../../RichTextLabel".bbcode_text = "selecione o maior número"

func bar_check(children, obj):
	var clicked_value = children
	if obj and obj.has_meta("bar_value"):
		clicked_value = obj.get_meta("bar_value")
	
	if clicked_value == correct:
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
		wrong_instance.current_exercise = "bars"
		add_child(wrong_instance)
		yield(get_tree().create_timer(1.0), "timeout")
		get_tree().change_scene("res://actividades/bars/bars_section.tscn")
	
	roll()
