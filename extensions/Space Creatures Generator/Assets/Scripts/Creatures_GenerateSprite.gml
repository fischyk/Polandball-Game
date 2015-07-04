///Creatures_GenerateSprite(gridSize, pixelSize, randomGain, function, functionParam1, functionParam2, pixelClearingIterations, mirrorMode, outline)
var vSurface, vDsGrid, vSize, vGridSize, vPixSize, vGain, vF1, vF2, vMode, vPalleteWidth, vIterations, vMirror, vOutline;

vGridSize = argument0;
vPixSize = max(argument1, 1);
vGain = clamp(argument2, 0, 1);
vF1 = argument4;
vF2 = argument5;
vMode = argument3;
vMirror = max(0, argument7) mod 4;
vIterations = clamp(argument6, 0, 3);
vPalleteWidth = sprite_get_width(sPalettes);
vOutline = argument8;
vSize = vPixSize*vGridSize;

vDsGrid = ds_grid_create(vGridSize, vGridSize);
vSurface = surface_create(vSize, vSize);

// generator
var offsetCorrection = 0;
if ( vGridSize*0.5 == floor(vGridSize*0.5) ) offsetCorrection = -0.5; else offsetCorrection = 0;

for ( var i = 0; i < vGridSize; i++ )
for ( var j = 0; j < vGridSize; j++ )
{
    var r = 0.5+random_range(-0.5,0.5)*vGain;
    
    switch (vMode)
    {
        case 0: // mode, 0 - random holes
                var chance = vF1;
                if ( random(100) > chance )
                   ds_grid_set(vDsGrid, i, j, gColor[floor(clamp(r, 0, 1) * vPalleteWidth)]);
                else ds_grid_set(vDsGrid, i, j, gColor[0]); 
                break;
                
        case 1: // sinus
                var center = floor(vGridSize*0.5)+offsetCorrection;
                var len = sqrt(center*center+center*center)+vF2;
                var dist = (1-point_distance(center, center, i, j)/len);
                var f = (1+sin(dist*vF1))/2;
                ds_grid_set(vDsGrid, i, j, gColor[floor(clamp(f*r, 0, 1) * vPalleteWidth)]);
                break;

        case 2: // sphere
                var center = floor(vGridSize*0.5)+offsetCorrection;
                var len = sqrt(center*center+center*center)+vF1;
                var f = clamp((1-point_distance(center, center, i, j)/len), 0, 1 );
                ds_grid_set(vDsGrid, i, j, gColor[floor(clamp(f*r, 0, 1) * vPalleteWidth)]);
                break;   
    }
}

// transparent pixels
ds_grid_set(vDsGrid, 0, 0, gColor[0]); 
ds_grid_set(vDsGrid, vGridSize-1, vGridSize-1, gColor[0]); 
ds_grid_set(vDsGrid, 0, vGridSize-1, gColor[0]); 
ds_grid_set(vDsGrid, vGridSize-1, vGridSize-1, gColor[0]);

// clearing alone pixels
for ( var n = 0; n < vIterations; n++ )
{
    for ( var i = 0; i < vGridSize; i++ )
    for ( var j = 0; j < vGridSize; j++ )
    {
        var vCol, vSum = 0;
        
        vSum += ds_grid_get(vDsGrid, i-1, j ) == gColor[0];
        vSum += ds_grid_get(vDsGrid, i, j-1 ) == gColor[0];
        vSum += ds_grid_get(vDsGrid, i+1, j ) == gColor[0];
        vSum += ds_grid_get(vDsGrid, i, j+1 ) == gColor[0];
        
        if (vSum >= 3) ds_grid_set(vDsGrid, i, j, gColor[0]);
    }
}

// make outline
if ( vOutline )
{
    for ( var i = 0; i < vGridSize; i++ )
    for ( var j = 0; j < vGridSize; j++ )
    {
        if ( (i >= 0 && j == 0) || (i >= 0 && j == vGridSize-1) || (j >= 0 && i == 0) || (j >= 0 && i == vGridSize-1) )
           ds_grid_set(vDsGrid, i, j, gColor[0]);
    }

    for ( var i = 0; i < vGridSize; i++ )
    for ( var j = 0; j < vGridSize; j++ )
    {
        var get = ds_grid_get(vDsGrid, i, j);
        if ( get != gColor[0] ) continue;
        
        get = ds_grid_get(vDsGrid, i-1, j);
        if ( get != gColor[0] && get != gOutlineColor ) 
        {   
           ds_grid_set(vDsGrid, i, j, gOutlineColor);
           continue;
        }
        
        get = ds_grid_get(vDsGrid, i+1, j);
        if ( get != gColor[0] && get != gOutlineColor  ) 
        {   
           ds_grid_set(vDsGrid, i, j, gOutlineColor);
           continue;
        }
        
        get = ds_grid_get(vDsGrid, i, j-1);
        if ( get != gColor[0] && get != gOutlineColor  ) 
        {   
           ds_grid_set(vDsGrid, i, j, gOutlineColor);
           continue;
        }
        
        get = ds_grid_get(vDsGrid, i, j+1);
        if ( get != gColor[0] && get != gOutlineColor  ) 
        {   
           ds_grid_set(vDsGrid, i, j, gOutlineColor);
           continue;
        }   
    }
}

// transparent pixels
ds_grid_set(vDsGrid, 0, 0, gColor[0]); 
ds_grid_set(vDsGrid, vGridSize-1, vGridSize-1, gColor[0]); 
ds_grid_set(vDsGrid, 0, vGridSize-1, gColor[0]); 
ds_grid_set(vDsGrid, vGridSize-1, vGridSize-1, gColor[0]);

// mirror mode
switch (vMirror)
{
    case 1:
         var half = vGridSize*0.5;
         for ( var i = 0; i < vGridSize; i++ )
         for ( var j = 0; j < half; j++ )
         {
            var get = ds_grid_get(vDsGrid, i, j);
            ds_grid_set(vDsGrid, i, (vGridSize-1)-j, get);
         }
         break;
    case 2:
         var half = vGridSize*0.5;
         for ( var i = 0; i < half; i++ )
         for ( var j = 0; j < vGridSize; j++ )
         {
            var get = ds_grid_get(vDsGrid, i, j);
            ds_grid_set(vDsGrid, (vGridSize-1)-i, j, get);
         }
         break;
    case 3:
         var half = vGridSize*0.5;
         for ( var i = 0; i < half; i++ )
         for ( var j = 0; j < half; j++ )
         {
            var get = ds_grid_get(vDsGrid, i, j);
            ds_grid_set(vDsGrid, (vGridSize-1)-i, j, get);
            ds_grid_set(vDsGrid, i, (vGridSize-1)-j, get);
            ds_grid_set(vDsGrid, (vGridSize-1)-i, (vGridSize-1)-j, get);
         }
         break;
}

// sprite making
surface_set_target(vSurface);
draw_clear_alpha(0,1);
for ( var i = 0; i < vSize; i += vPixSize )
for ( var j = 0; j < vSize; j += vPixSize )
{
    var get = ds_grid_get(vDsGrid, i div vPixSize, j div vPixSize);
    draw_rectangle_colour( i, j, i+vPixSize, j+vPixSize, get, get, get, get, 0 );
 
}

var spr = sprite_create_from_surface(vSurface, 0, 0, vSize, vSize, 1, 0, vSize*0.5, vSize*0.5);
surface_free(vSurface);
ds_grid_destroy(vDsGrid);

return spr;
