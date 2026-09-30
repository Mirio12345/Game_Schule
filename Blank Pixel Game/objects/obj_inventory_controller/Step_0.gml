/// @description Inventory Controller - Step
/// Toggle inventory with B key, block movement when open

// Toggle inventory on B key press
if (keyboard_check_pressed(ord("B")))
{
    global.inventory_open = !global.inventory_open;
    
    if (global.inventory_open)
    {
        // Rebuild inventory from global items
        scr_inventory_rebuild();
        
        // Reset selection to first item
        selected_slot = 0;
        feedback_msg = "";
        feedback_timer = 0;
        
        // --- PAUSE GAME: deactivate all instances except persistent/HUD objects ---
        instance_deactivate_all(true);
        instance_activate_object(obj_inventory_controller);
        if (instance_exists(obj_camera)) instance_activate_object(obj_camera);
        if (instance_exists(Hp_bar)) instance_activate_object(Hp_bar);
        if (instance_exists(obj_coin_counter)) instance_activate_object(obj_coin_counter);
        if (instance_exists(Room_persistens)) instance_activate_object(Room_persistens);
        if (instance_exists(RoomControll)) instance_activate_object(RoomControll);
    }
}

// --- Detect inventory closing (B key or ESC) and reactivate everything ---
if (prev_inventory_open && !global.inventory_open)
{
    instance_activate_all();
}
prev_inventory_open = global.inventory_open;

// Block player movement when inventory is open
if (global.inventory_open)
{
    if (variable_global_exists("can_move"))
    {
        global.can_move = false;
    }
    
    // --- Navigation (only when fully open) ---
    if (anim_open >= 1)
    {
        var _inv_size = array_length(global.inventory_items);
        
        // Navigation cooldown
        if (nav_cooldown > 0) nav_cooldown--;
        
        // --- MOUSE HOVER: check which slot the mouse is over ---
        mouse_hover_slot = -1;
        if (_inv_size > 0)
        {
            var _gui_w = display_get_gui_width();
            var _gui_h = display_get_gui_height();
            var _spr_w = sprite_get_width(spr_inventory_bg);
            var _spr_h = sprite_get_height(spr_inventory_bg);
            var _draw_x = (_gui_w - _spr_w) / 2;
            var _draw_y = (_gui_h - _spr_h) / 2;
            var _mx = device_mouse_x_to_gui(0);
            var _my = device_mouse_y_to_gui(0);
            
            for (var i = 0; i < min(_inv_size, total_slots); i++)
            {
                var _col = i mod grid_cols;
                var _row = i div grid_cols;
                var _slot_left = _draw_x + (_col * slot_w);
                var _slot_top = _draw_y + (_row * slot_h);
                
                if (_mx >= _slot_left && _mx <= _slot_left + slot_w &&
                    _my >= _slot_top && _my <= _slot_top + slot_h)
                {
                    mouse_hover_slot = i;
                    selected_slot = i; // hover selects
                    break;
                }
            }
        }
        
        if (_inv_size > 0 && nav_cooldown <= 0)
        {
            var _moved = false;
            
            // Arrow key / WASD navigation (keyboard overrides mouse)
            if (keyboard_check(vk_right) || keyboard_check(ord("D")))
            {
                selected_slot++;
                _moved = true;
                mouse_hover_slot = -1;
            }
            else if (keyboard_check(vk_left) || keyboard_check(ord("A")))
            {
                selected_slot--;
                _moved = true;
                mouse_hover_slot = -1;
            }
            else if (keyboard_check(vk_down) || keyboard_check(ord("S")))
            {
                selected_slot += grid_cols;
                _moved = true;
                mouse_hover_slot = -1;
            }
            else if (keyboard_check(vk_up) || keyboard_check(ord("W")))
            {
                selected_slot -= grid_cols;
                _moved = true;
                mouse_hover_slot = -1;
            }
            
            // Wrap around selection
            if (_moved)
            {
                if (selected_slot < 0) selected_slot = _inv_size - 1;
                if (selected_slot >= _inv_size) selected_slot = 0;
                nav_cooldown = nav_delay;
            }
            
            // Use item with Enter, Space, or Mouse Click
            var _use_item = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space);
            if (!_use_item && mouse_hover_slot >= 0)
            {
                _use_item = mouse_check_button_pressed(mb_left);
            }
            
            if (_use_item)
            {
                if (selected_slot >= 0 && selected_slot < _inv_size)
                {
                    var _item = global.inventory_items[selected_slot];
                    
                    if (variable_struct_exists(_item, "usable") && _item.usable)
                    {
                        var _result = scr_inventory_use(selected_slot);
                        if (_result != "")
                        {
                            feedback_msg = _result;
                            feedback_timer = 120; // 2 seconds at 60fps
                        }
                        
                        // Rebuild to update counts
                        scr_inventory_rebuild();
                        
                        // Adjust selection if needed
                        if (selected_slot >= array_length(global.inventory_items))
                        {
                            selected_slot = max(0, array_length(global.inventory_items) - 1);
                        }
                    }
                    else
                    {
                        feedback_msg = "Nicht verwendbar!";
                        feedback_timer = 60;
                    }
                }
            }
        }
        
        // Close with ESC as well
        if (keyboard_check_pressed(vk_escape))
        {
            global.inventory_open = false;
        }
    }
    
    // Update feedback timer
    if (feedback_timer > 0) feedback_timer--;
}
else
{
    // Only restore can_move if no cutscene is active
    if (variable_global_exists("can_move"))
    {
        // The cutscene destroys itself when finished,
        // so if the instance exists, a cutscene is active
        var _cutscene_active = instance_exists(obj_cutscene_coma);
        if (!_cutscene_active)
        {
            global.can_move = true;
        }
    }
}

// Smooth open/close animation
if (global.inventory_open)
{
    anim_open = min(anim_open + anim_speed, 1);
}
else
{
    anim_open = max(anim_open - anim_speed, 0);
}
