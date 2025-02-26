extends Node3D

@export var speed : float = 2.0
@onready var anim_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim_player.play("NlaTrack_002") # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direction = Vector3.FORWARD  # Move forward (Z direction)
	speed = direction * speed  
	
