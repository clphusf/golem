--developed by @i9Dev
local function get_message_callback(extra, success, result)
  if result.to.type == 'chat' then
    if our_id == result.from.id then
      send_msg(extra, "you can\'t kick me :p", ok_cb, false)
    else
      local del = chat_del_user("chat#id"..result.to.id, "user#id"..result.from.id, ok_cb, false)
      if del == false then
        send_msg(extra, "Kicking failed.", ok_cb, false)
        return
      end
    end
  else
    send_msg(extra, "You're not in a group", ok_cb, false)
    return
  end
end
--developed by @i9Dev
local function run(msg, matches)
  if msg.text == "!kick" and msg.reply_id then
    msgr = get_message(msg.reply_id,get_message_callback, get_receiver(msg))
  end
end
--developed by @i9Dev
return {
   description = "kick by reply.",
   usage = {
   },
   patterns = {
      "^!kick$"
   },
   run = run,
   moderated = true,
   hide = true
   
}
