local function run(msg, matches)
   if not msg.service then
      return "Are you trying to troll me?"
   end
   --vardump(msg)
   if matches[1]:lower() == "chat_add_user" then
      if not msg.action.user.username then
          nama = string.gsub(msg.action.user.print_name, "_", " ")
      else 
          nama = "@"..msg.action.user.username
      end
      chat_new_user(msg)
      description_rules(msg, nama)
   elseif matches[1]:lower() == "chat_add_user_link" then
      if not msg.from.username then
          nama = string.gsub(msg.from.print_name, "_", " ")
      else
          nama = "@"..msg.from.username
      end
      chat_new_user_link(msg)
      description_rules(msg, nama)
   elseif matches[1]:lower() == "chat_del_user" then
       local bye_name = msg.action.user.first_name
       return '✋😐 خداحافظ \n' ..bye_name 
   end
end

return {
   description = "Welcoming Message",
   usage = "send message to new member",
   patterns = {
      "^!!tgservice (chat_del_user)$",
   },
   run = run
}
