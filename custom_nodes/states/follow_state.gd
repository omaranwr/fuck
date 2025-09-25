extends State
class_name FollowState

@export var follow_component : FollowComponent
@export var platformer_component : PlatformerComponent

func _ready() -> void:
	follow_component.following_started.connect(
		func(): is_activated = true
	)
	follow_component.following_stopped.connect(
		func(): is_activated = false
	)

func process(_delta: float) -> void:
	platformer_component.direction = (
		follow_component.direction_to_body.sign().x)

func on_exit(): platformer_component.direction = 0
