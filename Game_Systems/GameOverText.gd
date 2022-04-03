extends CanvasLayer

func _ready():
	GameState.connect("Game_Over", self, "appear")
	
func appear():
	$Label.visible = true
	$AnimationPlayer.play("Appear")
	var noons = GameState.time_counter/60
	var hours = GameState.time_counter * 0.2
	
	$Label/Score.text = "Noons Avoided " + str(floor(noons))+"\n Hours: "+str(round(hours))+"\nClocks Shot: "+str(GameState.clocks_shot)
