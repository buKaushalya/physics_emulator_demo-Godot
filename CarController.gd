extends RigidBody3D

var velocityLimitReached = false
var acceleration = 10.1;
var isAccelerating = false
var seconds = 0
var forceAdded = false
var velocity = 0.0
var distance = 0.0

@onready var plane: MeshInstance3D = $"../Plane"
@onready var start_point: MeshInstance3D = $"../StartPoint"
@onready var car: RigidBody3D = $"."
@onready var car_camera: Camera3D = $CarCamera
@onready var fire: GPUParticles3D = $Fire

@onready var lbl_success: Label = $"../Control/LblSuccess"
@onready var lbl_fail: Label = $"../Control/LblFail"
@onready var lbl_speed: Label = $"../Control/LblSpeedTag/LblSpeed"
@onready var txt_distance: TextEdit = $"../Control/MainPanel/Distance/TxtDistance"
@onready var btn_re_start: Button = $"../Control/BtnReStart"

@onready var timer: Timer = $"../Timer"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = 1.0  # Delay of 2 seconds
	timer.connect("timeout", _wreck_car)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_get_velocity()
	_add_force(delta)

func _get_velocity() -> void:
	var v1 = -linear_velocity.x
	var v2 = floor(v1 * 100) / 100
	velocity = 15 if distance == 11.25 and v2 > 14.8 else v2
	lbl_speed.text = str(velocity) + "ms"

func _start_accelerating(d: float) -> void:
	distance = d # here 2 is cars diviation from vector zero
	if d - 2 > 0:
		position.x += d - 2
	isAccelerating = true
	car_camera.make_current()

func _add_force(delta: float) -> void:
	if isAccelerating:
		var force = -Vector3.RIGHT * acceleration * mass
		apply_central_force(force)
		if !forceAdded:
			seconds = 0
			forceAdded = true
		else :
			seconds += delta

func _on_area_3d_area_entered(area: Area3D) -> void:
	print(area.name)
	var v = -linear_velocity.x
	var v1 = floor(v * 100) / 100
	
	print("Velocity: ", v1)
	print("Seconds elapsed: ", seconds)
	print("Acceleration: ", v1/seconds)
	
	match area.name:
		"Area1": 
			isAccelerating = false
			Engine.time_scale = 0.2
			linear_velocity.x = -velocity
		"Area2":
			if velocity == 15:
				lbl_success.visible = true
				btn_re_start.visible = true
			elif velocity < 15:
				lbl_fail.text = "You failed to pass the gap!"
				lbl_fail.visible = true
				btn_re_start.visible = true
				linear_velocity = Vector3.ZERO
			elif velocity > 15:
				timer.start()
		"Area3":
			lbl_fail.text = "You failed to pass the gap!"
			lbl_fail.visible = true
			btn_re_start.visible = true
			linear_velocity = Vector3.ZERO
	
func _wreck_car() -> void:
	fire.visible = true
	linear_velocity = Vector3.ZERO
	
	Engine.time_scale = 1
	
	lbl_fail.text = "You wrecked your car!"
	lbl_fail.visible = true
	btn_re_start.visible = true

func round_to_half(value):
	var rounded_value = round(value * 2) / 2
	return rounded_value
