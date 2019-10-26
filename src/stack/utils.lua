local m = {}

function m.count(unit, item)
  -- @type integer
  local index = 0
  -- @type integer
  local count = 0

  while index < 6 do
    -- @type item
    local itemInSlot = UnitItemInSlot(unit, index)

    if GetItemTypeId(itemInSlot) == GetItemTypeId(item) then
      count = count + 1
    end

    index = index + 1
  end

  return count
end

return m
