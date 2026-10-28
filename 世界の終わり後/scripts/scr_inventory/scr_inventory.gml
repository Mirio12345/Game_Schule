/// @function scr_inventory_rebuild()
/// @description Rebuilds the inventory display from global variables
function scr_inventory_rebuild()
{
    global.inventory_items = [];
    
    // Healing Items
    if (global.HealitemCount > 0)
    {
        array_push(global.inventory_items, {
            name: "Heilitem",
            spr: s_Healitem,
            count: global.HealitemCount,
            desc: "Heilt einen grossen Teil deiner Lebenspunkte.",
            usable: true,
            item_type: "heal"
        });
    }
    
    // Gold Coins
    if (variable_global_exists("gold_coins") && global.gold_coins > 0)
    {
        array_push(global.inventory_items, {
            name: "Gold",
            spr: -1,
            count: global.gold_coins,
            desc: "Goldene Muenzen. Koennen im Bazaar ausgegeben werden.",
            usable: false,
            item_type: "gold"
        });
    }
    
    // Speed Cigarettes
    if (variable_global_exists("speed_cigarettes") && global.speed_cigarettes > 0)
    {
        array_push(global.inventory_items, {
            name: "Zigarette",
            spr: -1,
            count: global.speed_cigarettes,
            desc: "Gibt einen temporaeren Geschwindigkeitsbonus.",
            usable: true,
            item_type: "speed"
        });
    }
    
    // Weapon Upgrade Level
    if (variable_global_exists("weapon_upgrade_level") && global.weapon_upgrade_level > 0)
    {
        array_push(global.inventory_items, {
            name: "Waffe Lv." + string(global.weapon_upgrade_level),
            spr: -1,
            count: 1,
            desc: "Erhoeht deinen Schaden und deine Schussgeschwindigkeit.",
            usable: false,
            item_type: "weapon"
        });
    }
    
    // Armor Upgrade Level
    if (variable_global_exists("armor_upgrade_level") && global.armor_upgrade_level > 0)
    {
        array_push(global.inventory_items, {
            name: "Ruestung Lv." + string(global.armor_upgrade_level),
            spr: -1,
            count: 1,
            desc: "Reduziert eingehenden Schaden um 5% pro Level.",
            usable: false,
            item_type: "armor"
        });
    }
}

/// @function scr_inventory_add(item_name, item_sprite, count)
/// @description Adds an item to the inventory
/// @param {string} item_name The name of the item
/// @param {sprite} item_sprite The sprite of the item (or -1)
/// @param {real} count The amount to add
function scr_inventory_add(item_name, item_sprite, count)
{
    // Check if item already exists
    var _found = false;
    for (var i = 0; i < array_length(global.inventory_items); i++)
    {
        if (global.inventory_items[i].name == item_name)
        {
            global.inventory_items[i].count += count;
            _found = true;
            break;
        }
    }
    
    if (!_found)
    {
        array_push(global.inventory_items, {
            name: item_name,
            spr: item_sprite,
            count: count
        });
    }
}

/// @function scr_inventory_has(item_name)
/// @description Check if player has a specific item
/// @param {string} item_name The name of the item
/// @returns {bool}
function scr_inventory_has(item_name)
{
    for (var i = 0; i < array_length(global.inventory_items); i++)
    {
        if (global.inventory_items[i].name == item_name)
        {
            return true;
        }
    }
    return false;
}

/// @function scr_inventory_get_count(item_name)
/// @description Get the count of a specific item
/// @param {string} item_name The name of the item
/// @returns {real}
function scr_inventory_get_count(item_name)
{
    for (var i = 0; i < array_length(global.inventory_items); i++)
    {
        if (global.inventory_items[i].name == item_name)
        {
            return global.inventory_items[i].count;
        }
    }
    return 0;
}

/// @function scr_inventory_use(slot_index)
/// @description Use the item in the given inventory slot
/// @param {real} slot_index The index in global.inventory_items
/// @returns {string} Feedback message to display
function scr_inventory_use(slot_index)
{
    if (slot_index < 0 || slot_index >= array_length(global.inventory_items)) return "";
    
    var _item = global.inventory_items[slot_index];
    var _type = variable_struct_exists(_item, "item_type") ? _item.item_type : "";
    
    switch (_type)
    {
        case "heal":
        {
            if (global.player_hp >= global.max_player_hp)
            {
                return "Voll HP! Nicht noetig.";
            }
            global.HealitemCount -= 1;
            var _heal = global.HealValue * global.HealMultiplier;
            global.player_hp = min(global.player_hp + _heal, global.max_player_hp);
            return "Geheilt! (+" + string(_heal) + " HP)";
        }
        
        case "speed":
        {
            // Find player and apply speed boost
            if (instance_exists(new_Gamecharacter_1))
            {
                var _player = instance_find(new_Gamecharacter_1, 0);
                _player.my_speed = _player.my_speed + 1.5;
                _player.alarm[1] = 300; // 5 seconds boost
                
                // Also give temporary speed boost variable
                if (!variable_instance_exists(_player, "speed_boost_active"))
                {
                    _player.speed_boost_active = true;
                }
                else
                {
                    _player.speed_boost_active = true;
                }
            }
            global.speed_cigarettes -= 1;
            return "Speed-Boost aktiviert!";
        }
        
        default:
        {
            return "";
        }
    }
}

/// @function scr_word_wrap(text, max_width, font)
/// @description Simple word wrap function for drawing text
/// @param {string} text The text to wrap
/// @param {real} max_width Max pixel width per line
/// @param {real} font The font to use (-1 for default)
/// @returns {array<string>} Array of wrapped lines
function scr_word_wrap(text, max_width, font)
{
    if (font != -1) draw_set_font(font);
    else draw_set_font(-1);
    
    var _words = string_split(text, " ");
    var _lines = [];
    var _current_line = "";
    
    for (var i = 0; i < array_length(_words); i++)
    {
        var _test = (_current_line == "") ? _words[i] : _current_line + " " + _words[i];
        
        if (string_width(_test) > max_width && _current_line != "")
        {
            array_push(_lines, _current_line);
            _current_line = _words[i];
        }
        else
        {
            _current_line = _test;
        }
    }
    
    if (_current_line != "")
    {
        array_push(_lines, _current_line);
    }
    
    return _lines;
}
