extends Node
class_name StateMachine

var states : Array[State] = []
var current_state : State:
	set(new_state):
		if new_state == current_state: return
		if current_state: current_state.on_exit()
		current_state = new_state
		if current_state: current_state.on_enter()

func sort_state(s1: State, s2: State) -> bool:
	if s1.priority > s2.priority: return true
	return false

func _set_current_state() -> void:
	var index : int = 0
	while index < states.size():
		var new_state := states[index]
		if new_state.is_activated: 
			current_state = new_state
			return
		index+=1
	current_state = null

func _ready() -> void:
	states = get_states()
	states.sort_custom(sort_state)
	for state in states:
		_set_current_state()
		state.activated.connect(_set_current_state)
		state.deactivated.connect(_set_current_state)

func _physics_process(delta: float) -> void:
	current_state.physics_process(delta)

func _process(delta: float) -> void:
	current_state.process(delta)

func get_states() -> Array[State]:
	var result : Array[State] = []
	for child in get_children():
		if child is State:
			result.append(child)
	return result
