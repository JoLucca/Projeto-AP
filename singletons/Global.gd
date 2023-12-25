extends Node

var tela_cheia := false
var coin := 0
var score := 0








func _input(event):
	if event.is_action_pressed("Fullscreen"):
		tela_cheia = !tela_cheia
		match tela_cheia:
			true:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			false:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
				#DisplayServer.window_set_size(Vector2(640, 320))
