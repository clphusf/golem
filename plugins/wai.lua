do

local function run(msg, matches)
  if matches[1] == 'wai' then
    if is_sudo(msg) then
   send_document(get_receiver(msg), "/new/Avira/wai/sudo.webp", ok_cb, false)
      return "شما مدیر اصلی ربات هستید"
    elseif is_admin(msg) then
   send_document(get_receiver(msg), "/new/Avira/wai/admin.webp", ok_cb, false)
      return "شما معاون ربات هستید"
    elseif is_owner(msg) then
   send_document(get_receiver(msg), "/new/Avira/wai/owner.webp", ok_cb, false)
      return "شما مدیر اصلی این گروه هستید"
    elseif is_momod(msg) then
  send_document(get_receiver(msg), "/new/Avira/wai/mod.webp", ok_cb, false)
      return "شما مدیر این گروه هستید"
    else
  send_document(get_receiver(msg), "/new/Avira/wai/member.webp", ok_cb, false)
      return "شما یک فرد عادی هستید"
    end
  end
end

return {
  patterns = {
    "^[#!/]([Ww]ai)$",
    },
  run = run
}
end 
