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

-- AI Generated at 05/08/2026 - 12:45 AM

--!nocheck
--!native

local OP = {
	NOP = 0,
	IADD = 1,
	ISUB = 2,
	IMUL = 3,
	IDIV = 4,
	IMOD = 5,
	INOT = 6,
	INEG = 7,
	IEQ = 8,
	INE = 9,
	IGT = 10,
	IGE = 11,
	ILT = 12,
	ILE = 13,
	FADD = 14,
	FSUB = 15,
	FMUL = 16,
	FDIV = 17,
	FMOD = 18,
	FNEG = 19,
	FEQ = 20,
	FNE = 21,
	FGT = 22,
	FGE = 23,
	FLT = 24,
	FLE = 25,
	VADD = 26,
	VSUB = 27,
	VMUL = 28,
	VDIV = 29,
	VNEG = 30,
	IAND = 31,
	IOR = 32,
	IXOR = 33,
	I2F = 34,
	F2I = 35,
	F2V = 36,
	PUSH_CONST_U8 = 37,
	PUSH_CONST_U8_U8 = 38,
	PUSH_CONST_U8_U8_U8 = 39,
	PUSH_CONST_U32 = 40,
	PUSH_CONST_F = 41,
	DUP = 42,
	DROP = 43,
	NATIVE = 44,
	ENTER = 45,
	LEAVE = 46,
	LOAD = 47,
	STORE = 48,
	STORE_REV = 49,
	LOAD_N = 50,
	STORE_N = 51,
	ARRAY_U8 = 52,
	ARRAY_U8_LOAD = 53,
	ARRAY_U8_STORE = 54,
	LOCAL_U8 = 55,
	LOCAL_U8_LOAD = 56,
	LOCAL_U8_STORE = 57,
	STATIC_U8 = 58,
	STATIC_U8_LOAD = 59,
	STATIC_U8_STORE = 60,
	IADD_U8 = 61,
	IMUL_U8 = 62,
	IOFFSET = 63,
	IOFFSET_U8 = 64,
	IOFFSET_U8_LOAD = 65,
	IOFFSET_U8_STORE = 66,
	PUSH_CONST_S16 = 67,
	IADD_S16 = 68,
	IMUL_S16 = 69,
	IOFFSET_S16 = 70,
	IOFFSET_S16_LOAD = 71,
	IOFFSET_S16_STORE = 72,
	ARRAY_U16 = 73,
	ARRAY_U16_LOAD = 74,
	ARRAY_U16_STORE = 75,
	LOCAL_U16 = 76,
	LOCAL_U16_LOAD = 77,
	LOCAL_U16_STORE = 78,
	STATIC_U16 = 79,
	STATIC_U16_LOAD = 80,
	STATIC_U16_STORE = 81,
	GLOBAL_U16 = 82,
	GLOBAL_U16_LOAD = 83,
	GLOBAL_U16_STORE = 84,
	J = 85,
	JZ = 86,
	IEQ_JZ = 87,
	INE_JZ = 88,
	IGT_JZ = 89,
	IGE_JZ = 90,
	ILT_JZ = 91,
	ILE_JZ = 92,
	CALL = 93,
	STATIC_U24 = 94,
	STATIC_U24_LOAD = 95,
	STATIC_U24_STORE = 96,
	GLOBAL_U24 = 97,
	GLOBAL_U24_LOAD = 98,
	GLOBAL_U24_STORE = 99,
	PUSH_CONST_U24 = 100,
	SWITCH = 101,
	STRING = 102,
	STRINGHASH = 103,
	TEXT_LABEL_ASSIGN_STRING = 104,
	TEXT_LABEL_ASSIGN_INT = 105,
	TEXT_LABEL_APPEND_STRING = 106,
	TEXT_LABEL_APPEND_INT = 107,
	TEXT_LABEL_COPY = 108,
	CATCH = 109,
	THROW = 110,
	CALLINDIRECT = 111,
	PUSH_CONST_M1 = 112,
	PUSH_CONST_0 = 113,
	PUSH_CONST_1 = 114,
	PUSH_CONST_2 = 115,
	PUSH_CONST_3 = 116,
	PUSH_CONST_4 = 117,
	PUSH_CONST_5 = 118,
	PUSH_CONST_6 = 119,
	PUSH_CONST_7 = 120,
	PUSH_CONST_FM1 = 121,
	PUSH_CONST_F0 = 122,
	PUSH_CONST_F1 = 123,
	PUSH_CONST_F2 = 124,
	PUSH_CONST_F3 = 125,
	PUSH_CONST_F4 = 126,
	PUSH_CONST_F5 = 127,
	PUSH_CONST_F6 = 128,
	PUSH_CONST_F7 = 129,
	IS_BIT_SET = 130,
}

local Interpreter = {}
Interpreter.__index = Interpreter

local opcodeNames = {}
for name, value in pairs(OP) do
	opcodeNames[value] = name
end

local function band32(value)
	return bit32.band(value, 0xffffffff)
end

local function signed16(value)
	if value >= 0x8000 then
		return value - 0x10000
	end
	return value
end

local function defaultValue(value)
	if value == nil then
		return 0
	end
	return value
end

local function stackPop(stack)
	local value = stack[#stack]
	stack[#stack] = nil
	return defaultValue(value)
end

local function stackPush(stack, value)
	stack[#stack + 1] = defaultValue(value)
end

local function readString(heap, offset)
	local out = {}
	local index = offset + 1
	while index <= #heap and heap[index] ~= 0 do
		out[#out + 1] = string.char(heap[index])
		index += 1
	end
	return table.concat(out)
end

local function storageWords(order)
	local count = 0
	for _, item in ipairs(order or {}) do
		count += item.size or 1
	end
	return count
end

function Interpreter.new(compiled, options)
	options = options or {}
	local nativeNamesBySlot = {}
	for name, slot in pairs(compiled.nativeSlots or {}) do
		nativeNamesBySlot[slot] = name
	end
	local nativeHashesBySlot = {}
	if compiled.programImage and compiled.programImage.nativeHashes then
		for index, hash in ipairs(compiled.programImage.nativeHashes) do
			nativeHashesBySlot[index - 1] = hash
		end
	end
	local self = setmetatable({
		bytes = compiled.bytes,
		stringHeap = compiled.stringHeap or {},
		natives = options.natives or {},
		nativeNamesBySlot = nativeNamesBySlot,
		nativeHashesBySlot = nativeHashesBySlot,
		stack = {},
		frames = {},
		statics = table.create(storageWords(compiled.statics), 0),
		globals = table.create(storageWords(compiled.globals), 0),
		pc = 0,
		done = false,
		yielded = false,
		yieldValue = nil,
		stepCount = 0,
		maxSteps = options.maxSteps or 100000,
		trace = options.trace == true,
		traceLog = {},
		catchFrame = nil,
	}, Interpreter)
	self:pushFrame(-1)
	return self
end

function Interpreter:pushFrame(returnPc)
	self.frames[#self.frames + 1] = {
		returnPc = returnPc,
		locals = {},
	}
end

function Interpreter:frame()
	return self.frames[#self.frames]
end

function Interpreter:byte()
	local value = self.bytes[self.pc + 1]
	if value == nil then
		error("Bytecode read past end at pc " .. tostring(self.pc))
	end
	self.pc += 1
	return value
end

function Interpreter:u16()
	return bit32.bor(bit32.lshift(self:byte(), 8), self:byte())
end

function Interpreter:s16()
	return signed16(self:u16())
end

function Interpreter:u24()
	return bit32.bor(bit32.lshift(self:byte(), 16), bit32.lshift(self:byte(), 8), self:byte())
end

function Interpreter:u32()
	return bit32.bor(bit32.lshift(self:byte(), 24), bit32.lshift(self:byte(), 16), bit32.lshift(self:byte(), 8), self:byte())
end

function Interpreter:f32()
	local packed = buffer.create(4)
	buffer.writeu32(packed, 0, self:u32())
	return buffer.readf32(packed, 0)
end

function Interpreter:push(value)
	stackPush(self.stack, value)
end

function Interpreter:pop()
	return stackPop(self.stack)
end

function Interpreter:readAddress(address)
	if type(address) ~= "table" then
		error("Expected address on stack")
	end
	local store = address.space == "local" and self:frame().locals or address.space == "static" and self.statics or self.globals
	return defaultValue(store[address.offset + 1])
end

function Interpreter:writeAddress(address, value)
	if type(address) ~= "table" then
		error("Expected address on stack")
	end
	local store = address.space == "local" and self:frame().locals or address.space == "static" and self.statics or self.globals
	store[address.offset + 1] = defaultValue(value)
end

function Interpreter:address(space, offset)
	self:push({ space = space, offset = offset })
end

function Interpreter:jump(relative)
	self.pc += relative
end

function Interpreter:binary(fn)
	local right = self:pop()
	local left = self:pop()
	self:push(fn(left, right))
end

function Interpreter:unary(fn)
	self:push(fn(self:pop()))
end

function Interpreter:enter()
	local paramCount = self:byte()
	local localCount = self:u16()
	self:byte()
	local frame = self:frame()
	for index = localCount - 1, 0, -1 do
		frame.locals[index + 1] = 0
	end
	for index = paramCount - 1, 0, -1 do
		frame.locals[index + 1] = self:pop()
	end
end

function Interpreter:leave()
	local _paramCount = self:byte()
	local returnCount = self:byte()
	local returns = table.create(returnCount)
	for index = returnCount, 1, -1 do
		returns[index] = self:pop()
	end
	local frame = self:frame()
	self.frames[#self.frames] = nil
	if frame.returnPc < 0 or #self.frames == 0 then
		self.done = true
		for _, value in ipairs(returns) do
			self:push(value)
		end
		return
	end
	self.pc = frame.returnPc
	for _, value in ipairs(returns) do
		self:push(value)
	end
end

function Interpreter:nativeCall(paramReturn, slot)
	local returnSize = bit32.band(paramReturn, 3)
	local paramSize = bit32.rshift(paramReturn, 2)
	local args = table.create(paramSize)
	for index = paramSize, 1, -1 do
		args[index] = self:pop()
	end
	local name = self.nativeNamesBySlot[slot]
	local fn = name and self.natives[name] or self.natives[slot] or self.natives[self.nativeHashesBySlot[slot]]
	local result
	if fn then
		result = fn(table.unpack(args))
	elseif name == "WAIT" then
		self.yielded = true
		self.yieldValue = args[1] or 0
		result = nil
	elseif name == "TO_FLOAT" or name == "TO_INTEGER" then
		result = args[1] or 0
	elseif name == "VMAG" then
		local x, y, z = args[1] or 0, args[2] or 0, args[3] or 0
		result = math.sqrt(x * x + y * y + z * z)
	elseif returnSize > 0 then
		result = 0
	end
	if returnSize == 1 then
		self:push(result)
	elseif returnSize > 1 then
		if type(result) == "table" then
			for index = 1, returnSize do
				self:push(result[index] or 0)
			end
		else
			self:push(result or 0)
			for _ = 2, returnSize do
				self:push(0)
			end
		end
	end
end

function Interpreter:throw(value)
	if not self.catchFrame then
		error("Unhandled script THROW " .. tostring(value))
	end
	while #self.frames > self.catchFrame.frameDepth do
		self.frames[#self.frames] = nil
	end
	self.pc = self.catchFrame.pc
	self.stack = {}
	self:push(value)
end

function Interpreter:step()
	if self.done or self.yielded then
		return
	end
	self.stepCount += 1
	if self.stepCount > self.maxSteps then
		error("Interpreter exceeded maxSteps")
	end
	local pcBefore = self.pc
	local op = self:byte()
	if self.trace then
		self.traceLog[#self.traceLog + 1] = string.format("%04d %s", pcBefore, opcodeNames[op] or tostring(op))
	end

	if op == OP.NOP then
		return
	elseif op == OP.IADD then
		self:binary(function(a, b) return a + b end)
	elseif op == OP.ISUB then
		self:binary(function(a, b) return a - b end)
	elseif op == OP.IMUL then
		self:binary(function(a, b) return a * b end)
	elseif op == OP.IDIV then
		self:binary(function(a, b) return math.floor(a / b) end)
	elseif op == OP.IMOD then
		self:binary(function(a, b) return a % b end)
	elseif op == OP.INOT then
		self:unary(function(a) return a == 0 and 1 or 0 end)
	elseif op == OP.INEG then
		self:unary(function(a) return -a end)
	elseif op == OP.IEQ then
		self:binary(function(a, b) return a == b and 1 or 0 end)
	elseif op == OP.INE then
		self:binary(function(a, b) return a ~= b and 1 or 0 end)
	elseif op == OP.IGT then
		self:binary(function(a, b) return a > b and 1 or 0 end)
	elseif op == OP.IGE then
		self:binary(function(a, b) return a >= b and 1 or 0 end)
	elseif op == OP.ILT then
		self:binary(function(a, b) return a < b and 1 or 0 end)
	elseif op == OP.ILE then
		self:binary(function(a, b) return a <= b and 1 or 0 end)
	elseif op == OP.FADD or op == OP.VADD then
		self:binary(function(a, b) return a + b end)
	elseif op == OP.FSUB or op == OP.VSUB then
		self:binary(function(a, b) return a - b end)
	elseif op == OP.FMUL or op == OP.VMUL then
		self:binary(function(a, b) return a * b end)
	elseif op == OP.FDIV or op == OP.VDIV then
		self:binary(function(a, b) return a / b end)
	elseif op == OP.FMOD then
		self:binary(function(a, b) return a % b end)
	elseif op == OP.FNEG or op == OP.VNEG then
		self:unary(function(a) return -a end)
	elseif op == OP.FEQ then
		self:binary(function(a, b) return a == b and 1 or 0 end)
	elseif op == OP.FNE then
		self:binary(function(a, b) return a ~= b and 1 or 0 end)
	elseif op == OP.FGT then
		self:binary(function(a, b) return a > b and 1 or 0 end)
	elseif op == OP.FGE then
		self:binary(function(a, b) return a >= b and 1 or 0 end)
	elseif op == OP.FLT then
		self:binary(function(a, b) return a < b and 1 or 0 end)
	elseif op == OP.FLE then
		self:binary(function(a, b) return a <= b and 1 or 0 end)
	elseif op == OP.IAND then
		self:binary(function(a, b) return bit32.band(a, b) end)
	elseif op == OP.IOR then
		self:binary(function(a, b) return bit32.bor(a, b) end)
	elseif op == OP.IXOR then
		self:binary(function(a, b) return bit32.bxor(a, b) end)
	elseif op == OP.I2F or op == OP.F2I or op == OP.F2V then
		return
	elseif op == OP.PUSH_CONST_U8 then
		self:push(self:byte())
	elseif op == OP.PUSH_CONST_U8_U8 then
		self:push(self:byte())
		self:push(self:byte())
	elseif op == OP.PUSH_CONST_U8_U8_U8 then
		self:push(self:byte())
		self:push(self:byte())
		self:push(self:byte())
	elseif op == OP.PUSH_CONST_U32 then
		self:push(self:u32())
	elseif op == OP.PUSH_CONST_F then
		self:push(self:f32())
	elseif op == OP.DUP then
		self:push(self.stack[#self.stack])
	elseif op == OP.DROP then
		self:pop()
	elseif op == OP.NATIVE then
		local paramReturn = self:byte()
		local slot = self:u16()
		self:nativeCall(paramReturn, slot)
	elseif op == OP.ENTER then
		self:enter()
	elseif op == OP.LEAVE then
		self:leave()
	elseif op == OP.LOAD then
		self:push(self:readAddress(self:pop()))
	elseif op == OP.STORE then
		local address = self:pop()
		self:writeAddress(address, self:pop())
	elseif op == OP.STORE_REV then
		local value = self:pop()
		local address = self:pop()
		self:writeAddress(address, value)
	elseif op == OP.LOAD_N then
		local address = self:pop()
		local count = self:pop()
		for index = 0, count - 1 do
			self:push(self:readAddress({ space = address.space, offset = address.offset + index }))
		end
	elseif op == OP.STORE_N then
		local address = self:pop()
		local count = self:pop()
		local values = table.create(count)
		for index = count, 1, -1 do
			values[index] = self:pop()
		end
		for index = 1, count do
			self:writeAddress({ space = address.space, offset = address.offset + index - 1 }, values[index])
		end
	elseif op == OP.ARRAY_U8 or op == OP.ARRAY_U8_LOAD or op == OP.ARRAY_U8_STORE then
		local elemSize = self:byte()
		local index = self:pop()
		local address = self:pop()
		local indexed = { space = address.space, offset = address.offset + 1 + index * elemSize }
		if op == OP.ARRAY_U8_LOAD then
			self:push(self:readAddress(indexed))
		elseif op == OP.ARRAY_U8_STORE then
			self:writeAddress(indexed, self:pop())
		else
			self:push(indexed)
		end
	elseif op == OP.ARRAY_U16 or op == OP.ARRAY_U16_LOAD or op == OP.ARRAY_U16_STORE then
		local elemSize = self:u16()
		local index = self:pop()
		local address = self:pop()
		local indexed = { space = address.space, offset = address.offset + 1 + index * elemSize }
		if op == OP.ARRAY_U16_LOAD then
			self:push(self:readAddress(indexed))
		elseif op == OP.ARRAY_U16_STORE then
			self:writeAddress(indexed, self:pop())
		else
			self:push(indexed)
		end
	elseif op == OP.LOCAL_U8 or op == OP.LOCAL_U8_LOAD or op == OP.LOCAL_U8_STORE then
		local offset = self:byte()
		local address = { space = "local", offset = offset }
		if op == OP.LOCAL_U8_LOAD then
			self:push(self:readAddress(address))
		elseif op == OP.LOCAL_U8_STORE then
			self:writeAddress(address, self:pop())
		else
			self:push(address)
		end
	elseif op == OP.LOCAL_U16 or op == OP.LOCAL_U16_LOAD or op == OP.LOCAL_U16_STORE then
		local offset = self:u16()
		local address = { space = "local", offset = offset }
		if op == OP.LOCAL_U16_LOAD then
			self:push(self:readAddress(address))
		elseif op == OP.LOCAL_U16_STORE then
			self:writeAddress(address, self:pop())
		else
			self:push(address)
		end
	elseif op == OP.STATIC_U8 or op == OP.STATIC_U8_LOAD or op == OP.STATIC_U8_STORE then
		local offset = self:byte()
		local address = { space = "static", offset = offset }
		if op == OP.STATIC_U8_LOAD then
			self:push(self:readAddress(address))
		elseif op == OP.STATIC_U8_STORE then
			self:writeAddress(address, self:pop())
		else
			self:push(address)
		end
	elseif op == OP.STATIC_U16 or op == OP.STATIC_U16_LOAD or op == OP.STATIC_U16_STORE then
		local offset = self:u16()
		local address = { space = "static", offset = offset }
		if op == OP.STATIC_U16_LOAD then
			self:push(self:readAddress(address))
		elseif op == OP.STATIC_U16_STORE then
			self:writeAddress(address, self:pop())
		else
			self:push(address)
		end
	elseif op == OP.STATIC_U24 or op == OP.STATIC_U24_LOAD or op == OP.STATIC_U24_STORE then
		local offset = self:u24()
		local address = { space = "static", offset = offset }
		if op == OP.STATIC_U24_LOAD then
			self:push(self:readAddress(address))
		elseif op == OP.STATIC_U24_STORE then
			self:writeAddress(address, self:pop())
		else
			self:push(address)
		end
	elseif op == OP.GLOBAL_U16 or op == OP.GLOBAL_U16_LOAD or op == OP.GLOBAL_U16_STORE then
		local offset = self:u16()
		local address = { space = "global", offset = offset }
		if op == OP.GLOBAL_U16_LOAD then
			self:push(self:readAddress(address))
		elseif op == OP.GLOBAL_U16_STORE then
			self:writeAddress(address, self:pop())
		else
			self:push(address)
		end
	elseif op == OP.GLOBAL_U24 or op == OP.GLOBAL_U24_LOAD or op == OP.GLOBAL_U24_STORE then
		local offset = self:u24()
		local address = { space = "global", offset = offset }
		if op == OP.GLOBAL_U24_LOAD then
			self:push(self:readAddress(address))
		elseif op == OP.GLOBAL_U24_STORE then
			self:writeAddress(address, self:pop())
		else
			self:push(address)
		end
	elseif op == OP.IADD_U8 then
		self:push(self:pop() + self:byte())
	elseif op == OP.IMUL_U8 then
		self:push(self:pop() * self:byte())
	elseif op == OP.IOFFSET or op == OP.IOFFSET_U8 or op == OP.IOFFSET_U8_LOAD or op == OP.IOFFSET_U8_STORE or op == OP.IOFFSET_S16 or op == OP.IOFFSET_S16_LOAD or op == OP.IOFFSET_S16_STORE then
		local offset
		if op == OP.IOFFSET_U8 or op == OP.IOFFSET_U8_LOAD or op == OP.IOFFSET_U8_STORE then
			offset = self:byte()
		elseif op == OP.IOFFSET_S16 or op == OP.IOFFSET_S16_LOAD or op == OP.IOFFSET_S16_STORE then
			offset = self:s16()
		else
			offset = self:pop()
		end
		local address = self:pop()
		local shifted = { space = address.space, offset = address.offset + offset }
		if op == OP.IOFFSET_U8_LOAD or op == OP.IOFFSET_S16_LOAD then
			self:push(self:readAddress(shifted))
		elseif op == OP.IOFFSET_U8_STORE or op == OP.IOFFSET_S16_STORE then
			self:writeAddress(shifted, self:pop())
		else
			self:push(shifted)
		end
	elseif op == OP.IADD_S16 then
		self:push(self:pop() + self:s16())
	elseif op == OP.IMUL_S16 then
		self:push(self:pop() * self:s16())
	elseif op == OP.J then
		self:jump(self:s16())
	elseif op == OP.JZ then
		local relative = self:s16()
		if self:pop() == 0 then
			self:jump(relative)
		end
	elseif op == OP.IEQ_JZ or op == OP.INE_JZ or op == OP.IGT_JZ or op == OP.IGE_JZ or op == OP.ILT_JZ or op == OP.ILE_JZ then
		local relative = self:s16()
		local right = self:pop()
		local left = self:pop()
		local ok = (op == OP.IEQ_JZ and left == right)
			or (op == OP.INE_JZ and left ~= right)
			or (op == OP.IGT_JZ and left > right)
			or (op == OP.IGE_JZ and left >= right)
			or (op == OP.ILT_JZ and left < right)
			or (op == OP.ILE_JZ and left <= right)
		if not ok then
			self:jump(relative)
		end
	elseif op == OP.CALL then
		local target = self:u24()
		self:pushFrame(self.pc)
		self.pc = target
	elseif op == OP.PUSH_CONST_U24 then
		self:push(self:u24())
	elseif op == OP.SWITCH then
		local value = self:pop()
		local count = self:byte()
		local target = nil
		for _ = 1, count do
			local match = self:u32()
			local offsetPc = self.pc
			local relative = self:s16()
			if target == nil and band32(value) == match then
				target = offsetPc + 2 + relative
			end
		end
		if target ~= nil then
			self.pc = target
		end
	elseif op == OP.STRING then
		self:push(readString(self.stringHeap, self:pop()))
	elseif op == OP.STRINGHASH then
		self:push(0)
	elseif op == OP.CATCH then
		self.catchFrame = { pc = self.pc, frameDepth = #self.frames }
		self:push(-1)
	elseif op == OP.THROW then
		self:throw(self:pop())
	elseif op == OP.CALLINDIRECT then
		error("CALLINDIRECT is not implemented in the Luau interpreter yet")
	elseif op == OP.PUSH_CONST_M1 then
		self:push(-1)
	elseif op >= OP.PUSH_CONST_0 and op <= OP.PUSH_CONST_7 then
		self:push(op - OP.PUSH_CONST_0)
	elseif op == OP.PUSH_CONST_FM1 then
		self:push(-1)
	elseif op >= OP.PUSH_CONST_F0 and op <= OP.PUSH_CONST_F7 then
		self:push(op - OP.PUSH_CONST_F0)
	elseif op == OP.IS_BIT_SET then
		local bit = self:pop()
		local value = self:pop()
		self:push(bit32.band(value, bit32.lshift(1, bit)) ~= 0 and 1 or 0)
	else
		error("Unsupported opcode " .. tostring(opcodeNames[op] or op) .. " at pc " .. tostring(pcBefore))
	end
end

function Interpreter:run(maxSteps)
	if maxSteps then
		self.maxSteps = maxSteps
	end
	while not self.done and not self.yielded do
		self:step()
	end
	return self
end

function Interpreter:resume()
	self.yielded = false
	self.yieldValue = nil
	return self:run()
end

function Interpreter.execute(compiled, options)
	local vm = Interpreter.new(compiled, options)
	return vm:run()
end

return Interpreter