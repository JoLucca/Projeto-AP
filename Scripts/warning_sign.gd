extends Node2D

@onready var texture = $texture
@onready var area_sign = $area_sign


const lines : Array[String] = [
	"Olá, como vai?",
	"Sou o Horácio, é um prazer",
	"Devo te avisar dos perigos",
	"a frente...",
	"Já deixei de habitar a...",
	"floresta a um bom tempo.",
	"Está infestada de seres...",
	"que só pensam em destruir...",
	"minha bela floresta.",
	"Espero que você consiga...",
	"passar e derrota-los.",
	"Boa sorte!, espero lhe ver...",
	"novamente.",
]

func _unhandled_input(event):
	if area_sign.get_overlapping_bodies().size() > 0:
		texture.show()
		if event.is_action_pressed("interact") && !DialogManager.is_message_active:
			texture.hide()
			DialogManager.start_message(global_position, lines)
	else:
		texture.hide()
		if DialogManager.dialog_box != null:
			DialogManager.dialog_box.queue_free()
			DialogManager.is_message_active = false
