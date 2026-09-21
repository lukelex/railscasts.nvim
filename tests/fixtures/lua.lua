---@class Episode
local Episode = {}

function Episode.new(title)
  return setmetatable({ title = title }, { __index = Episode })
end

---@return string
function Episode:label()
  return string.format("Episode: %s", self.title)
end

return Episode
