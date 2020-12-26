extends Node2D
var prejuego = load("res://Ejecutable/Juego/Escenarios/Niveles/Nivel 1/TerrenoBasico.tscn")
var juegal
# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	cargarjuego(prejuego)
	queue_free()
	pass # Replace with function body.
	
func cargarjuego(cargaJUEGO):
	juegal = cargaJUEGO.instance()
	get_node("/root").add_child(juegal)
	
