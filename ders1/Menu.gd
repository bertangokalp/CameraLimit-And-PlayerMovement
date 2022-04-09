extends ColorRect

var selected_menu = 0

func change_menu_color():
	
	$ColorRect2/ColorRect.color = Color("44b4cd")
	
	match selected_menu:
		
		
		0:
			Global.save_game()
			$ColorRect2/ColorRect.color = Color("44b4cd")
