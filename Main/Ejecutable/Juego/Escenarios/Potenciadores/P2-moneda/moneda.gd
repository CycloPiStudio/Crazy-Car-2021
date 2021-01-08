extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var preHubLuz = preload("res://Ejecutable/Juego/Escenarios/Potenciadores/P2-luz2d/Luz-rayos.tscn")
var HubLuz

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	HubLuz = preHubLuz.instance()
	add_child(HubLuz)

	print(body)
	
	pass # Replace with function body.
