extends CanvasLayer

func set_time_label(value):
	$TimerHUD/TimeLabel.text = "TIME: " + str(value)
