# Weird Shit <!-- omit from toc -->

This is a collection of things that are peculiar to Zomboid.

- [Java Reference](#java-reference)
- [LUA Reference](#lua-reference)
- [Global References](#global-references)
- [Random numbers](#random-numbers)


## Java Reference

Zomboid's LUA integrates with the underlying Java engine, and you will find that
you can access most of the various calls by reading the [zomboid-javadoc.com](https://zomboid-javadoc.com/41.78/zombie/Lua/LuaManager.GlobalObject.html) files.

## LUA Reference

All Zomboid's LUA code is available in the mods directory.  You should 
_DEFINITELY_ familiarise yourself with it.  There's _LOTS_ to see here.

```
C:\Program Files (x86)\Steam\steamapps\common\ProjectZomboid\media\lua
```

## Global References

Any method that is exposed on the [LuaManager.GlobalObject](https://zomboid-javadoc.com/41.78/zombie/Lua/LuaManager.GlobalObject.html) is available
as straight LUA.

For example:

```
LuaManager.GlobalObject.getSpecificPlayer(int index);
```

maps onto the LUA

```
getSpecificPlayer(int);
```

The same applies for the rest of the entities.

```
getCore().resetLua(true, "Reloading!");
```

## Random numbers

Turns out that you can't use `math.random` in Zomboid.  Instead you need to use
the custom `ZombRand()`.

There are two variants:

* `ZombRand(max)` => generates a number `1..max` (inclusive)
* `ZombRand(min, max)` => generates a number `min..max` (inclusive)
 