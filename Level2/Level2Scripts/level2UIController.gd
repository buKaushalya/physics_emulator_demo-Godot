extends Control
@onready var main_panel: Control = $MainPanel
@onready var lbl_bp:OptionButton = $"MainPanel/Distance/OptionButton"
@onready var panel: Control = $"../Control"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_panel.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_restart_pressed() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()

func _on_btn_help_pressed() -> void:
	panel.visible = true
	main_panel.visible = false
