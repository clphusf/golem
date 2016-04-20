package.path = package.path .. ';.luarocks/share/lua/5.2/?.lua'
  ..';.luarocks/share/lua/5.2/?/init.lua'
package.cpath = package.cpath .. ';.luarocks/lib/lua/5.2/?.so'

require("./bot/utils")

local f = assert(io.popen('/usr/bin/git describe --tags', 'r'))
VERSION = assert(f:read('*a'))
f:close()

-- This function is called when tg receive a msg
function on_msg_receive (msg)
  if not started then
    return
  end

  msg = backward_msg_format(msg)

  local receiver = get_receiver(msg)
  print(receiver)
  --vardump(msg)
  msg = pre_process_service_msg(msg)
  if msg_valid(msg) then
    msg = pre_process_msg(msg)
    if msg then
      match_plugins(msg)
    --  mark_read(receiver, ok_cb, false)
    end
  end
end

function ok_cb(extra, success, result)

end

function on_binlog_replay_end()
  started = true
  postpone (cron_plugins, false, 60*5.0)
  -- See plugins/isup.lua as an example for cron

  _config = load_config()

  -- load plugins
  plugins = {}
  load_plugins()
end

function msg_valid(msg)
  -- Don't process outgoing messages
  if msg.out then
    print('\27[36mNot valid: msg from us\27[39m')
    return false
  end

  -- Before bot was started
  if msg.date < os.time() - 5 then
    print('\27[36mNot valid: old msg\27[39m')
    return false
  end

  if msg.unread == 0 then
    print('\27[36mNot valid: readed\27[39m')
    return false
  end

  if not msg.to.id then
    print('\27[36mNot valid: To id not provided\27[39m')
    return false
  end

  if not msg.from.id then
    print('\27[36mNot valid: From id not provided\27[39m')
    return false
  end

  if msg.from.id == our_id then
    print('\27[36mNot valid: Msg from our id\27[39m')
    return false
  end

  if msg.to.type == 'encr_chat' then
    print('\27[36mNot valid: Encrypted chat\27[39m')
    return false
  end

  if msg.from.id == 777000 then
    --send_large_msg(*group id*, msg.text) *login code will be sent to GroupID*
    return false
  end

  return true
end

--
function pre_process_service_msg(msg)
   if msg.service then
      local action = msg.action or {type=""}
      -- Double ! to discriminate of normal actions
      msg.text = "!!tgservice " .. action.type

      -- wipe the data to allow the bot to read service messages
      if msg.out then
         msg.out = false
      end
      if msg.from.id == our_id then
         msg.from.id = 0
      end
   end
   return msg
end

-- Apply plugin.pre_process function
function pre_process_msg(msg)
  for name,plugin in pairs(plugins) do
    if plugin.pre_process and msg then
      print('Preprocess', name)
      msg = plugin.pre_process(msg)
    end
  end
  return msg
end

-- Go over enabled plugins patterns.
function match_plugins(msg)
  for name, plugin in pairs(plugins) do
    match_plugin(plugin, name, msg)
  end
end

-- Check if plugin is on _config.disabled_plugin_on_chat table
local function is_plugin_disabled_on_chat(plugin_name, receiver)
  local disabled_chats = _config.disabled_plugin_on_chat
  -- Table exists and chat has disabled plugins
  if disabled_chats and disabled_chats[receiver] then
    -- Checks if plugin is disabled on this chat
    for disabled_plugin,disabled in pairs(disabled_chats[receiver]) do
      if disabled_plugin == plugin_name and disabled then
        local warning = 'Plugin '..disabled_plugin..' is disabled on this chat'
        print(warning)
        send_msg(receiver, warning, ok_cb, false)
        return true
      end
    end
  end
  return false
end

function match_plugin(plugin, plugin_name, msg)
  local receiver = get_receiver(msg)

  -- Go over patterns. If one matches it's enough.
  for k, pattern in pairs(plugin.patterns) do
    local matches = match_pattern(pattern, msg.text)
    if matches then
      print("msg matches: ", pattern)

      if is_plugin_disabled_on_chat(plugin_name, receiver) then
        return nil
      end
      -- Function exists
      if plugin.run then
        -- If plugin is for privileged users only
        if not warns_user_not_allowed(plugin, msg) then
          local result = plugin.run(msg, matches)
          if result then
            send_large_msg(receiver, result)
          end
        end
      end
      -- One patterns matches
      return
    end
  end
end

-- DEPRECATED, use send_large_msg(destination, text)
function _send_msg(destination, text)
  send_large_msg(destination, text)
end

-- Save the content of _config to config.lua
function save_config( )
  serialize_to_file(_config, './data/config.lua')
  print ('saved config into ./data/config.lua')
end

-- Returns the config from config.lua file.
-- If file doesn't exist, create it.
function load_config( )
  local f = io.open('./data/config.lua', "r")
  -- If config.lua doesn't exist
  if not f then
    print ("Created new config file: data/config.lua")
    create_config()
  else
    f:close()
  end
  local config = loadfile ("./data/config.lua")()
  for v,user in pairs(config.sudo_users) do
    print("Sudo user: " .. user)
  end
  return config
end

-- Create a basic config.json file and saves it.
function create_config( )
  -- A simple config with basic plugins and ourselves as privileged user
  config = {
    enabled_plugins = {
   "active_user",
   "addbot",
   "admin",
   "anti_fwd",
   "anti_spam",
   "anti_reply",
   "aparat",
   "arabic_lock",
   "auto_leave",
   "azan",
   "banhammer",
   "bot",
   "broadcast",
   "calc",
   "cpu",
   "dad",
   "echo+",
   "echo+1",
   "echo",
   "expire",
   "feedback",
   "filtering",
   "get",
   "gif",
   "github",
   "google",
   "gps",
   "joke",
   "inpm",
   "inrealm",
   "instagram",
   "invite",
   "join",
   "leave_ban",
   "linkpv",
   "linkshorter",
   "msg_checks",
   "nerkh",
   "nerkharz",
   "onservice",
   "owners",
   "plugins",
   "qr",
   "remmsg",
   "sendplug",
   "set",
   "setabout",
   "social",
   "spam",
   "supergroup",
   "support",
   "time",
   "tophoto",
   "tosticker",
   "translate",
   "txt2sticker",
   "voice",
   "vote",
   "weather",
   "wiki",
    },
    sudo_users = {179071599},--Sudo users
    moderation = {data = 'data/moderation.json'},
    about_text = [[ ]],
    help_text_realm = [[ ]],
    help_text = [[ ]],
	help_text_super =[[
Fire Bot SuperGroup Commands:

!owner
دریافت آیدی مدیر اصلی گروه

!modlist
دریافت لیست معاونان سوپرگروه

!block (آیدی فرد)
اخراج و اضافه کردن یک فرد به لیست بلاک

!kick (آیدی فرد)
اخراج کردن فردی توسط ایدی

!muteuser
بی صدا کردن فرد توسط ریپلی یا یوزرنیم
برای خارج کردن از بی صدا دوباره دستور را ارسال نمایید

!info
دریافت اطلاعات خود

!save (متن) (موضوع)
ذخیره یک متن

!get (موضوع)
دریافت متن ذخیره شده

!id
دریافت آیدی سوپرگروه یا یک فرد

!setowner
تنظیم کردن مدیر اصلی سوپرگروه

!promote [یوزرنیم|آیدی] 
اضافه کردن مدیر به سوپرگروه

!demote [یوزرنیم|آیدی]
حذف کردن مدیر از سوپرگروه

!setname (نام جدید گروه)
تنظیم نام گروه

!setphoto
تنظیم عکس گروه

!setrules
تنظیم قوانین گروه

!setabout
تنظیم شرح گروه

!newlink
ایجاد لینک جدید

!link
دریافت لینک

!linkpv
ارسال لینک گروه به پیوی

!rules
دریافت قوانین

!lock [links|spam|Arabic|member|rtl|sticker|contacts|strict|fwd|reply]
قفل کردن تنظیمات سوپرگروه

!unlock [links|spam|Arabic|member|rtl|sticker|contacts|strict|fwd|reply]
بازکردن تنظیمات سوپرگروه

!mute [chat|audio|gifs|photo|video|service]
بی صدا کردن یک تایپ در سوپرگروه

!unmute [chat|audio|gifs|photo|video|service]
با صدا کردن یک تایپ در سوپرگروه 

!setflood [عدد]
تنظیم کردن حساسیت اسپم

!settings
دریافت تنظیمات سوپرگروه

!banlist
دریافت لیست اعضای بن شده

!clean [rules|about|modlist|mutelist]
پاک کردن قوانین ، درباره ، اعضای بی صدا و لیست مدیران

!del
حذف یک پیام توسط ریپلی در سوپرگروه

!support
دعوت سازنده ربات در صورت وجود مشکل 
فقط در صورت وجود مشکل در گروه سازنده را دعوت کنید در غیر این صورت گروه شما حذف خواهد شد 

!feedback (متن)
ارسال پیام به سازنده

!addword کلمه
اضافه کردن یک کلمه به لیست فیلتر

!rw کلمه
حذف یک کلمه از لیست فیلترینگ 

!badwords
دریافت لیست فیلترینگ 

!msgrem (عددی زیر 100)
حذف پیام های سوپرگروه به صورت عددی

!msguser 
دریافت لیست پیام های افراد

!bot off
خاموش کردن ربات در گروه

!bot on
روشن کردن ربات در گروه

!join support
عضو شدن در گروه پشتیبانی ربات

!social
دریافت راهنمای تفریحی
]],
  }
  serialize_to_file(config, './data/config.lua')
  print('saved config into ./data/config.lua')
end

function on_our_id (id)
  our_id = id
end

function on_user_update (user, what)
  --vardump (user)
end

function on_chat_update (chat, what)
  --vardump (chat)
end

function on_secret_chat_update (schat, what)
  --vardump (schat)
end

function on_get_difference_end ()
end

-- Enable plugins in config.json
function load_plugins()
  for k, v in pairs(_config.enabled_plugins) do
    print("Loading plugin", v)

    local ok, err =  pcall(function()
      local t = loadfile("plugins/"..v..'.lua')()
      plugins[v] = t
    end)

    if not ok then
      print('\27[31mError loading plugin '..v..'\27[39m')
	  print(tostring(io.popen("lua plugins/"..v..".lua"):read('*all')))
      print('\27[31m'..err..'\27[39m')
    end

  end
end

-- custom add
function load_data(filename)

	local f = io.open(filename)
	if not f then
		return {}
	end
	local s = f:read('*all')
	f:close()
	local data = JSON.decode(s)

	return data

end

function save_data(filename, data)

	local s = JSON.encode(data)
	local f = io.open(filename, 'w')
	f:write(s)
	f:close()

end


-- Call and postpone execution for cron plugins
function cron_plugins()

  for name, plugin in pairs(plugins) do
    -- Only plugins with cron function
    if plugin.cron ~= nil then
      plugin.cron()
    end
  end

  -- Called again in 2 mins
  postpone (cron_plugins, false, 120)
end

-- Start and load values
our_id = 0
now = os.time()
math.randomseed(now)
started = false
