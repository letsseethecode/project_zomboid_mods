require "ISUI/ISPanel"
require "ISUI/ISButton"

LSTCLockPickingPanel = ISPanel:derive("LSTCLockPickingPanel");

local a = 0.5;
local LOCKED = {r=1,g=0,b=0,a=a};
local UNLOCKED = {r=0,g=1,b=0,a=a};

function LSTCLockPickingPanel:new(x, y, width, height, pins)
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
        self.buttons[i].backgroundColor = LOCKED;
    end
end

function LSTCLockPickingPanel:initialise()
    ISPanel:initialise(self)
end

function onButtonClick(args)
    local buttons = args.sender.buttons;

    if args.sender.locked[args.index] then
        args.sender:reset();
    else
        args.sender.locked[args.index] = true;
        local button = buttons[args.index];
        button.backgroundColor = UNLOCKED;
    end
end

function onCloseClick(panel)
    panel:removeFromUIManager();
    panel:setVisible(false);
end

function LSTCLockPickingPanel:createChildren()
    local m = 10;
    local w = (self.width - m * 2) / self.pins;
    local h = (self.height - m * 3) / 2;
    for i=1,self.pins do
        local button = ISButton:new((i-1) * w + m, m, w, h, tostring(i), { sender=self, index=i }, onButtonClick);
        button.backgroundColor = LOCKED;
        button:initialise();
        self:addChild(button);
        table.insert(self.buttons, button);
    end
    local button = ISButton:new(10, self.height - h - m, self.width - m * 2, h, "Close", self, onCloseClick);
    self:addChild(button);    
end

function onGameStart()
    print ("LSTCLockPickingPanel onGameStart");
    local panel = LSTCLockPickingPanel:new(100, 100, 300, 200, 6);
    panel:initialise();

    panel:addToUIManager();
    panel:setVisible(true);
end

Events.OnGameStart.Add(onGameStart);

