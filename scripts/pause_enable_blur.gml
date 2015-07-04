/* 
Enable or disable background blur while game is paused.

Usage: 
pause_enable_blur(true or false)

*/

if(argument0) then blur_isEnabled = true; 
else blur_isEnabled = false;
if(pauseEffectAmount >= 1) then pauseEffectAmount = 0.999;