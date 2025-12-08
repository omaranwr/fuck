extends Area2D
class_name HitBox

enum HitTypes {
	ONE_SHOT,
	PROLONGED
}

@export var damage : float
@export var recoil : float = -1
@export var type : Globals.HitboxTypes
@export var hit_type: HitTypes
@export var one_target: bool = false

@export var activated: bool = true:
	set(value):
		activated = value
		if default_layer == 0: return
		if value: collision_layer = default_layer
		else: collision_layer = 0
var default_layer: int = 0

var areas_hit: int = 0

func _ready() -> void:
	default_layer = collision_layer
	activated = activated
	monitoring = false
	if recoil < 0: recoil = damage*20
