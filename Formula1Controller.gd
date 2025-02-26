extends Panel

@onready var lbl_formula: Label = $LblFormula
@onready var txt_v: TextEdit = $FormulaVars/LblV/TxtV
@onready var txt_u: TextEdit = $FormulaVars/LblU/TxtU
@onready var txt_a: TextEdit = $FormulaVars/LblA/TxtA
@onready var txt_t: TextEdit = $FormulaVars/LblT/TxtT
@onready var option_button: OptionButton = $LblFind/OptionButton
@onready var formula_selection_view = get_node("/root/Node3D/Control/Panel")
var v: float = 0.0
var u: float = 0.0
var a: float = 0.0
var t: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_btn_back_f_1_pressed() -> void:
	visible = false


func _on_txt_v_text_changed() -> void:
	if txt_v.text != "?":
		v = float(txt_v.text)
	_set_formula_text()


func _on_txt_u_text_changed() -> void:
	if txt_u.text != "?":
		u = float(txt_u.text)
	_set_formula_text()


func _on_txt_a_text_changed() -> void:
	if txt_a.text != "?":
		a = float(txt_a.text)
	_set_formula_text()


func _on_txt_t_text_changed() -> void:
	if txt_t.text != "?":
		t = float(txt_t.text)
	_set_formula_text()

func _set_formula_text() -> void:
	var txtV = "v" if txt_v.text == "?" else str(v)
	var txtU = "u" if txt_u.text == "?" else str(u)
	var txtA = "a" if txt_a.text == "?" else str(a)
	var txtT = "t" if txt_t.text == "?" else str(t)
	lbl_formula.text = txtV + " = " + txtU + " + " + txtA + " * " + txtT

#used to capture when user select find var and send back to calculate points
func _on_option_button_item_selected(index: int) -> void:
	var option = option_button.get_item_text(index)
	print("sdsdsd")
	formula_selection_view.call("check_formula_vars","Formula1",option)
	
func _on_btn_process_f_1_pressed() -> void:
	var result: float = 0.0
	var unit = ""
	
	var option = option_button.get_item_text(option_button.selected)
	
	match option:
		"v":
			result = u + a * t
			unit = "ms"
		"u":
			result = v - a * t
			unit = "ms"
		"a":
			result = (v - u)/t
			unit = "m/s²"
		"t":
			result = (v - u)/a
			unit = "s"
		_:
			print("Invalid option")
			
	print(result)
	#award points or deduct based on answer
	formula_selection_view.call("_check_answer","Formula1",option,result)
	lbl_formula.text = "Value of '" + option + "' = " + str(result) + unit 
		
