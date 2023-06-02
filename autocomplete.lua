local Autocomplete = {}
Autocomplete.root = {}

function Autocomplete:init(filename)
  for word in io.lines(filename) do
    Autocomplete:_add(string.lower(word))
  end
  return self
end

function Autocomplete:_reset()
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


function Autocomplete:_generate_chains(node, prefix)
  for letter, new_node in pairs(node) do
    if type(new_node) == 'table' then
      Autocomplete:_generate_chains(new_node, prefix .. letter)
    else
      table.insert(self.suggestions, prefix)
    end
  end
end

function Autocomplete:complete(search_term)
  Autocomplete:_reset()
  local node = Autocomplete:_get_subtrie(search_term)
  Autocomplete:_generate_chains(node, search_term)
  return Autocomplete.suggestions
end


return Autocomplete
