local mohammad = 179071599
local function action_by_reply(extra, success, result)
  local hash = 'rank:variables'
  local text = ''
    local value = redis:hget(hash, result.from.id)
     if not value then
        if result.from.id == tonumber(mohammad) then
           text = text..'ایشان مدیر کل ربات هست\n\n'
         elseif is_admin2(result.from.id) then
           text = text..'ایشان مدیر ربات هست\n\n'
         elseif is_owner2(result.from.id, result.to.id) then
           text = text..'ایشان مدیر کل گروه هست\n\n'
         elseif is_momod2(result.from.id, result.to.id) then
           text = text..'ایشون معاون گروه هست \n\n'
     else
           text = text..'ایشان یک فرد عادی هست \n\n'
      end
      else
       text = text..'این '..value..'\n\n'
     end
   send_msg(extra.receiver, text, ok_cb,  true)
end
    local function run(msg, matches)
local receiver = get_receiver(msg)
  local user = matches[1]
  local text = ''
if msg.reply_id then
        msgr = get_message(msg.reply_id, action_by_reply, {receiver=receiver})
      else
    return 
    end
    
end
return {
  patterns = {
  "^in kie$",
  "^این کیه$",
  "^این کیه؟$",
    "^این کی بود؟؟؟$",
    "^این کی بود؟",

  }, 
  run = run 
}
