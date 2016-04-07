local address = 'http://powerful.friends-memorial.ir/api/'
local function run(msg)
local resolve = http.request(address..'index.php')
resolve = string.gsub(resolve,'@avirabot','')

return resolve.."\nAvira V5"
end
return {
   patterns = {"^[#/!]time$","^[Tt]ime$"},
   run = run
}
