/*
call this script to resume the game

Usage:
game_resume()

*/

if(!isPaused) then exit;

if(resume_sound  != -1) {
    if(legacy_sound) then sound_play(resume_sound);
    else audio_play_sound(resume_sound,100,false)
}

background_delete(pauseBG);
if background_exists(blurBG) then background_delete(blurBG);
if surface_exists(pauseSurf) then surface_free(pauseSurf);

pauseBG = -1;
blurBG = -1;
pauseSurf = -1;

instance_activate_all();
if(physics_isEnabled) then physics_pause_enable(false);

pauseEffectAmount = 0;
isPaused = false;