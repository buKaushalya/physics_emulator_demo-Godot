extends Control
@onready var panel: Panel = $Panel
@onready var panel_f_1: Panel = $Panel/PanelF1
@onready var panel_f_2: Panel = $Panel/PanelF2
@onready var panel_f_3: Panel = $Panel/PanelF3
@onready var txt_distance: TextEdit = $MainPanel/Distance/TxtDistance
@onready var main_panel: Control = $MainPanel
@onready var car: RigidBody3D = $"../Car"

@onready var point_system: Panel = $"Panel"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_btn_help_pressed() -> void:
	panel.visible = true
	main_panel.visible = false

func _on_btn_close_pressed() -> void:
	panel.visible = false
	main_panel.visible = true

func _on_btn_fromula_1_pressed() -> void:
	point_system.call("check_formula", str("Formula1"))
	panel_f_1.visible = true

func _on_btn_fromula_2_pressed() -> void:
	point_system.call("check_formula", str("Formula2"))
	panel_f_2.visible = true
	
func _on_btn_fromula_3_pressed() -> void:
	point_system.call("check_formula", str("Formula3"))
	panel_f_3.visible = true

func _on_btn_start_pressed() -> void:
	main_panel.visible = false
	car.call("_start_accelerating", float(txt_distance.text))


func _on_btn_re_start_pressed() -> void:
	GameManager.resume_game()
	get_tree().reload_current_scene()

func _on_btn_next_level_pressed() -> void:
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://level_2.tscn")
