/*
set the sound to play when pausing and resuming. 

Usage: 
pause_set_sound(pause_sound, resume_sound)

set pause_sound and resume_sound to the name of a sound resource,
or set any of the arguments to -1 if you don't want a sound to play.

*/

if(sound_exists(argument0)) then pause_sound = argument0;
else pause_sound = -1;

if(sound_exists(argument1)) then resume_sound = argument1;
else resume_sound = -1;