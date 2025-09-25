extends Node
class_name State

signal activated
signal deactivated
@export var is_activated: bool = false:
	set(value):
		is_activated = value
		if value: activated.emit()
		else: deactivated.emit()
@export var priority : int = 0

func on_enter():
	pass

func physics_process(_delta: float) -> void:
	pass

func process(_delta: float) -> void:
	pass

func on_exit():
	pass
