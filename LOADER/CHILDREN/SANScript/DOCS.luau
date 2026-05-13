-- NOT AI GENERATED --
-- NOT AI GENERATED --
-- NOT AI GENERATED --
-- NOT AI GENERATED --

--==================================== NOTICE ====================================--
--[[
	Copyright (c) Rockstar Games 2005. All rights reserved.


	Rockstar North aka RSG:N alot of times cross refrence gta and RSG:N in the same-
		context and even in the same place.

	I, Ricky Page (ErringPaladin10@VTILServer.com) have made it a bit easier to-
		see those spots, so at each number(d) spot below can be flipped for example:
			GTA -> Rockstar North
			Rockstar North -> GTA
		This just makes it easier to read.

	1) Rockstar North
	2) Grand Theft Auto (GTA)
--]]
--==================================== NOTICE ====================================--

--[[
	Copyright (c) Rockstar Games 2005. All rights reserved.

	If you are going to use this in ANY of your projects in ANY non-commercial
cases — PLEASE include the original copyright notice. This code is not
originally authored by contributors to this repository and retains the
following legal terms:

	https://www.rockstargames.com/legal
	https://www.rockstargames.com/privacy

	https://www.take2games.com/legal
	https://www.take2games.com/privacy
--]]


return [[
						Copyright (c) Rockstar Games 2005. All rights reserved.
									Rage Scripting Language

1 User Manual
  The scripting language is based upon the GTA(1) scripting language. It is a simple imperative language which
  looks a lot like BASIC.

1.1 Comments
  You can do comments to end-of-line with //. You can bracket multi-line comments in /* and */.

1.2 Variable Declarations
  Note that our lexer is not case-sensitive. You can use GET_ACTOR_POSITION or get_actor_position interchangeably.

  All variable declarations must start with a typename. The common typenames are:

  • INT - Basic integer type (whole numbers only).
  • FLOAT - Basic floating-point type (decimal numbers).
  • BOOL - A special variable that only holds either TRUE or FALSE. The value of any expression used in IF or WHILE should
    be a BOOL.
  • TEXT_LABEL - A short string up to fifteen letters long. Typically used for referencing a localized string.
  • VECTOR - A structure containing X, Y, and Z fields which represent a floating-point position in space.
  Any variable declared within a SCRIPT / ENDSCRIPT, PROC / ENDPROC, or FUNC / ENDFUNC block is local and is
  unique to that particular script (strictly speaking it is unique to the thread owning the script, so if the same script is attached
  to multiple objects they all have their own local variables).

  Variables may be declared in a special GLOBALS / ENDGLOBALS block, in which case they are true global variables that
  are shared amongst all scripts. There can only be one GLOBALS block per script; it is intended to be placed inside a USING
  file so that all scripts can see the same master list of globals. In fact, there can only be a single GLOBALS block for all
  scripts in the game; this keeps all globals in a central place and allows the compiler to still assign static addresses.

  Any variable declared outside any blocks and also not within a GLOBALS / ENDGLOBALS block is shared amongst all
  instances of that script; this is like a static member variable in C++.

  All variables are initialized to zero on creation. You may explicitly initialize any local variable to any valid expression. You can
  declare more than one variable at once by separating the names with commas.
  INT A, B // Declare two local variables initialize to zero
  FLOAT C = 1.23 // Declare a local variable and initialize it.
  VECTOR Pos = << C+2, 5, 2 >> // Note the special syntax for vector literals
  Global and static variables can be initialized as well, but only to constant expressions (if they are integers) or constant
  numbers (if they are floating-point).

  When you wish to change the value of a variable after its creation you just assign a new value:
  A = A + 1
  Pos.y = Pos.y + 9.8
  You cannot assign directly between INT and FLOAT variables. To assign a FLOAT to an INT, call the CEIL, FLOOR, or
  ROUND function. To assign an INT to a FLOAT, call the TO_FLOAT function.

1.5 Special Functions and Commands

  The ++, --, +=, -=, *=, and /= shortcuts from C are available, but they are treated as statements, not expressions. Therefore
  there is no distinction between preincrement or postincrement (since it is impossible to reference the value in an outer
  expression) and either form is accepted.

1.3 Constant Declarations
  You can introduce new constants into the language via the CONST_INT and CONST_FLOAT directives. CONST_INT
  variables in particular can be used anywhere the compiler wants a constant integer, even in CASE labels and array size
  declarations. You cannot declare more than one constant at a time.
  CONST_INT MaxCount 5
  CONST_FLOAT PI 3.14159

1.4 Advanced Variable Declarations
  Some commands declare their own special handle types (like GUID). You can use these types to declare variables;
  however, you can only compare and assign them to variables of the exact same handle type. As a special case, the special
  variable NULL is compatible with all handle types, and is also the default value of any handle variable not explicitly initialized
  to something in particular.

  The purpose of the handle types is to protect you from passing in the wrong type of object into a command.

  You can also declare multi-dimensional arrays of objects. Array elements are accessed starting at element zero. Arrays can
  be useful for holding lists of data such as waypoints or item prices.

  You can introduce new structures (like VECTOR already is) with:
  STRUCT PlayerData
      INT AttackState, Health
      INT AMMO
      FLOAT Chances[4]
  ENDSTRUCT
  Structures may contain basic types or even previously defined nested structures.

  You cannot currently initialize a structure variable when it is first defined; it is zero-filled for you but you have to initialize it
  field-by-field yourself. I added structures in anticipation of minigames being written in the scripting language; I didn't want to
  see lots of parallel arrays being used everywhere.

1.5 Special Functions and Commands
  The TIMERA and TIMERB variables are special INT functions available to every script. They are incremented by the current
  frame step whenever the script is running; for backward compatibility, they are measured in milliseconds. You can change
  their values directly with the SETTIMERA and SETTIMERB commands.

  The TIMESTEP variable is a special FLOAT function available to all scripts; it contains the last time step (typically one or two
  vertical blanking intervals). The TIMESTEP variable is used by the special +@ and -@ operators which automatically
  multiply the right-hand side by the frame time.

  The WAIT command accepts a single int parameter which is the number of milliseconds to block the currently running script.
  WAIT 0 will always block the script for the remainder of the current game frame.

1.8 Flow Control

  Currently the scripting system executes 1000 instructions per frame. If your script doesnt pause then it will run round and
  round its main loop until these are all used up (so stopping any other scripts running until the next frame).
  script
      //Main loop
      WHILE true
          // Do My Stuff Please Mr Script Engine
          WAIT 0
      ENDWHILE
  endscript
  You can also wait at any other point in the script.

  In order to use the TIMERA, TIMERB, SETTIMERA, SETTIMERB, and WAIT commands, you must have an appropriate
  USING statement in your declaration section. For RDR2 this is
  USING "../../scripting/builtins.sc"
  As mentioned elsewhere, NULL is a special variable which is compatible with all handle types.

1.6 Text Labels
  A TEXT_LABEL is a mutable string buffer which can hold up to 15 characters. Its intended use is for dynamically
  constructing localization label names or filenames. A TEXT_LABEL can be passed into any command that accepts a string.
  Use the built-in commands CLEAR_TEXT_LABEL, APPEND_FLOAT, APPEND_INT, and APPEND_STRING to manipulate
  TEXT_LABEL objects. TEXT_LABEL variables are initialized to an empty string by default so the initial
  CLEAR_TEXT_LABEL is optional.

1.7 Enumerations
  You can introduce new enumerants into the language (as typenames):
  ENUM TypeFlag
      TF_DISABLED,
      TF_ENABLED,
      TF_READY
  ENDENUM
  Enumerants are all at global scope, and are only assignment- compatible with themselves. This is particularly useful for
  making command calls more type-safe. There are currently no implicit or explicit conversions between ENUM types and
  other ENUM types or integer types.

  Enumerants will usually be supplied by programmers and will match the internal C++ code values, but designers are free to
  define their own enumerants for clarity as well (for example, for assigning meaningful names to states).

1.8 Flow Control
  Basic decision making is done with the IF statement.
  IF expr
    // if true
  ELSE
    // if false ENDIF
  IF expr

1.9 Procedures and Functions
  The meat of the scripting language is the suite of commands that the game supplies to the designers. These commands are
  broken down into procedures and functions. The only difference is that procedures don't return a value and therefore cannot
  be used in expressions; functions do return a value and can be used in expressions or statements.

  // if true
  ENDIF
  There are three different looping constructs:
  WHILE expr
    // do something while expression is true
  ENDWHILE
  Note that a WHILE statement may not execute even once if the initial value of the expression turns out to be false.
  REPEAT count varname
    // do something 'count ' times
  ENDREPEAT
  The REPEAT statement accepts count and a variable name. The variable is initialized to zero and counts up until it reaches
  the value, which must be an integer literal or constant.
  FOR varname = start TO finish
    // do something
  ENDFOR
  The FOR statement assigns varname to the value of start. While start is less than or equal to finish, it runs the body of the
  loop. After every iteration, it adds one to start and checks again. Note that finish is re-evaluated on every loop iteration so it
  may lead to unexpected behavior if it depends on something changing in the loop itself.
  FOR varname = start TO finish STEP value
    // do something
  ENDFOR
  This form is similar, except that you can count by something other than one. You can also count backwards with a negative
  STEP value, in which case the loop continues as long as varname is greater than or equal to finish. The step value must be
  a nonzero constant integer.

  The next flow control construct is the SWITCH statement.
  SWITCH expr
    CASE 1 //       Do something
      BREAK //      Skip to ENDSWITCH
    CASE 2 //       Do something else
            //      ... and fall through
    CASE 3 //       Do another thing
      BREAK
    DEFAULT //      Go here if no other values matched
  ENDSWITCH
  The expression must evaluate to an integer; CASE labels must be expressions that evaluate to integer constants (including
  enumerants). The BREAK statement allows you to jump to the enclosing ENDSWITCH; otherwise flow will fall through any
  other CASE labels. The DEFAULT label, if present, is used as a catch-all if the expression didn't match any values. You can
  nest SWITCH statements very deep if you really want to, but that could get really confusing quickly.

  The next flow control is the RETURN statement, which simply exits the current script or function, returning a value to the
  caller:
  RETURN N+1
  The final flow control is the EXIT statement, which simply exits the current script or procedure. Internally, EXIT is
  semantically identical to RETURN 0 but is a necessary distinction to avoid parsing ambiguity.
  EXIT

1.12 Why a Custom Language?
  One obvious question is why do we use a custom language instead of an off-the-shelf scripting language. Lua is tiny but
  requires garbage collection and has untyped variables. Python is just too big. The RAGE scripting language is heavily based
  upon the time-proven GTA(2) scripting language. It is strongly typed, and requires no runtime memory allocation for
  the virtual machine itself once a thread is allocated. It is a simple, imperative language that is easy to understand and
  extend. The virtual machine itself is tiny, with the main loop being less than 1000 lines of code.

  All commands require their parameter list to be enclosed in parentheses, even if they don't take any parameters. This is to
  remind you that you're making a function call, because otherwise the syntax is indistiguishable from normal variable access.
  FLOAT T = TIMESTEP()
  FLOAT Angle = ATAN2(Y,X)
  FLOAT Mag = SQRT (X*X + Y*Y + Z*Z)
  CREATE_ACTOR(SomeActor,SomePosition)

1.10 Expressions
  The usual arithmetic operators work: +, -, *, /. % is used for modulo.

  Multiple conditions can be tested at once by using the NOT, AND, and OR operators. You can mix and match them at will,
  but use parentheses for clarity.

1.11 Operator Precedence
  This is mostly for people with Computer Science degrees who are curious.

  All expressions are left-associative except for the unary operators, which are right-associative. From highest precedence to
  lowest: (all operators on the same line have equal precedence)

  • NOT and unary negation.
  • /%
  • + - +@ -@
  • < <= > >= = <>
  • AND
  • OR
  Therefore the expression NOT A OR B AND C evaluates as (NOT A) OR (B AND C), which is probably not obvious to
  anybody, so make sure you use parentheses.

  Note that AND and OR do not short-circuit like they do in C++.

2 Programming Manual
    This section is intended for use by programmers who are adding new commands to the script language itself.

    You declare new commands (where a command is either a function or a procedure) using the NATIVE directive.
    NATIVE FUNC FLOAT ABS(FLOAT F)
    NATIVE PROC PRINTSTRING(STRING S)
    NATIVE FUNC FLOAT ATAN2(FLOAT Y,FLOAT X)
    You can also introduce new handle types into the language with a variant of the NATIVE syntax:
    NATIVE SPRITE
    NATIVE FUNC SPRITE CREATE_SPRITE(STRING Filename)
    The handle types are compatible only with themselves, and help catch more potential problems at compile time.

    You associate the run-time support for a script command by calling
    scrThread::RegisterCommand(commandName,funcPtr) where commandName should match the name of the
    function in the NATIVE declaration. The compiler and the RegisterCommand both use the same hashing algorithm so the
    names will match up.

    The function should be void, accepting a reference to a non-const scrThread::Info object. See the code for specific
    details and examples, but you basically pull the Param values out of the array, operate on them, and then set the Return
    value if necessary. You can also modify the state of the thread so that it will become blocked and return immediately to
    higher-level code. A script that is blocked by a command will immediately re-execute that command the next time it gets
    scheduled.

    There are also some templated wrapper functions in wrapper.h that can simplify integration.
]]