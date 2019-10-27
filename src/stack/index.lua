local utils = require("stack.utils")

local m = {}

local config = {}

function stackTrigger()
  --  @type item
  local manipulatedItem = GetManipulatedItem()

  if GetItemCharges(manipulatedItem) <= 0 then
    return
  end

  local unit = GetTriggerUnit()
  local count = utils.count(unit, manipulatedItem)
  local countMax = utils.countMax(unit, manipulatedItem, config["max"])

  -- @type integer
  local index = 0
  while index < 6 do
    -- @type item
    local itemInSlot = UnitItemInSlot(unit, index)

    print(count, countMax)
    if count > countMax and GetItemTypeId(itemInSlot) == GetItemTypeId(manipulatedItem) and GetItemCharges(itemInSlot) < config["max"] then
      local currentCharges = GetItemCharges(itemInSlot)

      SetItemCharges(itemInSlot, currentCharges + GetItemCharges(manipulatedItem))

      if count > countMax then
        RemoveItem(manipulatedItem)
      end
    end

    index = index + 1
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
