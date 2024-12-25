extends Area2D


func playerHitAI(body: Node2D) -> void:
	if(body.name== CharacterSelectionManager.opponent1.name) and (CharacterSelectionManager.opponent1.anim.get_current_animation() != "block"):
		CharacterSelectionManager.opponent1.anim.stop()
		CharacterSelectionManager.opponent1.play_animation("damage")
		CharacterSelectionManager.instantHUD.UpdateHealth(false, 10)
		print_debug(name)
	if(body.name== CharacterSelectionManager.opponent1.name) and (CharacterSelectionManager.opponent1.anim.get_current_animation() == "block"):
		if (CharacterSelectionManager.player1.anim.get_current_animation() == "crouchLP") or (CharacterSelectionManager.player1.anim.get_current_animation() == "crouchLK") :
			CharacterSelectionManager.opponent1.anim.stop()
			CharacterSelectionManager.opponent1.play_animation("damage")
			CharacterSelectionManager.instantHUD.UpdateHealth(false, 10)
		else:
			return
func AIHitPlayer(body: Node2D) -> void:
	if(body.name== CharacterSelectionManager.player1.name) and (CharacterSelectionManager.player1.anim.get_current_animation() != "block"):
		CharacterSelectionManager.player1.anim.stop()
		CharacterSelectionManager.player1.play_animation("damage")
		CharacterSelectionManager.instantHUD.UpdateHealth(true, 10)
	if(body.name== CharacterSelectionManager.player1.name) and (CharacterSelectionManager.player1.anim.get_current_animation() == "block"):
		if (CharacterSelectionManager.opponent1.anim.get_current_animation() == "crouchLP") or (CharacterSelectionManager.opponent1.anim.get_current_animation() == "crouchLK") :
			CharacterSelectionManager.player1.anim.stop()
			CharacterSelectionManager.player1.play_animation("damage")
			CharacterSelectionManager.instantHUD.UpdateHealth(true, 10)
		else:
			return
			print_debug(name)
