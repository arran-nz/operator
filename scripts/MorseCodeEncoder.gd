extends Node
class_name MorseCodeEncoder

signal pulse

var time_to_next = 0;
var message_buffer = []
	
func _process(delta):
	var current = Time.get_ticks_msec()
	if current > time_to_next and !message_buffer.is_empty():
		do_next()

func set_buffer(message: String):
	time_to_next = Time.get_ticks_msec()
	var encoded = MorseCodeSystem.encode(message.to_upper())
	prepare_encoded_buffer(encoded)
	
func prepare_encoded_buffer(encoded: String):
	message_buffer = []
	for char in encoded:
		message_buffer.append(char)
	message_buffer.reverse()
	
func do_next():
	var next = message_buffer.pop_back()
	var t = MorseCodeSystem.long_pulse_duration
	match next:
		MorseCodeSystem.dot:
			emit_pulse(MorseCodeSystem.short_pulse_duration)
		MorseCodeSystem.dash:
			emit_pulse(MorseCodeSystem.long_pulse_duration)
		MorseCodeSystem.letter_break:
			t  = MorseCodeSystem.letter_pause_duration
		MorseCodeSystem.word_break:
			t = MorseCodeSystem.word_pause_duration
	time_to_next = Time.get_ticks_msec() + (t * 1000)

func emit_pulse(len: float):
	pulse.emit(len)  


