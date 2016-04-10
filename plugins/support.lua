do

local function callback(extra, success, result)
  vardump(success)
  vardump(result)
end

local function run(msg, matches)
  local user = 179071599

  if matches[1] == "support" then
    user = 'user#id'..user
  end

  — The message must come from a chat group
  if msg.to.type == 'channel' then
    local channel = 'channel#id'..msg.to.id
    channel_invite(chat, user, callback, false)
    return "سازنده ربات وارد گروه شد"
  else 
    return 'اینجا یک سوپرگروه نمی باشد'
  end

end

return {
  description = "support", 
  patterns = {
    "^[!#/](support)$"
  }, 
  run = run 
}

end
