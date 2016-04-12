do

function run(msg, matches)
send_contact(get_receiver(msg), "+989378914486", "AVIRA", ".", ok_cb, false)
end

return {
patterns = {
"^[#/!]share$"

},
run = run
}

end
