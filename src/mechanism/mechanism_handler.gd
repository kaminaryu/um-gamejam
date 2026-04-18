extends Node2D

var percentage_to_lose_control: float = 0.5
var lose_control_percentage_increment: float = 0.1

var mechanism_controllable: Dictionary[String, Dictionary] = {
	"Shooting": {
		"enabled": true, 
		"node_path": "Attacking/ShootingMech",
		"weightage": 0.35,
	},
	"Aiming": {
		"enabled": true, 
		"node_path": "Attacking/AimingMech",
		"weightage": 0.30,
	},
	"Dash": {
		"enabled": true, 
		"node_path": "DashMech",
		"weightage": 0.20,
	},
	"Vision": {
		"enabled": true, 
		"node_path": "VisionMech",
		"weightage": 0.15,
	},
}

func _ready() -> void :
	WaveHandler.increased_wave.connect(_wave_increasing)


func _wave_increasing() -> void :
	randomly_remove_mechanism()
	return
	
	
func randomly_remove_mechanism() -> void :
	var dice_roll: float = randf()
	
	# no remove necessary
	if (dice_roll > percentage_to_lose_control) :
		percentage_to_lose_control += lose_control_percentage_increment
		percentage_to_lose_control = min(percentage_to_lose_control, 1)
		
		print("Wave: Not Losing Control")
		print("Wave: % to remove control is now ", percentage_to_lose_control)
		return
		
		
	# roll for buddy spawn (50% always)
	dice_roll = randf()
	
	if (dice_roll > 0.5) :
		print("Spawning Buddy...")
		$BuddyHandler.spawn_buddy()
		return
		
		
	# pick a control to remove randomly
	var total_enabled_weight: float = calculate_total_enabled_weight()
	
	# everything disabled lol
	if (total_enabled_weight == 0.0) :
		return 
		
	var weighted_roll: float = randf() * total_enabled_weight
	select_control_randomly(weighted_roll)
	
	
func calculate_total_enabled_weight() -> float :
	var total_weight: float = 0.0
	
	for key in mechanism_controllable :
		if (not mechanism_controllable[key].enabled) :
			continue
		total_weight += mechanism_controllable[key].weightage
		
	return total_weight
	
	
func select_control_randomly(roll: float) -> void :
	var cummulative_weight: float = 0.0
	for key in mechanism_controllable :
		var mechanism: Dictionary = mechanism_controllable[key]
		
		if (not mechanism.enabled) :
			continue
		
		cummulative_weight += mechanism.weightage
		if (roll < cummulative_weight) :
			toggle_mech_control(key, false)
			print("Disabled: ", key)
			return
			
	print("Wave: Everything Is Disabled")
	


func toggle_mech_control(mech_name: String, toggle: bool) -> void :
	var mechanism: Dictionary = mechanism_controllable[mech_name]
	var mechanism_node: Node = get_node(mechanism.node_path)
	mechanism_node.toggle_control()
	
	mechanism.enabled = toggle
	_print_debug()
	
	
func _process(delta: float) -> void :
	_debug_controller()
		

func _debug_controller() -> void :
	if (Input.is_action_just_pressed("(DEBUG)ToggleShooting")) :
		toggle_mech_control("Shooting", !mechanism_controllable["Shooting"].enabled)
	if (Input.is_action_just_pressed("(DEBUG)ToggleAiming")) :
		toggle_mech_control("Aiming", !mechanism_controllable["Aiming"].enabled)
	if (Input.is_action_just_pressed("(DEBUG)ToggleDash")) :
		toggle_mech_control("Dash", !mechanism_controllable["Dash"].enabled)
	if (Input.is_action_just_pressed("(DEBUG)ToggleVision")) :
		toggle_mech_control("Vision", !mechanism_controllable["Vision"].enabled)
	   

func _print_debug() -> void :
	print("Current Abilities: ")
	for key in mechanism_controllable :
		print("key: ", key, " | enabled: ", mechanism_controllable[key].enabled)
