do
 function run(msg, matches)
 local fuse = '✉️ پیامی جدید از :\n\n'\n\n🔢 آیدی : ' .. msg.from.id .. '\n\n👥 آیدی گروه ارسال شده : ' .. msg.to.id .. '\n\n📝 نام : ' .. msg.from.print_name .. '\n\n📬 پیام : \n\n'  .. matches[1]
 local fuses = '!printf user#id' .. msg.from.id
 local text = matches[1]
 local sends = send_msg('user#id179071599', fuse, ok_cb, false)
 return 'پیام شما ارسال شد با تشکر'
 end
end
return {
description = "Feedback",
usage = "feedback message",
patterns = {

 "^[Ff]eedback (.*)$",
 "^[!/][Ff]eedback (.*)$"
 

 },
 run = run
}
