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

return {
	includes = {
		["builtins.sch"] = [[
			NATIVE PROC WAIT(INT milliseconds)
			NATIVE PROC SETTIMERA(INT milliseconds)
			NATIVE PROC PRINTSTRING(STRING value)
			NATIVE PROC PRINTFLOAT(FLOAT value)
			NATIVE FUNC FLOAT VMAG(VECTOR value)


			NATIVE PROC PRINTSTR (STRING S)
			NATIVE PROC PRINTINT (INT I)
			NATIVE PROC PRINTFLOAT (FLOAT F)
			NATIVE PROC PRINTF2 (STRING A, INT B, INT C, INT D)
			NATIVE PROC PRINTNL


			CONST_INT THREAD_PRIO_HIGHEST 0
			CONST_INT THREAD_PRIO_NORMAL 1
			CONST_INT THREAD_PRIO_LOWEST 2
		]],
	},
}