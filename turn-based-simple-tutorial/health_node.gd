extends Node

var MaxHP
var CurrentHP

signal Death

func TakeDamage(amount,type):
	CurrentHP = clampf(CurrentHP-amount,0,MaxHP)
	if CurrentHP <= 0:
		Death.emit()
