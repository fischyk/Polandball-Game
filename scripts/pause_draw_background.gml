/*
It is suggested that you execute this script in the draw GUI event
instead of the normal draw event, but if you really must draw
other instances above the pause background and you don't want
to draw those instances in the GUI event, it is possible to
use this script in the normal draw event.

Usage:
pause_draw_background(x, y);

Tip: Use position 0,0 when drawing on the GUI.

*/

if !isPaused then exit;

if(d3d_isEnabled) {
    d3d_end();
    d3d_set_lighting(false);
}

var drawSurface;
drawSurface = false;

if(fade_time <= 0 && pauseEffectAmount != 1) {
    pauseEffectAmount = 1;
    drawSurface = true;
} else if(pauseEffectAmount < 1) {
    pauseEffectAmount += room_speed/max(1,fps)/fade_time;
    if(pauseEffectAmount > 1) {
        pauseEffectAmount = 1;
    }
    drawSurface = true;
    draw_enable_alphablend(false); 
    draw_background_ext(pauseBG,argument0,argument1,pauseBG_xscale,pauseBG_yscale,0,c_white,1);
    draw_enable_alphablend(true);    
}


var alpha;
alpha = pauseEffectAmount*blur_amount

if(!surface_exists(pauseSurf)) {
    pauseSurf = surface_create(background_get_width(pauseBG),background_get_height(pauseBG));
    drawSurface = true;
}

if(drawSurface) {

    surface_set_target(pauseSurf);
    draw_clear(c_black);
    draw_set_color_write_enable(true, true, true, false);
    
    draw_enable_alphablend(false);
    draw_background(pauseBG,0,0);
    draw_enable_alphablend(true);
    
    if(blur_isEnabled && blur_amount > 0 && background_exists(blurBG)) {
        var move;
        move = min(1.5,alpha*5);
    
        draw_background_ext(pauseBG,0,-move,1,1,0,c_white,0.5);
        draw_background_ext(pauseBG,0,move,1,1,0,c_white,0.33);
        draw_background_ext(pauseBG,-move,0,1,1,0,c_white,0.25);
        draw_background_ext(pauseBG,move,0,1,1,0,c_white,0.2);
        move = alpha*3;
        draw_background_ext(blurBG,0,0,2,2,0,c_white,alpha);
        draw_background_ext(blurBG,move,0,2,2,0,c_white,alpha*0.5);
        draw_background_ext(blurBG,-move,0,2,2,0,c_white,alpha*0.33);
        draw_background_ext(blurBG,0,move,2,2,0,c_white,alpha*0.25);
        draw_background_ext(blurBG,0,-move,2,2,0,c_white,alpha*0.2);
    }
    
    surface_reset_target();
    draw_set_color_write_enable(true, true, true, true);
}

// ================================== Here is where your custom shader comes in

if(pause_shader != -1) {
    shader_set(pause_shader);
    if(pause_shader_settings != -1) then script_execute(pause_shader_settings);
    draw_surface_ext(pauseSurf,argument0,argument1,pauseBG_xscale,pauseBG_yscale,0,c_white,pauseEffectAmount);
    shader_reset();
} else {
    draw_surface_ext(pauseSurf,argument0,argument1,pauseBG_xscale,pauseBG_yscale,0,c_white,pauseEffectAmount);
}

if(fade_isEnabled && fade_alpha > 0) {
    draw_set_color(fade_color);
    draw_set_alpha(fade_alpha*pauseEffectAmount);
    draw_rectangle(argument0,argument1,argument0+surface_get_width(application_surface)*pauseBG_xscale,argument1+surface_get_height(application_surface)*pauseBG_yscale,false);
    draw_set_color(c_white);
    draw_set_alpha(1);
}

if(d3d_isEnabled) {
    d3d_start();
    d3d_set_lighting(true);
}