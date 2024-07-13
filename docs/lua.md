# LUA Basics <!-- omit from toc -->

- [Comments](#comments)
- [Variables](#variables)
- [Functions](#functions)
- [Iterators](#iterators)
- [String concatenation](#string-concatenation)
- [String conversion](#string-conversion)

## Comments

```
-- You comment out single lines like this
--[[
You comment out
multiple lines
like this
]]--
```

## Variables

```
-- Local Variables
local x = 1234;
-- Global Variables
g = 999;
```

## Functions

```
function foo(x, y)
    print("You selected ", x, " ", y);
end

local foo = function(x, y)
    print("You selected ", x, " ", y);
end
```


## Iterators

```
for i=1,10 do
    print ("Number ", i);
end
for i=10,1,-1 do
    print ("Number ", i);
end
```

## String concatenation

```
local v = "I want to " .. "concatenate" .. " these strings";
print(v);
>> "I want to concatenate these strings";
```

## String conversion

```
let s = "You selected number " .. tostring(10);
print (s);
>> "You selected number 10"
```