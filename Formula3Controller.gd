extends Panel

@onready var lbl_formula: Label = $LblFormula
@onready var txt_d: TextEdit = $FormulaVars/LblD/TxtD
@onready var txt_u: TextEdit = $FormulaVars/LblU/TxtU
@onready var txt_a: TextEdit = $FormulaVars/LblA/TxtA
@onready var txt_v: TextEdit = $FormulaVars/LblV/TxtV
@onready var option_button: OptionButton = $LblFind/OptionButton


var d: float = 0.0
var u: float = 0.0
var a: float = 0.0
var v: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("opened formula 3")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_btn_back_f_3_pressed() -> void:
	visible = false


func _on_txt_d_text_changed() -> void:
	if txt_d.text != "?":
		d = float(txt_d.text)
	_set_formula_text()


func _on_txt_u_text_changed() -> void:
	if txt_u.text != "?":
		u = float(txt_u.text)
	_set_formula_text()


func _on_txt_a_text_changed() -> void:
	if txt_a.text != "?":
		a = float(txt_a.text)
	_set_formula_text()


func _on_txt_v_text_changed() -> void:
	if txt_v.text != "?":
		v = float(txt_v.text)
	_set_formula_text()

func _set_formula_text() -> void:
	var txtD = "d" if txt_d.text == "?" else str(d)
	var txtU = "u" if txt_u.text == "?" else str(u)
	var txtA = "a" if txt_a.text == "?" else str(a)
	var txtv = "v" if txt_v.text == "?" else str(v)
	lbl_formula.text = txtv + "^2 = " + txtU + "^2 + 2*" + txtA + " * " + txtD


func _on_btn_process_f_3_pressed() -> void:
	var result: float = 0.0
	var unit = ""
	
	var option = option_button.get_item_text(option_button.selected)
	
	match option:
		"v":
			result = sqrt(u * u + 2 * a * d)
			unit = "m/s"
		"u":
			result = sqrt(v * v - 2 * a * d)
			unit = "m/s"
		"a":
			result = (v * v - u * u) / (2 * d)
			unit = "m/s²"
		"d":
			result = (v * v - u * u) / (2 * a)
			unit = "m"
		_:
			print("Invalid option")

			
	print(result)
	lbl_formula.text = "Value of '" + option + "' = " + str(result) + unit 
