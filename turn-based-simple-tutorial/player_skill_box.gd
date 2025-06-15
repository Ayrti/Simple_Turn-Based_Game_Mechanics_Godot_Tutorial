extends HBoxContainer

var PlayerEntity
var Buttons:Array

func initiate(player):
	PlayerEntity = player
	get_parent().PlayerTurn.connect(DisableButtons)
	for skill in PlayerStats.Skills:
		var newButton = Button.new()
		add_child(newButton)
		newButton.text = skill.SkillName
		newButton.pressed.connect(player.AttackNode.Attack.bind(skill))
		Buttons.append(newButton)

func DisableButtons(input):
	for button in Buttons:
		button.disabled = input
