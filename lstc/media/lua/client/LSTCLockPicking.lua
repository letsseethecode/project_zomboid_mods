require "ISUI/ISPanel"
require "ISUI/ISButton"

LSTCLockPickingPanel = ISPanel:derive("LSTCLockPickingPanel");
local LockedColor = {r=1,g=0,b=0,a=0.8};
local UnlockedColor = {r=0,g=1,b=0,a=0.8};

--------------------------------------------------------------------------------
-- LSTCLockPickingPanel
--------------------------------------------------------------------------------

function LSTCLockPickingPanel:new(width, height, pins, door, player)
    local screen = MainScreen.instance;
    local x = (screen.width - width) * 0.5;
    local y = (screen.height - height) * 0.5;
    local o = {};
    o = ISPanel:new(x, y, width, height);
    setmetatable(o, self);
    self.__index = self;

    o.variableColor={r=0.9, g=0.55, b=0.1, a=1};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.buttonBorderColor = {r=0.7, g=0.7, b=0.7, a=0.5};
    o.zOffsetSmallFont = 25;
    o.moveWithMouse = true;

    o.door = door;
    o.player = player;

    o.buttons = {};
    o.locked = {};
    o.index = 1;
    o.pins = pins;
    o.order = {};
    local r = {};
    for i=1,o.pins do
        table.insert(r, i);
    end
    for i=1,o.pins do
        local ix = ZombRand(o.pins + 1 - i);
        local v = r[ix];
        table.remove(r, ix);
        table.insert(o.order, v);
    end

    return o;
end

function LSTCLockPickingPanel:reset()
    self.locked = {};
    self.index = 1;
    for i=1,self.pins do
        self.buttons[i].backgroundColor = LockedColor;
    end
end

function LSTCLockPickingPanel:initialise()
    ISPanel:initialise(self)
end

function LSTCLockPickingPanel:createChildren()
    local m = 10;
    local w = (self.width - m * 2) / self.pins;
    local h = (self.height - m * 3) / 2;
    for i=1,self.pins do
        local button = ISButton:new((i-1) * w + m, m, w, h, tostring(i), { sender=self, index=i }, onButtonClick);
        button.backgroundColor = LockedColor;
        button:initialise();
        self:addChild(button);
        table.insert(self.buttons, button);
    end
    local button = ISButton:new(10, self.height - h - m, self.width - m * 2, h, "Close", self, onCloseClick);
    self:addChild(button);    
end

--------------------------------------------------------------------------------
-- Buttons
--------------------------------------------------------------------------------

function onButtonClick(args)
    local buttons = args.sender.buttons;
    local door = args.sender.door;
    local player = args.sender.player;

    if args.sender.locked[args.index] then
        args.sender:reset();
        return
    end
    args.sender.locked[args.index] = true;
    local button = buttons[args.index];
    button.backgroundColor = UnlockedColor;
    if args.sender.index == args.sender.pins then
        args.sender:removeFromUIManager();
        args.sender:setVisible(false);
        if door:isLockedByKey() then
            door:setLockedByKey(false);
            player:Say(getText("IGUI_LockPicking_Unlocked"));
        else
            door:setLockedByKey(true);
            player:Say(getText("IGUI_LockPicking_Locked"));
        end
    else
        args.sender.index = args.sender.index + 1;
    end
end

function onCloseClick(panel)
    panel:removeFromUIManager();
    panel:setVisible(false);
end

--------------------------------------------------------------------------------
-- LSTCPickDoorAction
--------------------------------------------------------------------------------

LSTCPickDoorAction = ISBaseTimedAction:derive("LSTCPickDoorAction")

LSTCPickDoorAction.PickDoor = function(self, target, player, time)
    local action = ISBaseTimedAction.new(self, player)
    action.typeTimeAction = "pickDoor"
    action.target = target
    action.player = player
    action.stopOnWalk = true
    action.stopOnRun = true
    action.maxTime = time
    action.fromHotbar = false

    if action.character:isTimedActionInstant() then action.maxTime = 1 end
    return action
end

LSTCPickDoorAction.isValid = function(self) return true end

LSTCPickDoorAction.start = function(self)
    self.player:setSneaking(true)
    self.player:faceThisObject(self.target)
    ISBaseTimedAction.start(self)
end

LSTCPickDoorAction.stop = function(self)
    ISBaseTimedAction.stop(self)
end

LSTCPickDoorAction.perform = function(self)
    local panel = LSTCLockPickingPanel:new(300, 150, 2, self.target, self.player);
    panel:initialise();
    panel:addToUIManager();
    panel:setVisible(true);
end

--------------------------------------------------------------------------------
-- Context Menu
--------------------------------------------------------------------------------

function onPickLockClick(worldobjects, target, player)
    luautils.walkAdjWindowOrDoor(player, target:getSquare(), target);
    local action = LSTCPickDoorAction:PickDoor(target, player, 50);
    ISTimedActionQueue.add(action);
end

function onContextMenu(playerIndex, context, worldobjects)
    if not LSTC.Options.LockPicking then return end

    local player = getSpecificPlayer(playerIndex)
    local target = nil
    for i, v in ipairs(worldobjects) do
        if instanceof(v, "IsoDoor") and v:getKeyId() ~= -1 then
            target = v
            break
        end
    end
    if target then
        context:addOptionOnTop(getText("UI_LSTC_LockPicking"), worldobjects, onPickLockClick, target, player)
    end
end

Events.OnFillWorldObjectContextMenu.Add(onContextMenu)

