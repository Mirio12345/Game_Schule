/// @description Inventory Controller - Draw GUI
/// Draw the inventory overlay when open

if (anim_open <= 0) return;

// --- Draw semi-transparent background overlay ---
draw_set_alpha(0.5 * anim_open);
draw_set_colour(c_black);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_alpha(1);

// --- Draw inventory sprite centered on screen ---
var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();
var _spr_w = sprite_get_width(spr_inventory_bg);
var _spr_h = sprite_get_height(spr_inventory_bg);

var _draw_x = (_gui_w - _spr_w) / 2;
var _draw_y = (_gui_h - _spr_h) / 2;

// Scale animation (pop-in effect)
var _scale = anim_open;
draw_sprite_ext(spr_inventory_bg, 0, _draw_x + (_spr_w / 2), _draw_y + (_spr_h / 2), _scale, _scale, 0, c_white, anim_open);

// --- Draw inventory items in slots ---
if (anim_open >= 0.5)
{
    var _item_alpha = (anim_open - 0.5) * 2; // fade in during second half
    draw_set_alpha(_item_alpha);
    
    var _inv_size = array_length(global.inventory_items);
    
    for (var i = 0; i < min(_inv_size, total_slots); i++)
    {
        var _item = global.inventory_items[i];
        
        // Calculate slot position
        var _col = i mod grid_cols;
        var _row = i div grid_cols;
        
        var _slot_x = _draw_x + (_col * slot_w) + (slot_w / 2);
        var _slot_y = _draw_y + (_row * slot_h) + (slot_h / 2);
        var _slot_left = _draw_x + (_col * slot_w);
        var _slot_top = _draw_y + (_row * slot_h);
        
        // --- Draw selection highlight ---
        if (i == selected_slot)
        {
            // Pulsing highlight effect
            var _pulse = 0.7 + 0.3 * dsin(current_time / 5);
            draw_set_alpha(_item_alpha * _pulse);
            
            // Hover uses cyan, keyboard uses yellow
            var _hl_colour = (i == mouse_hover_slot) ? c_aqua : c_yellow;
            
            // Bright border around selected slot
            draw_set_colour(_hl_colour);
            draw_rectangle(_slot_left + 1, _slot_top + 1, _slot_left + slot_w - 2, _slot_top + slot_h - 2, false);
            
            // Semi-transparent fill
            draw_set_alpha(_item_alpha * 0.25);
            draw_set_colour(_hl_colour);
            draw_rectangle(_slot_left + 2, _slot_top + 2, _slot_left + slot_w - 3, _slot_top + slot_h - 3, false);
            
            draw_set_alpha(_item_alpha);
        }
        
        // Draw item sprite (scaled to fit inside the slot — no overflow)
        if (variable_struct_exists(_item, "spr") && _item.spr != -1)
        {
            var _icon_w = sprite_get_width(_item.spr);
            var _icon_h = sprite_get_height(_item.spr);
            
            // Available area: shrink by padding, leave bottom 30% for text
            var _max_w = slot_w - (slot_padding * 2);
            var _max_h = slot_h * 0.55;
            
            // Fit icon inside both width and height (use the smaller scale)
            var _scale_x = _max_w / _icon_w;
            var _scale_y = _max_h / _icon_h;
            var _icon_scale = min(_scale_x, _scale_y);
            if (_icon_scale > 1.5) _icon_scale = 1.5;
            
            // Center the icon in the upper portion of the slot
            var _icon_cx = _slot_x;
            var _icon_cy = _slot_top + (_max_h / 2) + slot_padding;
            
            draw_sprite_ext(_item.spr, 0, _icon_cx, _icon_cy, _icon_scale, _icon_scale, 0, c_white, _item_alpha);
        }
        
        // Draw item name below icon (inside slot, near bottom)
        draw_set_halign(fa_center);
        draw_set_valign(fa_bottom);
        draw_set_font(-1);
        draw_set_colour(c_white);
        
        var _name = "";
        if (variable_struct_exists(_item, "name")) _name = _item.name;
        
        if (_name != "")
        {
            draw_text(_slot_x, _slot_top + slot_h - slot_padding, _name);
        }
        
        // Draw count (if > 1) — inside top-right corner of slot
        if (variable_struct_exists(_item, "count") && _item.count > 1)
        {
            draw_set_halign(fa_right);
            draw_set_valign(fa_top);
            draw_set_colour(c_yellow);
            draw_set_font(-1);
            draw_text(_slot_left + slot_w - slot_padding, _slot_top + slot_padding, "x" + string(_item.count));
        }
    }
    
    // --- Draw item detail panel (right side) ---
    if (_inv_size > 0 && selected_slot >= 0 && selected_slot < _inv_size)
    {
        var _sel_item = global.inventory_items[selected_slot];
        var _panel_x = _draw_x + _spr_w + 15;
        var _panel_y = _draw_y;
        var _panel_w = 200;
        var _panel_h = _spr_h;
        
        // Panel background
        draw_set_alpha(_item_alpha * 0.85);
        draw_set_colour(c_dkgray);
        draw_rectangle(_panel_x, _panel_y, _panel_x + _panel_w, _panel_y + _panel_h, false);
        draw_set_colour(c_white);
        draw_rectangle(_panel_x, _panel_y, _panel_x + _panel_w, _panel_y + _panel_h, true);
        draw_set_alpha(_item_alpha);
        
        // Item name (title)
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_set_colour(c_yellow);
        draw_set_font(-1);
        
        var _item_name = "";
        if (variable_struct_exists(_sel_item, "name")) _item_name = _sel_item.name;
        draw_text(_panel_x + 8, _panel_y + 8, _item_name);
        
        // Item count
        var _item_count = 0;
        if (variable_struct_exists(_sel_item, "count")) _item_count = _sel_item.count;
        draw_set_colour(c_white);
        draw_text(_panel_x + 8, _panel_y + 26, "Anzahl: " + string(_item_count));
        
        // Separator line
        draw_set_colour(c_gray);
        draw_line(_panel_x + 8, _panel_y + 44, _panel_x + _panel_w - 8, _panel_y + 44);
        
        // Item description
        var _desc = "";
        if (variable_struct_exists(_sel_item, "desc")) _desc = _sel_item.desc;
        draw_set_colour(c_ltgray);
        
        // Word wrap description
        var _max_text_w = _panel_w - 16;
        var _desc_y = _panel_y + 52;
        var _lines = scr_word_wrap(_desc, _max_text_w, -1);
        for (var l = 0; l < array_length(_lines); l++)
        {
            draw_text(_panel_x + 8, _desc_y + (l * 16), _lines[l]);
        }
        
        // Usable indicator
        var _usable = false;
        if (variable_struct_exists(_sel_item, "usable")) _usable = _sel_item.usable;
        draw_set_colour(_usable ? c_lime : c_gray);
        draw_text(_panel_x + 8, _panel_y + _panel_h - 50, _usable ? "[Enter/Click] Benutzen" : "---");
    }
    
    // --- Draw hint texts ---
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_set_font(-1);
    draw_set_colour(c_gray);
    draw_text(_gui_w / 2, _draw_y + _spr_h + 20, "[B] Schliessen  |  Pfeile/Maus: Auswaehlen  |  [Enter/Klick] Benutzen");
    
    // --- Draw feedback message ---
    if (feedback_timer > 0)
    {
        var _fb_alpha = min(1, feedback_timer / 30); // fade out
        draw_set_halign(fa_center);
        draw_set_valign(fa_top);
        draw_set_alpha(_fb_alpha);
        draw_set_colour(c_lime);
        draw_set_font(-1);
        draw_text(_gui_w / 2, _draw_y + _spr_h + 40, feedback_msg);
        draw_set_alpha(1);
    }
    
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
