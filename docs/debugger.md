# Debugger

## How do I access it?

Zomboid has a built in Debugger which can be accessed using `F11`.

## Can I add breakpoints?

Yes, you can locate the file you're interested in and double-click the line you
want to create the break-point on.  The debugger will automatically stop when
it reaches this point.

## How do I inspect variables?

To be honest, I haven't found a way.  The best thing I've found to do is to
allocate a `local` variable.  Then the value appears in the `LOCALS` at the 
top-left of the screen.

## How do I make changes to files?

Use you preferred editor, and then in the debugger open the file you're 
interested in.  At the bottom of the file is `reload File` button.