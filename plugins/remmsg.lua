local function history(extra, suc, result)
for i=1, #result do
delete_msg(result[i].id, ok_cb, false)
end
if tonumber(extra.con) == #result then
send_msg(extra.chatid, '"'..#result..'" پیام اخیر سوپر گروه حذف شد', ok_cb, false)
else
send_msg(extra.chatid, 'تمام پیام های سوپر گروه حذف شد', ok_cb, false)
end
end
local function allhistory(extra, suc, result)
for i=1, #result do
delete_msg(result[i].id, ok_cb, false)
end
if #result == 99 then
get_history(msg.to.peer_id, 100, allhistory , {chatid = msg.to.peer_id})
else
send_msg(extra.chatid, 'تمام پیام های سوپر گروه حذف شد', ok_cb, false)
end
end
local function run(msg, matches)
if matches[1] == 'msgrem' then
    if permissions(msg.from.id, msg.to.id, "settings") then
        if msg.to.type == 'channel' then
            if tonumber(matches[2]) > 99 or tonumber(matches[2]) < 1 then
            return 'خطا باید عددی زیر 100 باشد'
        end
        delete_msg(msg.id, ok_cb, false)
            get_history(msg.to.peer_id, matches[2] + 1 , history , {chatid = msg.to.peer_id, con = matches[2]})
        else
        return 'فقط مخصوص سوپرگروها می باشد'
        end
else
return 'فقط مخصوص مدیران می باشد'
end
elseif matches[1] == 'clear' then
if matches[2] == 'msgs' then
    if permissions(msg.from.id, msg.to.id, "settings") then
        if msg.to.type == 'channel' then
           delete_msg(msg.id, ok_cb, false)
            get_history(msg.to.peer_id, 100, allhistory , {chatid = msg.to.peer_id})
        else
                         return 'فقط مخصوص سوپرگروه می باشد'
        end
else
return 'فقط مخصوص مدیران می باشد'
end
end
end
end
return {
    patterns = {
        '^[!/#](msgrem) (%d*)$',
        '^[!/#](clear) (msgs)$'
    },
    run = run
}
