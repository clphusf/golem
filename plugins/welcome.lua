local function description_rules(msg, nama, usernama)
  local rules = ''
                local desc = 'سلام TNAME عزیز به گروه TGNAME خوش اومدی'
local chat_id = msg.to.id
local hash = 'channel:id:'..msg.to.id..':rules'
if redis:get(hash) then
rules = redis:get(hash)
end
local dhash = 'chat:'..msg.to.id..':tdesc'
if redis:get(dhash) then
desc = redis:get(dhash)
end
desc = string.gsub(desc, "TNAME", nama)
desc = string.gsub(desc, "TGPNAME", string.gsub(msg.to.print_name, "_", " "))
desc = string.gsub(desc, "TUSERNAME", usernama)
local text = desc..rules.."\n"
return text
end
local function run(msg, matches)
if not msg.service then
return "آیا تو می خواهی مرا بخندانی؟"
end
if matches[1] == "chat_add_user" then
nama = string.gsub(msg.action.user.print_name, "_", " ")
if not msg.action.user.username then
usernama = ''
else
usernama = '@'..msg.action.user.username
end
return description_rules(msg, nama, usernama)
elseif matches[1] == "chat_add_user_link" then
nama = string.gsub(msg.from.print_name, "_", " ")
if not msg.from.username then
usernama = ''
else
usernama = '@'..msg.action.user.username
end
return description_rules(msg, usernama)
elseif matches[1] == "chat_del_user" then
local bye_name = msg.action.user.first_name
return '👋🏽 خداحافظ'
end
end
return {
patterns = {
"^!!tgservice (chat_add_user)$",
"^!!tgservice (chat_add_user_link)$",
"^!!tgservice (chat_del_user)$"
},
run = run
}
