local jocks_file = './data/jokes.lua'
local jocks_table
local know_file = './data/knows.lua'
local know_table
function read_jocks_file()
    local f = io.open(jocks_file, "r+")

    if f == nil then
        print ('Created a new jocks file on '..jocks_file)
        serialize_to_file({}, jocks_file)
    else
        print ('jokes loaded: '..jocks_file)
        f:close()
    end
    return loadfile (jocks_file)()
end
function read_know_file()
    local f = io.open(know_file, "r+")

    if f == nil then
        print ('Created a new know file on '..know_file)
        serialize_to_file({}, know_file)
    else
        print ('knows loaded: '..know_file)
        f:close()
    end
    return loadfile (know_file)()
end
function rem_jock(msg)
    local to_id = tostring(msg.to.id)
	local j = 0
    local jocks = jocks_table[to_id]
    if not jocks then
    return 'هیچ جکی در لیست جک های این چت موجود نیست'
    end
	if #jocks == 0 then
    return 'هیچ جکی در لیست جک های این چت موجود نیست'
    end
	for i=1, #jocks do
    if jocks[i] == msg.text:sub(10) then
    j = i
    end
end
if j == 0 then
    return 'جک مورد نظر در لیست جک های چت موجود نیست'
end
	for k = j, #jocks do
    jocks[k] = jocks[k+1]
    end
    serialize_to_file(jocks_table, jocks_file)

    return 'جک از لیست جک های چت حذف شد'
end
function save_jock(msg)
    local to_id = tostring(msg.to.id)
    
    if jocks_table == nil then
        jocks_table = {}
    end

    if jocks_table[to_id] == nil then
        print ('New jock key to_id: '..to_id)
        jocks_table[to_id] = {}
    end
    local jocks = jocks_table[to_id]
	for i=1, #jocks do
    if jocks[i] == msg.text:sub(10) then
	return 'جک مورد نظر از قبل در لیست جک های چت موجود است'
    end
    end
    jocks[#jocks+1] = msg.text:sub(10)

    serialize_to_file(jocks_table, jocks_file)

    return 'جک مورد نظر به لیست جک های چت افزوده شد'
end
function rem_know(msg)
    local to_id = tostring(msg.to.id)
	local j = 0
    local knows = know_table[to_id]
    if not knows then
    return 'هیچ دانستنی در لیست دانستنی های چت موجود نیست'
    end
	if #knows == 0 then
    return 'هیچ دانستنی در لیست دانستنی های چت موجود نیست'
    end
	for i=1, #knows do
    if knows[i] == msg.text:sub(10) then
    j = i
    end
end
if j == 0 then
    return 'دانستنی مورد نظر در لیست دانستنی های چت موجود نیست'
end
	for k = j, #knows do
    knows[k] = knows[k+1]
    end
    serialize_to_file(know_table, know_file)

    return 'دانستنی مورد نظر از لیست دانستنی های چت حذف شد'
end
function save_know(msg)
    local to_id = tostring(msg.to.id)
    
    if know_table == nil then
        know_table = {}
    end

    if know_table[to_id] == nil then
        print ('New jock key to_id: '..to_id)
        know_table[to_id] = {}
    end
    local knows = know_table[to_id]
    for i=1, #knows do
    if knows[i] == msg.text:sub(10) then
	return 'دانستنی مورد نظر از قبل در لیست داسنتنی های چت موجود است'
    end
    end
    knows[#knows+1] = msg.text:sub(10)

    serialize_to_file(know_table, know_file)

    return 'داسنتنی مورد نظر به لیست دانستنی های چت اضافه شد'
end
function rem_gjock(msg)
    local to_id = 'gjoke'
	local j = 0
    local jocks = jocks_table[to_id]
    if not jocks then
    return 'هیچ جکی در لیست جک های ربات وجود ندارد'
    end
	if #jocks == 0 then
    return 'هیچ جکی در لیست جک های ربات وجود ندارد'
    end
	for i=1, #jocks do
    if jocks[i] == msg.text:sub(11) then
    j = i
    end
end
if j == 0 then
    return 'جک مورد نظر در لیست جک های ربات وجود ندارد '
end
	for k = j, #jocks do
    jocks[k] = jocks[k+1]
    end
    serialize_to_file(jocks_table, jocks_file)

    return 'جک مورد نظر از لیست جک های ربات حذف گردید'
end
function save_gjock(msg)
    local to_id = 'gjoke'
    
    if jocks_table == nil then
        jocks_table = {}
    end

    if jocks_table[to_id] == nil then
        print ('New jock key to_id: '..to_id)
        jocks_table[to_id] = {}
    end
    local jocks = jocks_table[to_id]
	for i=1, #jocks do
    if jocks[i] == msg.text:sub(11) then
	return 'جک مورد نظر از قبل موجود می باشد'
    end
    end
    jocks[#jocks+1] = msg.text:sub(11)

    serialize_to_file(jocks_table, jocks_file)

    return 'جک به لیست جک های ربات افزوده شد'
end
function rem_gknow(msg)
    local to_id = 'gknow'
	local j = 0
    local knows = know_table[to_id]
    if not knows then
        return 'هیچ داسنتنی در لیست دانستنی های ربات وجود ندارد'
    end
	if #knows == 0 then
    return 'هیچ داسنتنی در لیست دانستنی های ربات وجود ندارد'
    end
	for i=1, #knows do
    if knows[i] == msg.text:sub(11) then
    j = i
    end
end
if j == 0 then
    return 'دانستنی مورد نظر در لیست دانستنی های ربات وجود ندارد'
end
	for k = j, #knows do
    knows[k] = knows[k+1]
    end
    serialize_to_file(know_table, know_file)

    return 'داسنتنی مورد نظر از لیست دانستنی های ربات حذف شد'
end
function save_gknow(msg)
    local to_id = 'gknow'
    
    if know_table == nil then
        know_table = {}
    end

    if know_table[to_id] == nil then
        print ('New jock key to_id: '..to_id)
        know_table[to_id] = {}
    end
    local knows = know_table[to_id]
	for i=1, #knows do
    if knows[i] == msg.text:sub(11) then
	return 'دانستنی مورد نظر از قبل موجود است'
    end
    end
    knows[#knows+1] = msg.text:sub(11)

    serialize_to_file(know_table, know_file)

    return 'دانستنی مورد نظر به لیست دانستنی های ربات اضافه شد'
end
function get_jock(msg)
    local to_id = tostring(msg.to.id)
    local jocks_phrases

    jocks_table = read_jocks_file()
    jocks_phrases = jocks_table[to_id]
    if not jocks_phrases then
        return 'هیچ جکی در لیست جک های ذخیره شده این چت وجود ندارد'
    end
        if #jocks_phrases == 0 then
        return 'هیچ جکی در لیست جک های ذخیره شده این چت وجود ندارد'
    end
    return '😂 جوک تصادفی: '..jocks_phrases[math.random(1,#jocks_phrases)]
end
function get_know(msg)
    local to_id = tostring(msg.to.id)
    local knows_phrases

    know_table = read_know_file()
    knows_phrases = know_table[to_id]
    if not knows_phrases then
        return 'هیچ جکی در لیست جک های ذخیره شده این چت وجود ندارد'
    end
        if #knows_phrases == 0 then
        return 'هیچ جکی در لیست جک های ذخیره شده این چت وجود ندارد'
    end
    return '‼️ دانستنی تصادفی: '..knows_phrases[math.random(1,#knows_phrases)]
end
function get_gjock(msg)
    local jocks_phrases

    jocks_table = read_jocks_file()
    jocks_phrases = jocks_table["gjoke"]
    if not jocks_phrases then
       return 'هیچ جکی در لیست جک های ربات وجود ندارد'
    end
    if #jocks_phrases == 0 then
    return 'هیچ جکی در لیست جک های ربات وجود ندارد'
    end
    return '😂 جوک تصادفی: '..jocks_phrases[math.random(1,#jocks_phrases)]
end
function get_gknow(msg)
    local knows_phrases

    know_table = read_know_file()
    knows_phrases = know_table["gknow"]
    if not knows_phrases then
        return 'هیچ دانستنی در لیست دانستی های ربات وجود ندارد'
    end
            if #knows_phrases == 0 then
        return 'هیچ دانستنی در لیست دانستی های ربات وجود ندارد'
    end
    return '‼️ دانستنی تصادفی: '..knows_phrases[math.random(1,#knows_phrases)]
end
local function run(msg, matches)
if matches[1] == 'know' then
return get_know(msg)
elseif matches[1] == 'joke' then
return get_jock(msg)
elseif matches[1] == 'gknow' then
return get_gknow(msg)
elseif matches[1] == 'gjoke' then
return get_gjock(msg)
elseif matches[1] == 'addjoke' then
if not matches[2] then
return 'باید یک جک معتبر وارد کنید'
end
if permissions(msg.from.id, msg.to.id, "jokeknow") then
jocks_table = read_jocks_file()
return save_jock(msg)
else
return 'فقط مخصوص مدیر اصلی گروه می باشد'
end
elseif matches[1] == 'remjoke' then
if not matches[2] then
return 'لطفا یک جک معتبر وارد کنید'
end
if permissions(msg.from.id, msg.to.id, "jokeknow") then
jocks_table = read_jocks_file()
return rem_jock(msg)
else
return 'فقط مخصوص مدیر اصلی می باشد'
end
elseif matches[1] == 'gremjoke' then
if not matches[2] then
return 'باید یک جک معتبر وارد نمایید'
end
if permissions(msg.from.id, msg.to.id, "gjokeknow") then
jocks_table = read_jocks_file()
return rem_gjock(msg)
else
return 'فقط مخصوص مدیر اصلی ربات می باشد'
end
elseif matches[1] == 'remknow' then
if not matches[2] then
return 'باید یک دانستنی معتبر وارد نمایید'
end
if permissions(msg.from.id, msg.to.id, "jokeknow") then
know_table = read_know_file()
return rem_know(msg)
else
return 'فقط مخصوص مدیر اصلی گروه می باشد'
end
elseif matches[1] == 'gremknow' then
if not matches[2] then
return 'باید یک دانستنی معتبر وارد نمایید'
end
if permissions(msg.from.id, msg.to.id, "gjokeknow") then
know_table = read_know_file()
return rem_gknow(msg)
else
return 'فقط مخصوص مدیر اصلی ربات می باشد'
end
elseif matches[1] == 'addknow' then
if not matches[2] then
return 'باید یک دانستنی معتبر وارد نمایید'
end
if permissions(msg.from.id, msg.to.id, "jokeknow") then
know_table = read_know_file()
return save_know(msg)
else
return 'فقط مخصوص مدیر اصلی گروه می باشد'
end
elseif matches[1] == 'gaddjoke' then
if not matches[2] then
return 'باید یک جک معتبر وارد نمایید'
end
if permissions(msg.from.id, msg.to.id, "gjokeknow") then
jocks_table = read_jocks_file()
return save_gjock(msg)
else
return 'فقط مخصوص مدیران می باشد'
end
elseif matches[1] == 'gaddknow' then
if not matches[2] then
return 'باید یک دانستنی معتبر وارد نمایید'
end
if permissions(msg.from.id, msg.to.id, "gjokeknow") then
know_table = read_know_file()
return save_gknow(msg)
else
return 'فقط مخصوص مدیران می باشد'
end
end
end
return {
patterns = {
    "^[#/!](know)$",
    "^[#/!](gknow)$",
    "^[#/!](joke)$",
    "^[#/!](gjoke)$",
    "^[#/!](addjoke) (.+)$",
    "^[#/!](addjoke)$",
    "^[#/!](remjoke) (.+)$",
    "^[#/!](remjoke)$",
    "^[#/!](gaddjoke) (.+)$",
    "^[#/!](gaddjoke)$",
    "^[#/!](gremjoke) (.+)$",
    "^[#/!](gremjoke)$",
    "^[#/!](addknow) (.+)$",
    "^[#/!](addknow)$",
    "^[#/!](remknow) (.+)$",
    "^[#/!](remknow)$",
    "^[#/!](gaddknow) (.+)$",
    "^[#/!](gaddknow)$",
    "^[#/!](gremknow) (.+)$",
    "^[#/!](gremknow)$"
    },
run = run
}
