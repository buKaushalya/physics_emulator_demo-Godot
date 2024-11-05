extends Node3D

@onready var car_camera: Camera3D = $Car/CarCamera

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Engine.time_scale = 1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
