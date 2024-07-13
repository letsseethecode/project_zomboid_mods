# Mods

- [Mods](#mods)
  - [Where do I put my mods?](#where-do-i-put-my-mods)
  - [Where are the mods I downloaded in steam?](#where-are-the-mods-i-downloaded-in-steam)
  - [What is the structure of a mod?](#what-is-the-structure-of-a-mod)
    - [mod.info](#modinfo)
    - [media/](#media)
    - [media/lua/](#medialua)
    - [media/lua/client/](#medialuaclient)
    - [media/lua/server/](#medialuaserver)
    - [media/lua/shared/](#medialuashared)
    - [media/lua/shared/Translate/](#medialuasharedtranslate)
    - [media/lua/shared/Translate/\<language\>/](#medialuasharedtranslatelanguage)
    - [media/scripts](#mediascripts)
      - [Items](#items)
      - [Recipes](#recipes)
      - [Vehicles](#vehicles)
    - [sound/](#sound)
    - [textures/](#textures)


## Where do I put my mods?

```
C:\Users\<user>\Zomboid\mods
```

## Where are the mods I downloaded in steam?

```
C:\Program Files (x86)\Steam\steamapps\workshop\content\108600
```

## What is the structure of a mod?

```
<mod>/
    mod.info
    poster.png
    media/
        lua/
            client/
            server/
            shared/
                Translate/
                    <language>/
        models_X/
        scripts/
        sound/
        textures/
```

### mod.info

```
id=lstc
name=Let's See The Code
description=Let's See The Code
poster=poster.png
url=https://github.com/letsseethecode/zomboid_mods/
requires=modoptions
```

### media/
### media/lua/

All of your LUA code will go into the sub-directories outlined here.

### media/lua/client/

The `.lua` scripts you add into this directory will be exectued on the client.

### media/lua/server/

The `.lua` scripts you add into this directry will be executed on the server.

### media/lua/shared/

The `.lua` scripts you add into this directory can be imported into the `client`
or `server` directories.

### media/lua/shared/Translate/

This contains all the translations that you mod will use.  Translations can be
loaded using the `getText()` function.

### media/lua/shared/Translate/&lt;language&gt;/

Translations use the standard 2-digit ISO language codes.  e.g. `EN`, `FR`, `DE`, etc.  Note that all the files contained within must share the same language code.

Note that the translation files have specific naming conventions, based upon when they are loaded.  So it's important you use the correct files.
```
UI_<language>.txt
UI_IG_<language>.txt
Recipes_<language>.txt
News_<language>.txt
Items_<language>.txt
MakeUp_<language>.txt
Moodles_<language>.txt

TODO! add the rest
```

The contents of the files look like this

```
<filename_without_the_extension> = {
    <key1> = "<value1>",
    <key2> = "<value2>",
    <key3> = "<value3>",
}
```

e.g. 

```
UI_EN = {
    Foo = "Foo",
    Bar = "Bar",
}
```
and
```
UI_FR = {
    Foo = "le Foo",
    Bar = "la Bar",
}
```

EXCEPT for UI_IG, which is borked!!

```
UIIG_EN = {
    Foo = "Foo",
    Bar = "Bar",
}
```

### media/scripts

TODO!

#### Items

TODO!

#### Recipes

TODO!

#### Vehicles

TODO!

### sound/

TODO!

### textures/

TODO!
