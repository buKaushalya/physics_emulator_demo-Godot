extends CharacterBody3D

@export var speed : float = 2.0
@onready var anim_player = $"AnimationPlayer"

var blood_decal = preload("res://scenes/blood_decal.tscn")
var blood_fx = preload("res://scenes/blood_effect.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim_player.play("NlaTrack_001") 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direction = Vector3.BACK  # Move forward (Z direction)
	velocity = direction * speed  
	move_and_slide()

func spawn_blood():
	var dec = blood_decal.instantiate()
	var part = blood_fx.instantiate()
	
	get_tree().current_scene.add_child(dec)
	get_tree().current_scene.add_child(part)
	
	dec.global_transform.origin = $blood_spawn.global_transform.origin
	part.global_transform.origin = $blood_fx_spawn.global_transform.origin
	



func _on_area_3d_area_entered(area: Area3D) -> void:
	spawn_blood() # Replace with function body.
