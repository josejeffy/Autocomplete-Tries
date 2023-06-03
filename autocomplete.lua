local Autocomplete = {}

-- initialization
function Autocomplete:init(filename)
	self.suggestions = {}
	self.root = {}
	local file = io.open(filename, 'r')
	if file then
		local contents = file:read('*all')
		contents = string.lower(contents)
		for word in contents:gmatch('([^\n]*)\n?') do
			self:add(word)
		end
	else
		error('File not found')
	end
	return self
end

-- add words to trie
function Autocomplete:add(word)
	local node = self.root
	for letter in word:gmatch('.') do
		if not node[letter] then
			node[letter] = {}
		end
		node = node[letter]
	end
	node['is_end'] = true
end

-- retrieve sub-trie
function Autocomplete:get_subtrie(word)
	local node = self.root
	for letter in word:gmatch('.') do
		if not node[letter] then
			return node
		end
		node = node[letter]
	end
	return node
end

-- build suggestions from sub-trie
function Autocomplete:build_suggestions(node, prefix)
	for letter, sub_node in pairs(node) do
		if type(sub_node) == 'table' then
			local new_prefix = prefix .. letter
			self:build_suggestions(sub_node, new_prefix)
		else
			table.insert(self.suggestions, prefix)
		end
	end
end

-- generate suggestions from search term
function Autocomplete:generate_suggestions(search_term)
	self.suggestions = {}
	local subtrie = self:get_subtrie(search_term)
	self:build_suggestions(subtrie, search_term)
	return self.suggestions
end

return Autocomplete
