local function inv_cb(extra, suc, res)
local chat_type = extra.type
local chat_id = extra.chat_id
if suc == 1 then
    	if chat_type == 'chat' then
	        send_msg('chat#id'..chat_id, 'شما با موفقیت به سوپرگروه اضافه شدید', ok_cb, false)
	    elseif chat_type == 'channel' then
	        send_msg('channel#id'..chat_id, 'شما با موفقیت به سوپرگروه اضافه شدید', ok_cb, false)
	    end
else
    	if chat_type == 'chat' then
	        send_msg('chat#id'..chat_id, 'سوپرگروه شخصی می باشد', ok_cb, false)
	    elseif chat_type == 'channel' then
	        send_msg('channel#id'..chat_id, 'سوپرگروه شخصی می باشد', ok_cb, false)
	    end
end
end
local function run(msg, matches)
    if matches[1] == 'join' then
	if matches[2]:lower() == 'support' then
		local target = 
		local user_id = msg.from.id
		channel_invite('channel#id'..target, 'user#id'..user_id, inv_cb, {chat_id=chat[1], type='channel'})
	    elseif string.match(matches[2], '^%d+$') then
		for v,chat in pairs(_chats.chats) do
        if tonumber(chat[1]) == tonumber(matches[2]) then
        local user_id = msg.from.id
		chat_add_user('chat#id'..tonumber(chat[1]), 'user#id'..user_id, inv_cb,  {chat_id=chat[1], type='chat'})
        channel_invite('channel#id'..tonumber(chat[1]), 'user#id'..user_id, inv_cb, {chat_id=chat[1], type='channel'})
        return
		end
        end
		return 'سوپرگروه مورد نظر پیدا نشد'
		end
end
end
return {
patterns = {
    "^[#!/](join) (%d+)$",
	"^[#!/](join) (support)$"
    },
run = run
}
