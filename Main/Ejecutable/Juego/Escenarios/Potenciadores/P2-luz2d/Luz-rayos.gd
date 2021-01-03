extends Node2D

# Declare member variables here. Examples:
var timer 
var contTime = 0
var contTimeTotal = 50
var energia = 1.0
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
#	timer = get_node("Timer").start()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
##	pass
func escala_energia():
	timer = get_node("Timer").start()

func _on_Timer_timeout():
	show()
	contTime += 1
	if contTime > (contTimeTotal/2):
		energia = get_node("rayos-blanca/Luz-verdosa").energy
		energia -= 0.2
		get_node("rayos-blanca/Luz-verdosa").energy = energia
#		print ("energia en la parte if", energia)
		if contTime > (contTimeTotal):
			timer = get_node("Timer").stop()
			contTime = 0 # pa bucle infinito
			hide()
			print ("contTime  ", contTime)
	else:
		energia = get_node("rayos-blanca/Luz-verdosa").energy
		energia += 0.2
		get_node("rayos-blanca/Luz-verdosa").energy = energia
#		print(get_node("rayos-blanca/Luz-verdosa").energy)
#		print ("energia en la parte del else", energia)
	pass # Replace with function body.
