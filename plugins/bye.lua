local function run(msg, matches)
   if matches[1]:lower() == "chat_del_user" then
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
