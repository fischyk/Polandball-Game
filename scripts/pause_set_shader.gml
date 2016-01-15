/*
This will set a shader for when drawing the pause background.
You will need your own shader in order to use this function.

Usage:
pause_set_shader(shader, settings);

"shader" should be a shader resource or -1 to turn off the use of shaders.
"settings" should point to a script resource (without the ending parentheses "()" ) 
where you should set the uniforms of your shader with the shader_set_uniform_...
functions. Set the argument to -1 if you don't need to use a script.

Scroll down the "pause_draw_background" script if you need more information
when your settings script is executed to get a better understanding what to put in it.

*/


pause_shader = argument0;
if(script_exists(argument1)) then pause_shader_settings = argument1;
else pause_shader_settings = -1;
