do

function run(msg, matches)
    local data = load_data(_config.moderation.data)
      local group_link = data[tostring(1027493813)]['link']
       if not group_link then
      return ''
       end
         local text = "لینک ساپورت :\n"..group_link
          send_large_msg('user#id'..msg.from.id, text.."\n", ok_cb, false)
            return "لینک ساپورت به پیوی شما ارسال شد اگر ارسال نشده شماره ربات را ذخیره کنید\n+989378914486"
end

return {
  patterns = {
    "^[/#!]([Ss]upport)$"
  },
  run = run
}

end
