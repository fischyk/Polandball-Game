/* 
call this script to pause the game

Usage:
game_pause()

Tip:
Objects that have the parent "parent_dont_pause" will not be paused.
Remember that they will still appear on the background image unless
you draw them in the draw GUI event.

*/

if(isPaused) then exit;

if(pause_sound != -1) {
    if(legacy_sound) then sound_play(pause_sound);
    else audio_play_sound(pause_sound,100,false)
}

scr_ps_surface_create()

instance_deactivate_all(true);
if(physics_isEnabled) then physics_pause_enable(true);
instance_activate_object(parent_dont_pause);

isPaused = true;
