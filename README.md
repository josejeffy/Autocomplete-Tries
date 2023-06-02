# Autocomplete-Tries
A Lua module for autocompletion using tries

unix-words from https://github.com/dolph/dictionary/blob/master/unix-words

## Example

``` lua
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
```

## Console output

``` console
cloni => clonism, clonic, clonicotonic, clonicity
marks => markswoman, markshot, marksman, marksmanly, marksmanship
stew => stew, stewpond, stewpot, stewpan, stewable, steward, stewardry, stewardship, stewardly, stewardess, stewartry, stewart, stewarty, stewartia, stewy, stewed
```
