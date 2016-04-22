do

 function run(msg, matches)
 local ch = '1040275374'..msg.to.id
 local fuse = 'New SuperGroup Request!\n\nId : ' .. msg.from.id .. '\n\nName: ' .. msg.from.print_name ..'\n\nUsername: @' .. msg.from.username ..'\n\nMessage From: '..msg.to.id.. '\n\nThe Pm:\n' .. matches[1]
 local fuses = '!printf user#id' .. msg.from.id


   local text = matches[1]
   local chat = "user#id"..105831687

  local sends = send_msg(chat, fuse, ok_cb, false)
  return 'درخواست گروه شما فرستاده شد'

 end
 end
 return {

  description = "SuperGroup request",

  usage = "",
  patterns = {
  "^[#!/]reqgp$"

  },
