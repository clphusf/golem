do

function run(msg, matches)
local reply_id = msg['id']
local text = [[
	👥 نرخ گروه های آنتی اسپم :
  
  💴 سوپرگروه یک ماهه 5000 تومان
  💷 سوپرگروه دو ماهه 9000 تومان
  💵 سوپرگروه چهار ماهه 15000 تومان
  
  ----------------------------------
  برای خرید به آیدی زیر مراجعه کنید :
  @mohammadarak
  ]]
if matches[1] == 'nerkh' then
    if is_member(msg) then
reply_msg(reply_id, text, ok_cb, false)
end
end 
end
return {
patterns = {
"^nerkh$",
"^[#!/]([Nn]erkh)$",
},
run = run
}

end
