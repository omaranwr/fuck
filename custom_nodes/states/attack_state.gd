extends State
class_name AttackState

@export var attack_trigger_area : Area2D
@export var animation_player : AnimationPlayer
@export var animation_name : String
@export var platformer_component : PlatformerComponent

var should_attack: bool = false:
	set(value):
		should_attack = value
		if value: 
			is_activated = true

func _ready() -> void:
	attack_trigger_area.body_entered.connect(
		func(_body): should_attack = true)
	attack_trigger_area.body_exited.connect(
		func(_body): 
		if attack_trigger_area.has_overlapping_bodies():
			return
		should_attack = false)
	animation_player.animation_finished.connect(
		func(anim_name): 
		if animation_name == anim_name:
			if should_attack:
				animation_player.play(animation_name)
				return
			is_activated = false
	)

func on_enter(): 
	animation_player.play(animation_name)
	if platformer_component:
		platformer_component.lock_movement = true
func on_exit():
	if platformer_component:
		platformer_component.lock_movement = false
