do

local function run(msg, matches)
  if matches[1] == 'me' then
    if is_sudo(msg) then
     send_document(get_receiver(msg), "/home/fire/fire-sp/data/sticker/sudo.webp ", ok_cb, false)
      return "You are my father"
    elseif is_admin(msg) then
   send_document(get_receiver(msg), "/home/fire/fire-sp/data/sticker/admin.webp", ok_cb, false)
      return "You are My ADMIN"
    elseif is_owner(msg) then
    send_document(get_receiver(msg), "/home/fire/fire-sp/data/sticker/owner.webp", ok_cb, false)
      return "You are Group Owner"
    elseif is_momod(msg) then
    send_document(get_receiver(msg), "/home/fire/fire-sp/data/sticker/moderetion.webp", ok_cb, false)
      return "You are Group Mod"
    else
    send_document(get_receiver(msg), "/home/fire/fire-sp/data/sticker/member.webp", ok_cb, false)
      return "You are Group Member"
    end
  end
end

return {
  patterns = {
    "^[#!/]([Mm]e)$",
     "^([Mm]e)$"
    },
  run = run
}
end 
