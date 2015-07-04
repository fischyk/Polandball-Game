/* 
Execute this script at the start of the game to initialize the pause system 

Usage:
pause_init();

*/

globalvar pauseBG_xscale, pauseBG_yscale, blur_isEnabled, blur_amount, fade_isEnabled, fade_color, fade_alpha, fade_time, physics_isEnabled, d3d_isEnabled, pause_sound, resume_sound, pause_shader, pause_shader_settings, isPaused, pauseBG, blurBG, pauseSurf, pauseEffectAmount, legacy_sound;

//changeable settings
blur_isEnabled = false;
blur_amount = 0.5;
fade_isEnabled = false;
fade_color = c_black;
fade_alpha = 0.5;
fade_time = 10;
physics_isEnabled = false;
d3d_isEnabled = false;
pause_sound = -1;
resume_sound = -1;
pause_shader = -1;
pause_shader_settings = -1;
pauseBG_xscale = 1;
pauseBG_yscale = 1;

//read-only variables (you should not alter them)
isPaused = false;
pauseBG = -1;
blurBG = -1;
pauseSurf = -1;
pauseEffectAmount = 0;

if audio_system() == audio_old_system then legacy_sound = true;
else legacy_sound = false;
