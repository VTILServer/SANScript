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

--!nocheck
--!native

local Module = require(script.LOADER)
local Deps = require(script.DEPS)

local Compiler = Module.compiler
local Main = Module.Main

local test = Compiler.compile([[
USING "builtins.sch"

SCRIPT

	// Should print AAAAAAAAAAAAAAAAAA
	PRINTSTR ("AAAAAAAAAAAAAAAAAA")

ENDSCRIPT
]], Deps)

Main.run(test, false)