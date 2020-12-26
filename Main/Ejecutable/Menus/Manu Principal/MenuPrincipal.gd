extends Node2D

var preEscCarga3D = preload("res://Ejecutable/Menus/Cargar/Cargar3D.tscn")
var EscCarga3D

## Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_pressed():
	cargar_pantallaCarga3D(preEscCarga3D)
	pass # Replace with function body.

func cargar_pantallaCarga3D(preEscCar):
	EscCarga3D = preEscCar.instance()
	get_node("/root").add_child(EscCarga3D)
	queue_free()
