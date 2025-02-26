class_name ScoreTracker



var optimal_formula: String 
var score = 5

var used_formulas : Array[String] = [] # Tracks used formulas
var used_formula_vars : Array[String] = [] #Tracks used formula vars

var formula_list = [
	#Formula.new("Formula1", "t", { "u": 0, "t": 1.5 , "v": 15, "a" : 10}),
	#Formula.new("Formula2", "d", { "v": 15, "d": 11.25 }),
	#Formula.new("Formula3", "d", { "a": 8, "d": 11.25 })
]

func _init(opt_formula: String):
	optimal_formula = opt_formula
	
func _check_formula(selected_formula: String):
	#prevent re-collection of points
	if selected_formula in used_formulas:
		print("Formula already used!") 
		return
	
	if optimal_formula == selected_formula:
		score += 1
	else:
		score -= 2
		
	used_formulas.append(selected_formula)
	
func _check_formula_vars(selected_formula: String, selected_formula_var: String):
	
	var key = selected_formula + ":" + selected_formula_var  # Unique key

	if key in used_formula_vars:
		print("Variable already used!") 
		return
	
	for formula in formula_list:
		if (formula.required_var == selected_formula_var) and (formula.func_name == selected_formula):
				score += 1
				used_formula_vars.append(key)
				return
	score -= 2
	used_formula_vars.append(key)
	
func _check_answer(selected_formula: String, final_formula_var: String, final_answer: float):
	var key = selected_formula + ":" + str(final_answer)  # Unique key

	if key in used_formula_vars:
		print("Variable already used!") 
		return
	
	for formula in formula_list:
		if (formula.correct_values.get(final_formula_var, null) == final_answer) and (formula.func_name == selected_formula):
				score += 1
				used_formula_vars.append(key)
				return
	score -= 2
	used_formula_vars.append(key)
	

func _reset_score():
	score = 5

class Formula:
	var func_name: String
	var required_var: String
	var correct_values: Dictionary


	func _init(f_name: String, req_var: String, values: Dictionary):
		func_name = f_name
		required_var = req_var
		correct_values = values
	
