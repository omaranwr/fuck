extends Node2D
class_name FollowComponent

signal body_entered
signal body_exited
signal locked_on_body(body: Node2D)
signal following_started()
signal following_stopped()

@export var platformer_component : PlatformerComponent
@export var enter_area : Area2D
@export var exit_area : Area2D

var bodies_to_follow : Array[Node2D] = []

var direction_to_body : Vector2 = Vector2.ZERO:
	get():
		if bodies_to_follow.is_empty(): 
			return Vector2.ZERO
		return global_position.direction_to(
			bodies_to_follow[0].global_position)
		

func _ready() -> void:
	enter_area.body_entered.connect(_on_body_entered)
	exit_area.body_exited.connect(_on_body_exited)

func _on_body_entered(node: Node2D):
	if bodies_to_follow.has(node): return
	bodies_to_follow.append(node)
	body_entered.emit()
	if bodies_to_follow.size() == 1:
		following_started.emit()
		locked_on_body.emit(node)

func _on_body_exited(node: Node2D):
	var index = bodies_to_follow.find(node)
	if index >= 0:
		bodies_to_follow.remove_at(index)
		body_exited.emit()
		if bodies_to_follow.is_empty(): 
			following_stopped.emit()
		else: locked_on_body.emit(bodies_to_follow[0])
