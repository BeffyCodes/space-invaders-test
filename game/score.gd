class_name ScoreLabel extends Label

var score: int = 0

func update_score(points: int) -> void:
	score += points
	text = "Score: " + str(score)
	
