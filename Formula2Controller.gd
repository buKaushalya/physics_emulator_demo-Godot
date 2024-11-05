extends Panel

@onready var lbl_formula: Label = $LblFormula
@onready var txt_d: TextEdit = $FormulaVars/LblD/TxtD
@onready var txt_u: TextEdit = $FormulaVars/LblU/TxtU
@onready var txt_a: TextEdit = $FormulaVars/LblA/TxtA
@onready var txt_t: TextEdit = $FormulaVars/LblT/TxtT
@onready var option_button: OptionButton = $LblFind/OptionButton


var d: float = 0.0
var u: float = 0.0
var a: float = 0.0
var t: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_btn_back_f_2_pressed() -> void:
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


func _on_txt_t_text_changed() -> void:
	if txt_t.text != "?":
		t = float(txt_t.text)
	_set_formula_text()

func _set_formula_text() -> void:
	var txtD = "d" if txt_d.text == "?" else str(d)
	var txtU = "u" if txt_u.text == "?" else str(u)
	var txtA = "a" if txt_a.text == "?" else str(a)
	var txtT = "t" if txt_t.text == "?" else str(t)
	lbl_formula.text = txtD + " = " + txtU + " + " + txtA + " * " + txtT


func _on_btn_process_f_2_pressed() -> void:
	var result: float = 0.0
	var unit = ""
	
	var option = option_button.get_item_text(option_button.selected)
	
	match option:
		"d":
			result = u * t + 0.5 * a * t * t
			unit = "m"
		"u":
			result = (d - 0.5 * a * t * t) / t
			unit = "ms"
		"a":
			result = (2 * (d - u * t)) / (t * t)
			unit = "m/s²"
		"t":
			unit = "s"
			var discriminant: float = u * u + 2 * a * d

			if discriminant >= 0:
				var t1: float = (-u + sqrt(discriminant)) / (2 * a)
				var t2: float = (-u - sqrt(discriminant)) / (2 * a)

				# Return the positive value of time
				result = max(t1, t2)
			else:
				print("No real solution for time")
		_:
			print("Invalid option")
			
	print(result)
	lbl_formula.text = "Value of '" + option + "' = " + str(result) + unit 
