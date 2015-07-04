/* Call this script when your game changes resolution, because GM studio
does NOT automatically update the size of your game.

Usage:
game_fix_resoluiton();
*/

var w, h;

if(!view_enabled) {
    w = room_width;
    h = room_height;
}
else {
    var i, w_list, h_list;
    i = 0;
    w_list = ds_list_create();
    h_list = ds_list_create();
    repeat (8) {
        if(view_visible[i]) {
            ds_list_add(w_list,view_xport[i]+view_wport[i]);
            ds_list_add(h_list,view_yport[i]+view_hport[i]);
        }
        i += 1;
    }
    if(ds_list_size(w_list != 0)) {
        ds_list_sort(w_list,false);
        ds_list_sort(h_list,false);
        w = ds_list_find_value(w_list,0);
        h = ds_list_find_value(h_list,0);
        ds_list_destroy(w_list);
        ds_list_destroy(h_list);
    } 
    else {
        exit; //this means you have views enabled but no views are active
    }
}

window_set_size(w, h);
surface_resize(application_surface, w, h);
display_set_gui_size(w,h)