extends RigidBody3D

@onready var main_camera: Camera3D = $CarCamera
@onready var lbl_speed: Label = $"../ProblemInterface/LblSpeedTag/LblSpeed"
@onready var lbl_bp:OptionButton = $"../ProblemInterface/MainPanel/Distance/OptionButton"
@onready var main_panel: Control = $"../ProblemInterface/MainPanel"
@onready var lbl_sccess: Label = $"../ProblemInterface/LblSuccess"
@onready var lbl_fail: Label = $"../ProblemInterface/LblFail"
@onready var btn_restart: Button = $"../ProblemInterface/Restart"

var acceleration = 10.1; #car has default accelaration of 10
var deacceleration = 0.0;
var breakPower = 0;
var velocity = 0.0;
var isAccelarating = true
var isDeaccelarating = false
var isArea1Reached = false
var optimal_break_power = 20.0

func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	main_camera.make_current()
	_apply_force(delta)
	_get_velocity()	
	
func _apply_force(delta: float) -> void:
	if isAccelarating :
		apply_central_force(-Vector3.RIGHT * acceleration * mass)
	elif isDeaccelarating :
		if linear_velocity.x < 0:
			linear_velocity.x += deacceleration * delta  # Reduce velocity over time
			if linear_velocity.x > 0:
				linear_velocity.x = 0  # Stop exactly
				isDeaccelarating = false
		
	 	

func _get_velocity() -> void:
	var v1 = -linear_velocity.x
	var v2 = floor(v1 * 100) / 100
	velocity = v2
	#velocity = 20 if isArea1Reached else v2
	velocity = 20 if v2 > 19.0 and v2 < 21.0 else v2
	lbl_speed.text = str(velocity) + "ms"

func _on_area_3d_area_entered(area: Area3D) -> void:
	print(area.name)
	var v = -linear_velocity.x
	var v1 = floor(v * 100) / 100
	
	print("Velocity: ", v1)

	match area.name :
		"Area1":
			isArea1Reached = true
			isAccelarating = false
			main_panel.visible = true
			GameManager.pause_game()
		"Area2":
			print("Area2 velocity " , velocity)
			print("Bp",breakPower,optimal_break_power)
			if breakPower == optimal_break_power :
				lbl_sccess.visible = true
				btn_restart.visible = true
			
			
			
		"Area3D":
			lbl_fail.visible = true
			btn_restart.visible = true
			Engine.time_scale = 0.2
			#simulate after 5 seconds car will be stoppped
			await get_tree().create_timer(1.0).timeout
			axis_lock_angular_x = true
			axis_lock_angular_y = true
			linear_velocity.x = 0 
			

func _on_btn_start_pressed() -> void:
	var bp = float(lbl_bp.get_item_text(lbl_bp.selected))
	breakPower = bp
	if bp != null: 
		GameManager.resume_game()
		deacceleration = bp 
		isDeaccelarating = true 
		main_panel.visible = false  
