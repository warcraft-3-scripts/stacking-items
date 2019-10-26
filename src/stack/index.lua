local utils = require("stack.utils")

local m = {}

local config = {}

function stackTrigger()
  --  @type item
  local manipulatedItem = GetManipulatedItem()
  
  if GetItemType(manipulatedItem) ~= ITEM_TYPE_CHARGED and GetItemType(manipulatedItem) ~= ITEM_TYPE_PURCHASABLE then
    return
  end

  print("STACK")
  local unit = GetTriggerUnit()
  local count = utils.count(unit, manipulatedItem)

  -- @type integer
  local index = 0
  while index < 6 do
    -- @type item
    local itemInSlot = UnitItemInSlot(unit, index)

    if count > 1 and GetItemTypeId(itemInSlot) == GetItemTypeId(manipulatedItem) then
      local currentCharges = GetItemCharges(itemInSlot)

      SetItemCharges(itemInSlot, currentCharges + GetItemCharges(manipulatedItem))
    end

    index = index + 1
  end

  if count > 1 then
    RemoveItem(manipulatedItem)
  end

end

function m.init(max)
  config["max"] = max

  -- Respawn unit
  local t = CreateTrigger()
  TriggerAddAction(t, stackTrigger)
  TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_PICKUP_ITEM)
end

return m
