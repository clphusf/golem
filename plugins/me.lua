do

local function run(msg, matches)
  if matches[1] == 'me' then
    if is_sudo(msg) then
      return "You are my father"
           send_document(get_receiver(msg), "./data/sticker/sudo.webp ", ok_cb, false)
    elseif is_admin(msg) then
      return "You are My ADMIN"
         send_document(get_receiver(msg), "./data/sticker/admin.webp", ok_cb, false)
    elseif is_owner(msg) then
      return "You are Group Owner"
          send_document(get_receiver(msg), "./data/sticker/owner.webp", ok_cb, false)
    elseif is_momod(msg) then
      return "You are Group Mod"
          send_document(get_receiver(msg), "./data/sticker/moderetion.webp", ok_cb, false)
    else
      return "You are Group Member"
          send_document(get_receiver(msg), "./data/sticker/member.webp", ok_cb, false)
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
