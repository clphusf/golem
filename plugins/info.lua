do
 
 
 local function action_by_reply(extra, success, result)
   local user_info = {}
   local uhash = 'user:'..result.from.id
   local user = redis:hgetall(uhash)
   local um_hash = 'msgs:'..result.from.id..':'..result.to.id
   user_info.msgs = tonumber(redis:get(um_hash) or 0)
   user_info.name = user_print_name(user)..' ['..result.from.id..']'
   local msgs = 'تعداد پیام های ارسالی : '..user_info.msgs
   if result.from.username then
     user_name = '@'..result.from.username
   else
     user_name = ''
   end
   local msg = result
   local user_id = msg.from.id
   local chat_id = msg.to.id
   local user = 'user#id'..msg.from.id
   local chat = 'channel#id'..msg.to.id
   local data = load_data(_config.moderation.data)
   if data[tostring('admins')][tostring(user_id)] then
     who = 'مدیر ربات'
   elseif data[tostring(msg.to.id)]['moderators'][tostring(user_id)] then
     who = 'مدیر گروه'
   elseif data[tostring(msg.to.id)]['set_owner'] == tostring(user_id) then
     who = 'سازنده گروه'
   elseif tonumber(result.from.id) == tonumber(our_id) then
     who = 'سازنده گروه'
   else
     who = 'کاربر عادی'
   end
   for v,user in pairs(_config.sudo_users) do
     if user == user_id then
       who = 'سازنده ربات'
     end
   end
   local text = 'نام کامل : '..(result.from.first_name or '')..' '..(result.from.last_name or '')..'\n'
              ..'نام : '..(result.from.first_name or '')..'\n'
              ..'نام خانوادگی : '..(result.from.last_name or '')..'\n'
              ..'یوزرنیم : '..user_name..'\n'
              ..'آیدی : '..result.from.id..'\n'
              ..msgs..'\n'
              ..'مقام فرد : '..who
   send_large_msg(extra.receiver, text)
 end
 
 local function run(msg)
    if msg.text == '!info' and msg.reply_id and is_momod(msg) then
      get_message(msg.reply_id, action_by_reply, {receiver=get_receiver(msg)})
    end
 end
 
 return {
     patterns = {
       '^[!/#]info$'
     },
   run = run
 }
 end
