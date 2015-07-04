///Creatures_GenerateNewPalette(palleteNumber, outlineColor)
var vPal = argument0;

globalvar gColor, gOutlineColor;

gOutlineColor = argument1;

// get all pallete colors
var tempSurf, vPalleteWidth;
vPalleteWidth = sprite_get_width(sPalettes);
tempSurf = surface_create(vPalleteWidth, 1);
surface_set_target(tempSurf);
    draw_clear_alpha(0,1);
    draw_sprite(sPalettes, vPal, 0, 0);
    for ( var i = 0; i < vPalleteWidth; i++ )
    {
        gColor[i] = surface_getpixel(tempSurf, i, 0);   
    }
surface_reset_target();
surface_free(tempSurf);