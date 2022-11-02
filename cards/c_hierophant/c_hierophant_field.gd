extends Area2D

func _on_Area2D_area_entered(area):
	if area.is_in_group("bullet"):
		area.slow = true


func _on_Area2D_area_exited(area):
	if area.is_in_group("bullet"):
		area.slow = false
