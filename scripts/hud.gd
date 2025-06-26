extends Control

### Child Nodes
@onready var score = $Score
@onready var lives_remaining = $LivesRemaining

### HUD Functions
# Updates the score label
func set_score_label(new_score):
	score.text = "SCORE: " + str(new_score)

# Updates the lives remaining
