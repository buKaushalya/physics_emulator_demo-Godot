extends Panel

@onready var lbl_points : Label = $Points
@onready var lbl_fail: Label = $"../LblFail"
@onready var btn_re_start: Button = $"../BtnReStart"
@onready var main_panel:Control = $"../Panel"

var score_tracker = ScoreTracker.new("Formula3")

#TimerVars
var seconds = 0
var minuites = 0
var Dseconds = 30
var Dminuites = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_reset_timer()
	lbl_points.text = "Points " + str(score_tracker.score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lbl_points.text = "Points " + str(score_tracker.score)


func check_formula(selected_formula: String):
	score_tracker._check_formula(selected_formula)
	if score_tracker.score < 0:
		reset_game("p")
		return

func check_formula_vars(selected_formula: String, selected_formula_var: String):
	score_tracker._check_formula_vars(selected_formula,selected_formula_var)
	if score_tracker.score < 0:
		reset_game("p")
		return

func _check_answer(selected_formula: String, final_formula_var: String, final_answer: float):
	score_tracker._check_answer(selected_formula,final_formula_var,final_answer)
	if score_tracker.score < 0:
		reset_game("p")
		return

func reset_game(reason: String): #reset reason for the game
	if(reason == "p"):
		lbl_fail.text = "You ran out of points!"
	else:
		lbl_fail.text = "You ran out of time!"
	lbl_fail.visible = true
	btn_re_start.visible = true
	main_panel.visible = false
	print("called")
	hide()

#Timer methods
func _on_timer_timeout() -> void:
	
	if minuites == 0 and seconds == 0:
		reset_game("t")
		return 
	
	if seconds == 0:
		if minuites > 0:
			minuites -= 1
			seconds = 60
	seconds -= 1
	$TimeLabel.text = str(minuites) + ":" + str(seconds)
func _reset_timer() -> void:
	seconds = Dseconds
	minuites = Dminuites
