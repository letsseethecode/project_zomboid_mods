LSTC = LSTC or {}
LSTC.Peek = LSTC.Peek or {}

LSTCTimedAction = ISBaseTimedAction:derive("LSTCTimedAction")

LSTCTimedAction.PeekDoor = function(self, target, playerObj, time)
    local action = ISBaseTimedAction.new(self, playerObj)
    action.typeTimeAction = "peekDoor"
    action.target = target
    action.playerObj = playerObj
    action.stopOnWalk = true
    action.stopOnRun = true
    action.maxTime = time
    action.fromHotbar = false

    if action.character:isTimedActionInstant() then action.maxTime = 1 end
    return action
end

LSTCTimedAction.isValid = function(self)
    return true
end

LSTCTimedAction.start = function(self)
    self.playerObj:setSneaking(true)
    self.playerObj:faceThisObject(self.target)
    ISBaseTimedAction.start(self)
end

LSTCTimedAction.stop = function(self)
    ISBaseTimedAction.stop(self)
end

LSTCTimedAction.perform = function(self)
    local opposite = self.target:getOppositeSquare()
    if opposite:getZombie() then
        self.playerObj:Say(getText("IGUI_Peek_One"))
    else
        self.playerObj:Say(getText("IGUI_Peek_None"))
    end
end

LSTC.Peek.OnPeek = function(worldobjects, target, playerObj)
    luautils.walkAdjWindowOrDoor(playerObj, target:getSquare(), target)
    ISTimedActionQueue.add(LSTCTimedAction:PeekDoor(target, playerObj, 50))
end

local function onWorldObjectContextMenu(player, context, worldobjects)
    local playerObj = getSpecificPlayer(player)
    local target = nil
    for i, v in ipairs(worldobjects) do
        if instanceof(v, "IsoDoor") and v:getKeyId() ~= -1 then
            target = v
            break
        end
    end
    if target then
        context:addOptionOnTop(getText("UI_Mod_LSTC_Peek"), worldobjects, LSTC.Peek.OnPeek, target, playerObj)
    end
end

Events.OnFillWorldObjectContextMenu.Add(onWorldObjectContextMenu)
