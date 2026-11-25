image_speed = 0
image_index = 0
if (!variable_global_exists("MentolCount")) global.MentolCount = variable_global_exists("HealitemCount") ? global.HealitemCount : 1
if (!variable_global_exists("MaxMentolCount")) global.MaxMentolCount = variable_global_exists("MaxHealitemCount") ? global.MaxHealitemCount : global.MentolCount
try{
count = global.HealitemCount
}
catch(_error){
global.HealitemCount = 2
}
