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

-- AI Generated at 05/08/2026 - 10:42 PM

--!nocheck
--!native

local Interpreter = require(script.interpreter.Value)

local Main = {}

Main.nativeAliases = {
	PRINTSTRING = "print",
	PRINTSTR = "print",
	PRINTINT = "print",
	PRINTFLOAT = "print",
	PRINTNL = "print",
	VMAG = "Vector3Magnitude",
}

function Main.defaultEnvironment()
	return {
		Vector3 = rawget(getfenv(), "Vector3"),
		print = print,
		natives = {},
	}
end

function Main.defaultNatives(environment)
	environment = environment or Main.defaultEnvironment()
	local printFn = environment.print or print
	local vector3 = environment.Vector3
	return {
		PRINTSTRING = function(value)
			printFn(value)
		end,
		PRINTSTR = function(value)
			printFn(value)
		end,
		PRINTINT = function(value)
			printFn(value)
		end,
		PRINTFLOAT = function(value)
			printFn(value)
		end,
		PRINTNL = function()
			printFn("")
		end,
		TO_FLOAT = function(value)
			return value
		end,
		TO_INTEGER = function(value)
			return value
		end,
		VMAG = function(x, y, z)
			if vector3 and vector3.new then
				return vector3.new(x, y, z).Magnitude
			end
			return math.sqrt(x * x + y * y + z * z)
		end,
	}
end

function Main.createInterpreter(compiled, environment)
	environment = environment or Main.defaultEnvironment()
	local natives = Main.defaultNatives(environment)
	for name, fn in pairs(environment.natives or {}) do
		natives[string.upper(name)] = fn
	end
	return Interpreter.new(compiled, {
		natives = natives,
	})
end

function Main.run(compiled, environment)
	local vm = Main.createInterpreter(compiled, environment)
	return vm:run()
end

function Main.describeProgram(compiled)
	return {
		bytecode = compiled.bytes,
		stringHeap = compiled.stringHeap,
		locals = compiled.locals,
		statics = compiled.statics,
		globals = compiled.globals,
		nativeSlots = compiled.nativeSlots,
		nativeAliases = Main.nativeAliases,
	}
end

return Main