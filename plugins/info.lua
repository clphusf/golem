do
local Arian = 179071599

local function setrank(msg, name, value) -- setrank function
  local hash = nil
   if msg.to.type == 'chat' or msg.to.type == 'channel'  then
    hash = 'rank:'..msg.to.id..':variables'
  end
  if hash then
    redis:hset(hash, name, value)
	return send_msg('chat#id'..msg.to.id, 'set Rank for ('..name..') To : '..value, ok_cb,  true)
  end
end


local function res_user_callback(extra, success, result) -- /info <username> function
  if success == 1 then  
  if result.username then
   Username = '@'..result.username
   else
   Username = '----'
  end
    local text = '➰ نام کامل : '..(result.first_name or '')..' '..(result.last_name or '')..'\n'
               ..'🔢 یوزرنیم : '..Username..'\n'
               ..'🆔 آیدی : '..result.id..'\n\n'
               .."📱 شماره : +"..(msg.from.phone or '----')..'\n'
	local hash = '👤 مقام :'..extra.chat2..':variables'
	local value = redis:hget(hash, result.id)
    if not value then
	 if result.id == tonumber(Arian) then
	   text = text..'👤 مقام : سودو \n\n'
	  elseif is_admin2(result.id) then
	   text = text..'👤 مقام : مدیر ربات \n\n'
	  elseif is_owner2(result.id, extra.chat2) then
	   text = text..'👤 مقام : مدیر اصلی گروه \n\n'
	  elseif is_momod2(result.id, extra.chat2) then
	    text = text..'👤 مقام : مدیر گروه \n\n'
      else
	    text = text..'👤 مقام : فرد عادی \n\n'
	 end
   else
   text = text..'👤 مقام : '..value..'\n\n'
  end
  local uhash = 'user:'..result.id
  local user = redis:hgetall(uhash)
  local um_hash = 'msgs:'..result.id..':'..extra.chat2
  user_info_msgs = tonumber(redis:get(um_hash) or 0)
  text = text..'✉️ تعداد پیام ها : '..user_info_msgs..'\n\n'
  text = text..'Avira V5'
  send_msg(extra.receiver, text, ok_cb,  true)
  else
	send_msg(extra.receiver, 'یوزرنیم پیدا نشد', ok_cb, false)
  end
end

local function action_by_id(extra, success, result)  -- /info <ID> function
 if success == 1 then
 if result.username then
   Username = '@'..result.username
   else
   Username = '----'
 end
   local text = '➰ نام کامل : '..(result.first_name or '')..' '..(result.last_name or '')..'\n'
               ..'🔢 یوزرنیم : '..Username..'\n'
               ..'🆔 آیدی : '..result.id..'\n\n'
               .."📱 شماره : +"..(msg.from.phone or '----')..'\n'
  local hash = '👤 مقام :'..extra.chat2..':variables'
  local value = redis:hget(hash, result.id)
  if not value then
	 if result.id == tonumber(Arian) then
	   text = text..'👤 مقام : سودو \n\n'
	  elseif is_admin2(result.id) then
	   text = text..'👤 مقام : مدیر ربات \n\n'
	  elseif is_owner2(result.id, extra.chat2) then
	   text = text..'👤 مقام : مدیر اصلی گروه \n\n'
	  elseif is_momod2(result.id, extra.chat2) then
	   text = text..'👤 مقام : مدیر گروه \n\n'
	  else
	   text = text..'👤 مقام : فرد عادی \n\n'
	  end
   else
    text = text..'👤 مقام : '..value..'\n\n'
  end
  local uhash = 'user:'..result.id
  local user = redis:hgetall(uhash)
  local um_hash = 'msgs:'..result.id..':'..extra.chat2
  user_info_msgs = tonumber(redis:get(um_hash) or 0)
  text = text..'✉️ تعداد پیام ها : '..user_info_msgs..'\n\n'
  text = text..'Avira V5'
  send_msg(extra.receiver, text, ok_cb,  true)
  else
  send_msg(extra.receiver, 'آیدی پیدا نشد', ok_cb, false)
  end
end

local function action_by_reply(extra, success, result)-- (reply) /info  function
		if result.from.username then
		   Username = '@'..result.from.username
		   else
		   Username = '----'
		 end
  local text = '➰ نام کامل : '..(result.from.first_name or '')..' '..(result.from.last_name or '')..'\n'
               ..'🔢 یوزرنیم : '..Username..'\n'
               ..'🆔 آیدی : '..result.from.id..'\n\n'
	           .."📱 شماره : +"..(msg.from.phone or '----')..'\n'
	local hash = '👤 مقام :'..result.to.id..':variables'
		local value = redis:hget(hash, result.from.id)
		 if not value then
		    if result.from.id == tonumber(Arian) then
		       text = text..'👤 مقام : سودو \n\n'
		     elseif is_admin2(result.from.id) then
		       text = text..'👤 مقام : مدیر ربات \n\n'
		     elseif is_owner2(result.from.id, result.to.id) then
		       text = text..'👤 مقام : مدیر اصلی گروه \n\n'
		     elseif is_momod2(result.from.id, result.to.id) then
		       text = text..'👤 مقام : مدیر گروه \n\n'
		 else
		       text = text..'👤 مقام : فرد عادی \n\n'
			end
		  else
		   text = text..'👤 مقام : '..value..'\n\n'
		 end
         local user_info = {} 
  local uhash = 'user:'..result.from.id
  local user = redis:hgetall(uhash)
  local um_hash = 'msgs:'..result.from.id..':'..result.to.id
  user_info_msgs = tonumber(redis:get(um_hash) or 0)
  text = text..'✉️ تعداد پیام ها : '..user_info_msgs..'\n\n'
  text = text..'Avira V5'
  send_msg(extra.receiver, text, ok_cb, true)
end

local function action_by_reply2(extra, success, result)
local value = extra.value
setrank(result, result.from.id, value)
end

local function run(msg, matches)
 if matches[1]:lower() == 'setrank' then
  local hash = 'usecommands:'..msg.from.id..':'..msg.to.id
  redis:incr(hash)
  if not is_sudo(msg) then
    return "فقط مخصوص سودو می باشد"
  end
  local receiver = get_receiver(msg)
  local Reply = msg.reply_id
  if msg.reply_id then
  local value = string.sub(matches[2], 1, 1000)
    msgr = get_message(msg.reply_id, action_by_reply2, {receiver=receiver, Reply=Reply, value=value})
  else
  local name = string.sub(matches[2], 1, 50)
  local value = string.sub(matches[3], 1, 1000)
  local text = setrank(msg, name, value)

  return text
  end
  end
 if matches[1]:lower() == 'info' and not matches[2] then
  local receiver = get_receiver(msg)
  local Reply = msg.reply_id
  if msg.reply_id then
    msgr = get_message(msg.reply_id, action_by_reply, {receiver=receiver, Reply=Reply})
  else
  if msg.from.username then
   Username = '@'..msg.from.username
   else
   Username = '----'
   end
   local text = '➰ نام : '..(msg.from.first_name or '----')..'\n'
   local text = text..'➰ نام خانوادگی : '..(msg.from.last_name or '----')..'\n'	
   local text = text..'📱 شماره : +'..(msg.from.phone or '----')..'\n'
   local text = text..'🔢 یوزرنیم : '..Username..'\n'
   local text = text..'🆔 آیدی : '..msg.from.id..'\n\n'
   local hash = 'rank:'..msg.to.id..':variables'
	if hash then
	  local value = redis:hget(hash, msg.from.id)
	  if not value then
		if msg.from.id == tonumber(Avira) then
		 text = text..'👤 مقام : سودو \n\n'
		elseif is_sudo(msg) then
		 text = text..'👤 مقام : مدیر ربات \n\n'
		elseif is_owner(msg) then
		 text = text..'👤 مقام : مدیر اصلی گروه \n\n'
		elseif is_momod(msg) then
		 text = text..'👤 مقام : مدیر گروه \n\n'
		else
		 text = text..'👤 مقام : فرد عادی \n\n'
		end
	  else
	   text = text..'👤 مقام : '..value..'\n'
	  end
	end
	 local uhash = 'user:'..msg.from.id
 	 local user = redis:hgetall(uhash)
  	 local um_hash = 'msgs:'..msg.from.id..':'..msg.to.id
	 user_info_msgs = tonumber(redis:get(um_hash) or 0)
	 text = text..'Total messages : '..user_info_msgs..'\n\n'
    if msg.to.type == 'chat' then
	 text = text..'📝 نام گروه : '..msg.to.title..'\n'
     text = text..'👥 آیدی گروه : '..msg.to.id
    end
	text = text..'\n\nAvira V5'
    return send_msg(receiver, text, ok_cb, true)
    end
  end
  if matches[1]:lower() == 'info' and matches[2]  then
   local user = matches[2]
   local chat2 = msg.to.id
   local receiver = get_receiver(msg)
   if string.match(user, '^%d+$') then
	  user_info('user#id'..user, action_by_id, {receiver=receiver, user=user, text=text, chat2=chat2})
    elseif string.match(user, '^@.+$') then
      username = string.gsub(user, '@', '')
      msgr = res_user(username, res_user_callback, {receiver=receiver, user=user, text=text, chat2=chat2})
   end
  end
end

return {
  description = 'Know your information or the info of a chat members.',
  usage = {
	'!info: Return your info and the chat info if you are in one.',
	'(Reply)!info: Return info of replied user if used by reply.',
	'!info <id>: Return the info\'s of the <id>.',
	'!info @<user_name>: Return the member @<user_name> information from the current chat.',
	'!setrank <userid> <rank>: change members rank.',
	'(Reply)!setrank <rank>: change members rank.',
  },
  patterns = {
	"^([Ii][Nn][Ff][Oo])$",
	"^([Ii][Nn][Ff][Oo]) (.*)$",
	"^[#!/](info)$",
	"^[#!/](info)(.*)$",
  },
  run = run
}

end
