do

local function run(msg, matches)
  if matches[1]:lower() == 'me' or "wai" then
    if is_sudo(msg) then
    send_document(get_receiver(msg), "./data/sticker/sudo.webp", ok_cb, false)
      return "تو پارسا بابای منی"
    elseif is_admin(msg) then
    send_document(get_receiver(msg), "./data/sticker/admin.webp", ok_cb, false)
      return "تو ادمین منی"
    elseif is_owner(msg) then
    send_document(get_receiver(msg), "./data/sticker/owner.webp", ok_cb, false)
      return "تو مدیر کل این گروهیی"
    elseif is_momod(msg) then
    send_document(get_receiver(msg), "./data/sticker/moderetion.webp", ok_cb, false)
      return "تو مدیر گروهی"
    else
      send_document(get_receiver(msg), "./data/sticker/member.webp", ok_cb, false)
      return "تو کاربر عادی هستی"
  end
end
end

return {
  patterns = {
    "^[!/]([Mm]e)$",
    "^([Mm]e)$",
    "^([Ww]ai)$",
    },
  run = run
}
end
