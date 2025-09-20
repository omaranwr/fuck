extends Node2D
class_name FollowComponent

signal body_entered
signal body_exited

@export var platformer_component : PlatformerComponent
@export var enter_area : Area2D
@export var exit_area : Area2D

var bodies_to_follow : Array[Node2D] = []

func _ready() -> void:
	enter_area.body_entered.connect(_on_body_entered)
	exit_area.body_exited.connect(_on_body_exited)

func _process(_delta: float) -> void:
	if bodies_to_follow.is_empty(): return
	_follow_body(bodies_to_follow[0])

func _follow_body(body: Node2D):
	var direction_to_body : Vector2 
	direction_to_body = global_position.direction_to(body.global_position)   
	if platformer_component:
		platformer_component.direction = sign(direction_to_body.x)

func _on_body_entered(node: Node2D):
	if bodies_to_follow.has(node): return
	bodies_to_follow.append(node)
	body_entered.emit()

func _on_body_exited(node: Node2D):
	var index = bodies_to_follow.find(node)
	if index >= 0:
		bodies_to_follow.remove_at(index)
		body_exited.emit()
