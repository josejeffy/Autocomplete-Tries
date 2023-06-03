local Autocomplete = {}
Autocomplete.root = {}

function Autocomplete:init(filename)
  local file = io.open(filename, 'r')
  if file then
    local contents = string.lower(file:read('*all'))
    file:close()
    for word in contents:gmatch("([^\n]*)\n?") do
      Autocomplete:_add(word)
    end
  else
    error('File does not exist')
  end
  return self
end

function Autocomplete:_clear_suggestions()
  self.suggestions = {}
end

function Autocomplete:_add(word)
  local node = self.root
  for letter in word:gmatch('.') do
    if not node[letter] then
      node[letter] = {}
    end
    node = node[letter]
  end
  node['is_end'] = true
end

function Autocomplete:_get_subtrie(word)
  local node = self.root
  for letter in word:gmatch('.') do
    if not node[letter] then
      return node
    end
    node = node[letter]
  end
  return node
end


function Autocomplete:_generate_suggestions(node, prefix)
  for letter, new_node in pairs(node) do
    if type(new_node) == 'table' then
      Autocomplete:_generate_suggestions(new_node, prefix .. letter)
    else
      table.insert(self.suggestions, prefix)
    end
  end
end

function Autocomplete:complete(search_term)
  Autocomplete:_clear_suggestions()
  local node = Autocomplete:_get_subtrie(search_term)
  Autocomplete:_generate_suggestions(node, search_term)
  return Autocomplete.suggestions
end


return Autocomplete
