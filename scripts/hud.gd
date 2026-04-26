extends CanvasLayer

func set_time(value):
	$HUD/TimeLabel.text = "TIME: " + str("%03d" % value)
	
func set_fruits(value):
	$HUD/FruitLabel.text = str("%03d "  % value)
