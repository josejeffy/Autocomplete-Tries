local Autocomplete = require 'autocomplete'

autocomplete = Autocomplete:init('unix-words.txt')
local search_terms = {'cloni','marks','stew'}

for _, search_term in pairs(search_terms) do
	local suggestions = autocomplete:complete(search_term)
	print(search_term .. ' => ' .. table.concat(suggestions,", "))
end
