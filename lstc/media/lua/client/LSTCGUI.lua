require "ISUI/ISButton"

LSTC = LSTC or {}
LSTC.UI = LSTC.UI or {}

local function onButtonClick()
    print ("!!! Click !!!")
end

local function onGameStart()
    local button = ISButton:new(100, 100, 500, 500, "Click me!", nil, onButtonClick);
	button.borderColor = {r=1, g=1, b=1, a=0.1};
    button.backgroundColor = {r=1, g=1, b=1, a=0.1};
	button:ignoreWidthChange();
	button:ignoreHeightChange();
	button:setAnchorLeft(false);
	button:setAnchorRight(true);
	button:setAnchorTop(true);
	button:setAnchorBottom(false);

    button:addToUIManager();
    button:setVisible(true);

    -- MainScreen.instance:addChild(button)
end

-- Events.OnGameStart.Add(onGameStart);

