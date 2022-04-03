extends AudioStreamPlayer2D
export var pitch_range = [0.9, 1.1]


func play_sound_effect(soundFile) -> void:
	if !self.is_playing():
			self.stream = soundFile
			self.pitch_scale = rand_range(pitch_range[0], pitch_range[1])
			self.play()
