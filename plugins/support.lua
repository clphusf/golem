do

local function callback(extra, success, result)
  vardump(success)
  vardump(result)
end

local function run(msg, matches)
  local user = 179071599

  if matches[1]:lower() == "support" then
    user = 'user#id'..user
  end

  -- The message must come from a chat group
  if msg.to.type == 'channel' then
    local chat = 'channel#id'..msg.to.id
    channel_add_user(channel, user, callback, false)
    return "سازنده ربات وارد گروه شد"
  else 
    return 'سازنده ربات وارد گروه شد'
  end

end

return {
  description = "support", 
  patterns = {
    "^[!/](support)$",
    "^support$"
  }, 
  run = run 
}

end
