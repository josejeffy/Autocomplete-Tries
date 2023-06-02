local Autocomplete = require 'autocomplete'

autocomplete = Autocomplete:init('unix-words.txt')
local search_terms = {'cloni','marks','stew'}

for _, search_term in pairs(search_terms) do
	print(
		search_term .. 
		' => ' .. 
		table.concat(autocomplete:complete(search_term),", ")
	)
end
