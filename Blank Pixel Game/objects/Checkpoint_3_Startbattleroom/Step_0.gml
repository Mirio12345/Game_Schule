if (variable_global_exists("checkpoint_flags") && variable_struct_exists(global.checkpoint_flags,"3")) active=variable_struct_get(global.checkpoint_flags,"3");
if (active) anim=min(anim+0.08,1);
