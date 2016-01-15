/*
set the amount of blur while pausing when the blurring is enabled.

Usage: 
pause_set_blur(amount)  

amount should be a value between 0 and 1, and determines how much blur to apply to the background
*/

blur_amount = clamp(argument0,0,1);
if(pauseEffectAmount >= 1) then pauseEffectAmount = 0.999;
