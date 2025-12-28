function ()
end

--- @param name string The user's name
--- @return boolean
local function test_colors(name)
  local is_active = true
  local count = 42 -- Number
  local greeting = "Hello, " .. name

  print(string.format("Testing: %s", greeting))

  if count >= 10 and is_active ~= false then
    local my_table = { "one", "two", 3 }
    return true
  end

  return nil
end

local developer = {
  name = "User",
  languages = { "Lua", "Rust", "C" },
  is_focused = true,
}

test_colors(developer.name)

