var xx, yy, c1, c2, c3 ; /// collision var´s
/// Gravity :
y = y + grav;
grav += grav_acc;
if(grav >= grav_max) grav_max = grav;


/// Controlls Jump :
if(!jumping){
	if(keyboard_check_pressed(vk_space)) || (keyboard_check_pressed(vk_up)){				/// you can jump 2 times, one in mid-air
		jumping = true;																		/// because it is executed before the reset
		ducking = false;
		grav = jump;
	}
}

/// Animation check :
if(grav < 0){		
	sprite_index = spr_player_jump;
	ducking = false;
} else {									
    if(jumping){									
        sprite_index = spr_player_jumpfall;
		ducking = false;
    } else if(is_falling){			
        sprite_index = spr_player_fall;    
		ducking = false;
    } else {	
		grav = 0;
		is_falling = true;	
	}
}
		
/// Collision check at the bottom of the player character								(From platformer start tutorial)

c1 = tilemap_get_at_pixel(obj_game.map,x-(sprite_get_width(sprite_index)/2),y);			// left
c2 = tilemap_get_at_pixel(obj_game.map,x+(sprite_get_width(sprite_index)/2),y);			// right
c3 = tilemap_get_at_pixel(obj_game.map,x,y);											// center

if( c1 >= 1 || c2 >= 1 || c3 >= 1){														// if they are intersecting with a solide tile
	if((c1 == 1) || (c2 == 1) || (c3 == 1) || (c1 == 3) || (c2 == 3) || (c3 == 3)){		// if the tile we are intersecting with cannot be fallen through																					
		y = real(y&$ffffffc0);															// move the sprite to the top of the tile
		sprite_index = spr_player_walk;													// set the sprite to the walk sprite
		jumping = false;																// stop any jumping
		is_falling = false;																// stop any falling
		/// Controlls duck :
		if(keyboard_check(vk_shift)) || (keyboard_check(vk_down)){
			ducking = true;
			sprite_index = spr_player_duck;
		}		
	}
}    
