//DO NOT execute this script directly, it is used by the game_pause() script to generate the background

var pauseSurf, w, h;
w = surface_get_width(application_surface);
h = surface_get_height(application_surface);

if(application_surface_is_enabled()) {
    pauseBG = background_create_from_surface(application_surface,0,0,w,h,false,false);
} else {
    screen_save("pauseBG.png");
    pauseBG = background_add("pauseBG.png",0,0)
}
//surface_free(tempSurf);

if(blur_isEnabled) {
    if(d3d_isEnabled) {
        d3d_end();
        d3d_set_lighting(false);
    }

    var blurSurf, tempBlur;
    
    blurSurf = surface_create(w*0.5, h*0.5);
    tempBlur = surface_create(w*0.25, h*0.25);
    
    draw_enable_alphablend(false);      //disable alpha blend <---------------------- 
    
    surface_set_target(tempBlur);
    draw_clear_alpha(c_black,0);
    draw_background_ext(pauseBG,0,0,0.25,0.25,0,c_white,1);
    surface_reset_target();
    
    surface_set_target(blurSurf);
    draw_clear_alpha(c_black,0);
    draw_surface_ext(tempBlur,0,0,2,2,0,c_white,1);
    draw_enable_alphablend(true);                       //enable alpha blend <--------------
    
    draw_set_color_write_enable(true, true, true, false);
    draw_background_ext(pauseBG,-1,0,0.5,0.5,0,c_white,0.5);
    draw_background_ext(pauseBG,0,-1,0.5,0.5,0,c_white,0.33);
    draw_background_ext(pauseBG,1,0,0.5,0.5,0,c_white,0.25);
    draw_background_ext(pauseBG,0,1,0.5,0.5,0,c_white,0.2);
    draw_background_ext(pauseBG,0,0,0.5,0.5,0,c_white,0.16);
    draw_set_color_write_enable(true, true, true, true);
    surface_reset_target();
    
    
    blurBG = background_create_from_surface(blurSurf,0,0,w*0.5,h*0.5,false,false);
    
    surface_free(tempBlur);
    surface_free(blurSurf);
    
    if(d3d_isEnabled) {
        d3d_start();
        d3d_set_lighting(true);
    }
}