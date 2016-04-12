local function run(msg, matches)
  if not is_momod(msg) then
      return nil
    end

  local username = matches[1]
  local chat = 'channel#id'..msg.to.id
  
  if msg.to.type == 'channel' then
    print('setusername » '..chat..' to '..username)
    channel_set_username(chat, username, ok_cb, false)
    return 'یوزرنیم @'..username..' ذخیره شد'
  else
    return 'یوزرنیم سوپرگروه به علت انتخاب نام نادرست یا تکراری بودن ذخیره نشد'
  end  
end

return {
  description = "set channel username",
  usage = "----------",
  patterns = {
    "^[!/#][Ss][Ee][Tt][Ii][Dd] (.+)$"
  }, 
  run = run 
}
