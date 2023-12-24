extends MarginContainer

@onready var message = $label_margin/message
@onready var letter_time_display = $letter_time_display

const MAX_WIDTH = 156

var text = ""
var letter_index = 0

var letter_display_timer := 0.00
var space_display_timer := 0.00
var punctuaction_display_timer := 0.00

signal text_display_finished()

func display_text(text_to_display: String):
	text = text_to_display
	message.text = text_to_display
	
	await resized
	
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	
	if size.x > MAX_WIDTH:
		message.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized
		await resized
		custom_minimum_size.y = size.y
		
	global_position.x -= size.x / 2
	global_position.y -= size.y + 24
	message.text = ""
	display_letter()
	
func display_letter():
	message.text += text[letter_index]
	letter_index += 1
	
	if letter_index >= text.length():
		text_display_finished.emit()
		return
	
	match text[letter_index]:
		"!", "?", ",", ".":
			letter_time_display.start(punctuaction_display_timer)
		" ":
			letter_time_display.start(space_display_timer)
		_:
			letter_time_display.start(letter_display_timer)

func _on_letter_timer_display_timeout():
	display_letter()
