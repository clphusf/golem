do
    function run(msg, matches)
        
  local text = [[
🚀 Avira is best bot

a Persian bot for Iranian 🇮🇷

Sudo : @mohammadarak

Bot id : https://telegram.me/avirabot

http://s7.picofile.com/file/8246000950/Avira.jpg
]]
    return text
  end
end 

return {
  description = "about for bot.  ", 
  usage = {
    "Show bot about.",
  },
  patterns = {
    "^[!/]([Aa]vira)$",
  }, 
  run = run,
}
