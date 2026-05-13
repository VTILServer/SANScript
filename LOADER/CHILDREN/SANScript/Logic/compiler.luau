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

-- AI Generated at 05/08/2026 - 12:16 AM

--!nolint TableOperations
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

local Compiler = {}

local keywords = {
	AND = true,
	ANDALSO = true,
	BOOL = true,
	BREAK = true,
	BREAKLOOP = true,
	CASE = true,
	CONST_FLOAT = true,
	CONST_INT = true,
	COUNT_OF = true,
	DEFAULT = true,
	ELIF = true,
	ELSE = true,
	ENDSCOPE = true,
	ENDENUM = true,
	ENDGLOBALS = true,
	ENDPROC = true,
	ENDREPEAT = true,
	ENDSCRIPT = true,
	ENDSWITCH = true,
	ENDSTRUCT = true,
	ENDIF = true,
	ENDWHILE = true,
	ENUM = true,
	ENUM_TO_INT = true,
	EXIT = true,
	FALSE = true,
	FALLTHRU = true,
	FLOAT = true,
	ENDFOR = true,
	FOR = true,
	FUNC = true,
	GLOBALS = true,
	GOTO = true,
	HASH = true,
	IF = true,
	INT = true,
	INT_TO_ENUM = true,
	INT_TO_NATIVE = true,
	NATIVE = true,
	NATIVE_TO_INT = true,
	NOT = true,
	OR = true,
	ORELSE = true,
	PROC = true,
	RELOOP = true,
	REPEAT = true,
	RETURN = true,
	SCOPE = true,
	SCRIPT = true,
	SIZE_OF = true,
	STEP = true,
	STRING = true,
	STRINGHASH = true,
	STRUCT = true,
	THROW = true,
	TRUE = true,
	TO = true,
	TEXT_LABEL = true,
	USING = true,
	VECTOR = true,
	WHILE = true,
}

local function makeError(message, token)
	if token then
		return string.format("%s at line %d near '%s'", message, token.line, token.value)
	end
	return message
end

local function addToken(tokens, kind, value, line, column)
	tokens[#tokens + 1] = {
		kind = kind,
		value = value,
		line = line,
		column = column,
	}
end

function Compiler.lex(source)
	local tokens = {}
	local i = 1
	local line = 1
	local column = 1
	local n = #source -- not a bug

	local function peek(offset)
		offset = offset or 0
		return source:sub(i + offset, i + offset)
	end

	local function advance(count)
		count = count or 1
		for _ = 1, count do
			local ch = source:sub(i, i)
			i += 1
			if ch == "\n" then
				line += 1
				column = 1
			else
				column += 1
			end
		end
	end

	while i <= n do
		local ch = peek()
		if ch == " " or ch == "\t" or ch == "\r" then
			advance()
		elseif ch == "\n" then
			advance()
		elseif ch == "/" and peek(1) == "/" then
			while i <= n and peek() ~= "\n" do
				advance()
			end
		elseif ch == "/" and peek(1) == "*" then
			advance(2)
			while i <= n and not (peek() == "*" and peek(1) == "/") do
				advance()
			end
			if i > n then
				error(string.format("Unterminated block comment at line %d", line))
			end
			advance(2)
		elseif ch == '"' then
			local startLine, startColumn = line, column
			advance()
			local parts = {}
			while i <= n and peek() ~= '"' do
				local c = peek()
				if c == "\\" then
					local nextChar = peek(1)
					if nextChar == "n" then
						parts[#parts + 1] = "\n"
					elseif nextChar == "t" then
						parts[#parts + 1] = "\t"
					else
						parts[#parts + 1] = nextChar
					end
					advance(2)
				else
					parts[#parts + 1] = c
					advance()
				end
			end
			if i > n then
				error(string.format("Unterminated string at line %d", startLine))
			end
			advance()
			addToken(tokens, "string", table.concat(parts), startLine, startColumn)
		elseif ch:match("%d") then
			local start, startLine, startColumn = i, line, column
			while peek():match("%d") do
				advance()
			end
			if peek() == "." and peek(1):match("%d") then
				advance()
				while peek():match("%d") do
					advance()
				end
				addToken(tokens, "number", tonumber(source:sub(start, i - 1)), startLine, startColumn)
			else
				addToken(tokens, "number", tonumber(source:sub(start, i - 1)), startLine, startColumn)
			end
		elseif ch:match("[%a_]") then
			local start, startLine, startColumn = i, line, column
			while peek():match("[%w_]") do
				advance()
			end
			local raw = source:sub(start, i - 1)
			local upper = string.upper(raw)
			if keywords[upper] then
				addToken(tokens, "keyword", upper, startLine, startColumn)
			else
				addToken(tokens, "identifier", raw, startLine, startColumn)
			end
		else
			local startLine, startColumn = line, column
			local two = source:sub(i, i + 1)
			if two == ">=" or two == "<=" or two == "!=" or two == "<>" or two == "+=" or two == "-=" or two == "*=" or two == "/=" or two == "==" or two == "+@" or two == "-@" or two == "++" or two == "--" or two == "&=" or two == "|=" or two == "^=" or two == "<<" or two == ">>" then
				addToken(tokens, "symbol", two, startLine, startColumn)
				advance(2)
			else
				addToken(tokens, "symbol", ch, startLine, startColumn)
				advance()
			end
		end
	end

	addToken(tokens, "eof", "<eof>", line, column)
	return tokens
end

local Parser = {}
Parser.__index = Parser

local vectorFields = {
	X = { name = "x", offset = 0, typeName = "FLOAT", size = 1 },
	Y = { name = "y", offset = 1, typeName = "FLOAT", size = 1 },
	Z = { name = "z", offset = 2, typeName = "FLOAT", size = 1 },
}

function Parser.new(tokens)
	return setmetatable({
		tokens = tokens,
		index = 1,
		constants = {},
		types = {
			BOOL = { name = "BOOL", size = 1 },
			FLOAT = { name = "FLOAT", size = 1 },
			INT = { name = "INT", size = 1 },
			STRING = { name = "STRING", size = 1 },
			STRINGHASH = { name = "STRINGHASH", size = 1 },
			TEXT_LABEL = { name = "TEXT_LABEL", size = 4 },
			TEXT_LABEL_3 = { name = "TEXT_LABEL_3", size = 1 },
			TEXT_LABEL_7 = { name = "TEXT_LABEL_7", size = 2 },
			TEXT_LABEL_15 = { name = "TEXT_LABEL_15", size = 4 },
			TEXT_LABEL_23 = { name = "TEXT_LABEL_23", size = 6 },
			TEXT_LABEL_31 = { name = "TEXT_LABEL_31", size = 8 },
			TEXT_LABEL_63 = { name = "TEXT_LABEL_63", size = 16 },
			VECTOR = { name = "VECTOR", size = 3, fields = vectorFields },
		},
		warnings = {},
	}, Parser)
end

function Parser:current()
	return self.tokens[self.index]
end

function Parser:advance()
	local token = self:current()
	self.index += 1
	return token
end

function Parser:match(value)
	if self:current().value == value then
		return self:advance()
	end
	return nil
end

function Parser:expect(value)
	local token = self:current()
	if token.value ~= value then
		error(makeError("Expected " .. value, token))
	end
	return self:advance()
end

function Parser:expectIdentifier()
	local token = self:current()
	if token.kind ~= "identifier" then
		error(makeError("Expected identifier", token))
	end
	return self:advance()
end

local typeSizes = {
	BOOL = 1,
	FLOAT = 1,
	INT = 1,
	STRING = 1,
	STRINGHASH = 1,
	TEXT_LABEL = 4,
	TEXT_LABEL_3 = 1,
	TEXT_LABEL_7 = 2,
	TEXT_LABEL_15 = 4,
	TEXT_LABEL_23 = 6,
	TEXT_LABEL_31 = 8,
	TEXT_LABEL_63 = 16,
	VECTOR = 3,
}

local function simpleHash(name)
	local hash = 0
	local quoted = name:sub(1, 1) == '"'
	if quoted then
		name = name:sub(2)
	end
	for i = 1, #name do
		local character = string.byte(name, i)
		if quoted and character == string.byte('"') then
			break
		end
		if character >= string.byte("A") and character <= string.byte("Z") then
			character += string.byte("a") - string.byte("A")
		elseif character == string.byte("\\") then
			character = string.byte("/")
		end
		hash = bit32.band(hash + character, 0xffffffff)
		hash = bit32.band(hash + bit32.lshift(hash, 10), 0xffffffff)
		hash = bit32.bxor(hash, bit32.rshift(hash, 6))
	end
	hash = bit32.band(hash + bit32.lshift(hash, 3), 0xffffffff)
	hash = bit32.bxor(hash, bit32.rshift(hash, 11))
	hash = bit32.band(hash + bit32.lshift(hash, 15), 0xffffffff)
	if hash < 2 then
		hash += 2
	end
	return hash
end

function Parser:expectType()
	local token = self:advance()
	local key = string.upper(tostring(token.value))
	if (token.kind ~= "keyword" and token.kind ~= "identifier") or not self.types[key] then
		error(makeError("Expected type name", token))
	end
	return key
end

local function node(kind, fields)
	fields = fields or {}
	fields.kind = kind
	return fields
end

function Parser:parse()
	local usings = {}
	local natives = {}
	local statics = {}
	local globals = {}
	local subprograms = {}
	while self:current().value ~= "SCRIPT" and self:current().kind ~= "eof" do
		if self:match("USING") then
			local value = self:current()
			if value.kind == "string" then
				usings[#usings + 1] = self:advance().value
			else
				local parts = {}
				while self:current().kind ~= "eof" and self:current().value ~= "USING" and self:current().value ~= "NATIVE" and self:current().value ~= "SCRIPT" do
					parts[#parts + 1] = tostring(self:advance().value)
				end
				if #parts == 0 then
					error(makeError("Expected include string", value))
				end
				usings[#usings + 1] = table.concat(parts, "")
			end
		elseif self:current().value == "NATIVE" then
			natives[#natives + 1] = self:parseNative()
		elseif self:match("GLOBALS") then
			while self:current().value ~= "ENDGLOBALS" and self:current().kind ~= "eof" do
				globals[#globals + 1] = self:parseDeclaration()
			end
			self:expect("ENDGLOBALS")
		elseif self:current().value == "CONST_INT" or self:current().value == "CONST_FLOAT" then
			self:parseConstant()
		elseif self:current().value == "ENUM" then
			self:parseEnum()
		elseif self:current().value == "STRUCT" then
			self:parseStruct()
		elseif self:current().value == "PROC" or self:current().value == "FUNC" then
			subprograms[#subprograms + 1] = self:parseSubprogram()
		elseif (self:current().kind == "keyword" or self:current().kind == "identifier") and self.types[string.upper(tostring(self:current().value))] then
			statics[#statics + 1] = self:parseDeclaration()
		else
			error(makeError("Unsupported top-level declaration", self:current()))
		end
	end

	self:expect("SCRIPT")
	local body = self:parseBlock({ ENDSCRIPT = true })
	self:expect("ENDSCRIPT")
	return {
		kind = "program",
		usings = usings,
		natives = natives,
		statics = statics,
		globals = globals,
		subprograms = subprograms,
		types = self.types,
		body = body,
		warnings = self.warnings,
	}
end

function Parser:parseEnum()
	self:expect("ENUM")
	local name = self:expectIdentifier().value
	local enum = { name = name, size = 1, enum = true, values = {} }
	self.types[string.upper(name)] = enum
	local nextValue = 0
	while self:current().value ~= "ENDENUM" and self:current().kind ~= "eof" do
		local valueName = self:expectIdentifier().value
		local value
		if self:match("=") then
			local expr = self:parseExpression()
			if expr.kind ~= "number" then
				error(makeError("ENUM value must be constant", self:current()))
			end
			value = expr.value
		else
			value = nextValue
		end
		enum.values[string.upper(valueName)] = value
		self.constants[string.upper(valueName)] = node("number", { value = value })
		nextValue = value + 1
		self:match(",")
	end
	self:expect("ENDENUM")
end

function Parser:parseStruct()
	self:expect("STRUCT")
	local name = self:expectIdentifier().value
	local structType = { name = name, size = 0, fields = {}, struct = true }
	self.types[string.upper(name)] = structType
	while self:current().value ~= "ENDSTRUCT" and self:current().kind ~= "eof" do
		local typeName = self:expectType()
		repeat
			local fieldName = self:expectIdentifier().value
			local arrayCount = nil
			if self:match("[") then
				local count = self:current()
				if count.kind ~= "number" then
					error(makeError("Expected array size", count))
				end
				arrayCount = self:advance().value
				self:expect("]")
			end
			local elemSize = self.types[typeName].size
			local size = arrayCount and (1 + arrayCount * elemSize) or elemSize
			structType.fields[string.upper(fieldName)] = { name = fieldName, offset = structType.size, typeName = typeName, size = size }
			structType.size += size
		until not self:match(",")
	end
	self:expect("ENDSTRUCT")
end

function Parser:parseConstant()
	local isFloat = self:advance().value == "CONST_FLOAT"
	local name = self:expectIdentifier().value
	local expr = self:parseExpression()
	if expr.kind ~= "number" and expr.kind ~= "boolean" then
		error(makeError("Constant value must be a literal in this Luau port slice", self:current()))
	end
	self.constants[string.upper(name)] = node("number", {
		value = expr.kind == "boolean" and (expr.value and 1 or 0) or expr.value,
		isFloat = isFloat,
	})
end

function Parser:parseSubprogram()
	local kind = self:advance().value
	local returnType = nil
	if kind == "FUNC" then
		returnType = self:expectType()
	end
	local name = self:expectIdentifier().value
	self:expect("(")
	local params = {}
	if not self:match(")") then
		repeat
			local typeName = self:expectType()
			local paramName = self:expectIdentifier().value
			params[#params + 1] = { name = paramName, typeName = typeName, size = self.types[typeName].size }
		until not self:match(",")
		self:expect(")")
	end
	local stopper = kind == "FUNC" and "ENDFUNC" or "ENDPROC"
	local body = self:parseBlock({ [stopper] = true })
	self:expect(stopper)
	return { kind = string.lower(kind), name = name, returnType = returnType, params = params, body = body }
end

function Parser:parseNative()
	self:expect("NATIVE")
	if self:current().kind == "identifier" and self.tokens[self.index + 1].kind ~= "identifier" then
		local typeName = self:advance().value
		local key = string.upper(typeName)
		self.types[key] = self.types[key] or { name = typeName, size = 1, nativeType = true }
		if self:match(":") then
			self:expectType()
		end
		return { name = typeName, nativeType = true, returnSize = 0, params = {} }
	end
	local isFunc = self:match("FUNC") ~= nil
	if not isFunc then
		self:expect("PROC")
	end
	local returnSize = 0
	if isFunc then
		local returnType = self:expectType()
		returnSize = self.types[returnType].size
	end
	local name = self:expectIdentifier().value
	local params = {}
	if self:match("(") then
		if not self:match(")") then
			repeat
				local typeName = self:expectType()
				local paramName = self:expectIdentifier().value
				params[#params + 1] = { name = paramName, type = typeName, size = self.types[typeName].size }
			until not self:match(",")
			self:expect(")")
		end
	end
	return { name = name, returnSize = returnSize, params = params }
end

function Parser:parseBlock(stoppers)
	local statements = {}
	while not stoppers[self:current().value] and self:current().kind ~= "eof" do
		statements[#statements + 1] = self:parseStatement()
	end
	return statements
end

function Parser:parseStatement()
	local token = self:current()
	if (token.kind == "keyword" or token.kind == "identifier") and self.types[string.upper(tostring(token.value))] then
		return self:parseDeclaration()
	elseif token.value == "IF" then
		return self:parseIf()
	elseif token.value == "WHILE" then
		return self:parseWhile()
	elseif token.value == "FOR" then
		return self:parseFor()
	elseif token.value == "REPEAT" then
		return self:parseRepeat()
	elseif token.value == "SWITCH" then
		return self:parseSwitch()
	elseif token.value == "SCOPE" then
		self:advance()
		local body = self:parseBlock({ ENDSCOPE = true })
		self:expect("ENDSCOPE")
		return node("block", { body = body })
	elseif token.value == "BREAK" then
		self:advance()
		return node("break")
	elseif token.value == "BREAKLOOP" then
		self:advance()
		return node("breakLoop")
	elseif token.value == "RELOOP" then
		self:advance()
		return node("reloop")
	elseif token.value == "FALLTHRU" then
		self:advance()
		return node("fallthru")
	elseif token.value == "RETURN" then
		self:advance()
		return node("return", { value = self:parseExpression() })
	elseif token.value == "EXIT" then
		self:advance()
		return node("return")
	elseif token.value == "GOTO" then
		self:advance()
		return node("goto", { name = self:expectIdentifier().value })
	elseif token.value == "THROW" then
		self:advance()
		return node("throw", { value = self:parseExpression() })
	elseif token.value == "++" or token.value == "--" then
		local op = self:advance().value == "++" and "+=" or "-="
		return node("assignment", { target = self:parseVariable(), op = op, value = node("number", { value = 1 }) })
	elseif token.kind == "identifier" then
		local nextToken = self.tokens[self.index + 1]
		if nextToken.value == "++" or nextToken.value == "--" then
			local target = self:parseVariable()
			local op = self:advance().value == "++" and "+=" or "-="
			return node("assignment", { target = target, op = op, value = node("number", { value = 1 }) })
		end
		if nextToken.value == ":" then
			local name = self:advance().value
			self:advance()
			return node("label", { name = name })
		end
		if nextToken.value == "(" then
			return self:parseCallStatement()
		end
		return self:parseAssignment()
	end
	error(makeError("Unsupported statement", token))
end

function Parser:parseDeclaration()
	local typeName = string.upper(tostring(self:advance().value))
	local declarations = {}
	repeat
		local name = self:expectIdentifier().value
		local arrayCount = nil
		if self:match("[") then
			local count = self:current()
			if count.kind ~= "number" then
				error(makeError("Expected array size", count))
			end
			arrayCount = self:advance().value
			self:expect("]")
		end
		local init = nil
		if self:match("=") then
			init = self:parseExpression()
		end
		declarations[#declarations + 1] = node("declaration", { name = name, typeName = typeName, arrayCount = arrayCount, init = init })
	until not self:match(",")
	if #declarations == 1 then
		return declarations[1]
	end
	return node("block", { body = declarations })
end

function Parser:parseAssignment()
	local target = self:parseVariable()
	local op = self:advance()
	if op.value ~= "=" and op.value ~= "+=" and op.value ~= "-=" and op.value ~= "*=" and op.value ~= "/=" and op.value ~= "&=" and op.value ~= "|=" and op.value ~= "^=" then
		error(makeError("Expected assignment operator", op))
	end
	local value = self:parseExpression()
	return node("assignment", { target = target, op = op.value, value = value })
end

function Parser:parseCallStatement()
	local call = self:parseCall()
	return node("callStatement", { call = call })
end

function Parser:parseIf()
	self:expect("IF")
	local condition = self:parseExpression()
	local thenBody = self:parseBlock({ ELIF = true, ELSE = true, ENDIF = true })
	local elseBody = self:parseElseTail()
	self:expect("ENDIF")
	return node("if", { condition = condition, thenBody = thenBody, elseBody = elseBody })
end

function Parser:parseElseTail()
	if self:match("ELIF") then
		local condition = self:parseExpression()
		local thenBody = self:parseBlock({ ELIF = true, ELSE = true, ENDIF = true })
		return { node("if", { condition = condition, thenBody = thenBody, elseBody = self:parseElseTail() }) }
	end
	if self:match("ELSE") then
		return self:parseBlock({ ENDIF = true })
	end
	return nil
end

function Parser:parseWhile()
	self:expect("WHILE")
	local condition = self:parseExpression()
	local body = self:parseBlock({ ENDWHILE = true })
	self:expect("ENDWHILE")
	return node("while", { condition = condition, body = body })
end

function Parser:parseFor()
	self:expect("FOR")
	local target = self:parseVariable()
	self:expect("=")
	local initialValue = self:parseExpression()
	self:expect("TO")
	local finalValue = self:parseExpression()
	local step = 1
	if self:match("STEP") then
		local sign = 1
		if self:match("-") then
			sign = -1
		end
		local stepToken = self:current()
		if stepToken.kind ~= "number" or stepToken.value == 0 or stepToken.value ~= math.floor(stepToken.value) then
			error(makeError("FOR STEP must be a nonzero integer literal", stepToken))
		end
		step = sign * self:advance().value
	end
	local body = self:parseBlock({ ENDFOR = true })
	self:expect("ENDFOR")
	return node("for", { target = target, initialValue = initialValue, finalValue = finalValue, step = step, body = body })
end

function Parser:parseRepeat()
	self:expect("REPEAT")
	local count = self:parseExpression()
	local target = self:parseVariable()
	local body = self:parseBlock({ ENDREPEAT = true })
	self:expect("ENDREPEAT")
	return node("repeatLoop", { count = count, target = target, body = body })
end

function Parser:parseSwitch()
	self:expect("SWITCH")
	local expr = self:parseExpression()
	local cases = {}
	local defaultBody = nil
	while self:current().value ~= "ENDSWITCH" and self:current().kind ~= "eof" do
		if self:match("CASE") then
			local value = self:parseExpression()
			local body = self:parseBlock({ CASE = true, DEFAULT = true, ENDSWITCH = true })
			cases[#cases + 1] = { value = value, body = body }
		elseif self:match("DEFAULT") then
			defaultBody = self:parseBlock({ CASE = true, ENDSWITCH = true })
		else
			error(makeError("Expected CASE, DEFAULT, or ENDSWITCH", self:current()))
		end
	end
	self:expect("ENDSWITCH")
	return node("switch", { expr = expr, cases = cases, defaultBody = defaultBody })
end

local precedence = {
	OR = 1,
	ORELSE = 1,
	AND = 2,
	ANDALSO = 2,
	["|"] = 3,
	["^"] = 4,
	["&"] = 5,
	["="] = 6,
	["=="] = 6,
	["!="] = 6,
	["<>"] = 6,
	[">"] = 7,
	[">="] = 7,
	["<"] = 7,
	["<="] = 7,
	["<<"] = 8,
	[">>"] = 8,
	["+"] = 9,
	["+@"] = 9,
	["-"] = 9,
	["-@"] = 9,
	["*"] = 10,
	["/"] = 10,
	["%"] = 10,
}

function Parser:parseExpression(minPrecedence)
	minPrecedence = minPrecedence or 1
	local expr = self:parseUnary()

	while true do
		local op = self:current().value
		local opPrecedence = precedence[op]
		if not opPrecedence or opPrecedence < minPrecedence then
			break
		end
		self:advance()
		local right = self:parseExpression(opPrecedence + 1)
		expr = node("binary", { op = op, left = expr, right = right })
	end

	return expr
end

function Parser:parseUnary()
	local token = self:current()
	if token.value == "-" or token.value == "!" or token.value == "NOT" then
		self:advance()
		return node("unary", { op = token.value, expr = self:parseUnary() })
	end
	return self:parsePrimary()
end

function Parser:parsePrimary()
	local token = self:current()
	if token.kind == "number" then
		self:advance()
		return node("number", { value = token.value, isFloat = tostring(token.value):find("%.") ~= nil })
	elseif token.kind == "string" then
		self:advance()
		return node("string", { value = token.value })
	elseif token.value == "TRUE" or token.value == "FALSE" then
		self:advance()
		return node("boolean", { value = token.value == "TRUE" })
	elseif token.value == "HASH" then
		self:advance()
		self:expect("(")
		local value = self:current()
		if value.kind ~= "string" then
			error(makeError("HASH expects a string literal", value))
		end
		self:advance()
		self:expect(")")
		return node("number", { value = simpleHash(value.value) })
	elseif token.value == "CATCH" then
		self:advance()
		return node("catch")
	elseif token.kind == "identifier" then
		if self.tokens[self.index + 1].value == "(" then
			return self:parseCall()
		end
		local constant = self.constants[string.upper(token.value)]
		if constant then
			self:advance()
			return constant
		end
		return self:parseVariable()
	elseif token.value == "COUNT_OF" then
		self:advance()
		self:expect("(")
		if (self:current().kind == "keyword" or self:current().kind == "identifier") and self.types[string.upper(tostring(self:current().value))] and self.tokens[self.index + 1].value == ")" then
			local typeName = self:expectType()
			self:expect(")")
			return node("countOfType", { typeName = typeName })
		elseif self:current().kind == "identifier" then
			local value = self:parseVariable()
			self:expect(")")
			return node("countOf", { value = value })
		end
		local typeName = self:expectType()
		self:expect(")")
		return node("countOfType", { typeName = typeName })
	elseif token.value == "SIZE_OF" then
		self:advance()
		self:expect("(")
		if (self:current().kind == "keyword" or self:current().kind == "identifier") and self.types[string.upper(tostring(self:current().value))] then
			local typeName = self:expectType()
			self:expect(")")
			return node("sizeOfType", { typeName = typeName })
		end
		local value = self:parseVariable()
		self:expect(")")
		return node("sizeOf", { value = value })
	elseif token.value == "ENUM_TO_INT" or token.value == "NATIVE_TO_INT" then
		self:advance()
		self:expect("(")
		local expr = self:parseExpression()
		self:expect(")")
		return expr
	elseif token.value == "INT_TO_ENUM" or token.value == "INT_TO_NATIVE" then
		self:advance()
		self:expect("(")
		self:expectType()
		self:expect(",")
		local expr = self:parseExpression()
		self:expect(")")
		return expr
	elseif token.value == "<<" or (token.value == "<" and self.tokens[self.index + 1].value == "<") then
		if token.value == "<<" then
			self:advance()
		else
			self:advance()
			self:advance()
		end
		local x = self:parseExpression(11)
		self:expect(",")
		local y = self:parseExpression(11)
		self:expect(",")
		local z = self:parseExpression(11)
		if self:current().value == ">>" then
			self:advance()
		else
			self:expect(">")
			self:expect(">")
		end
		return node("vector", { x = x, y = y, z = z })
	elseif self:match("(") then
		local expr = self:parseExpression()
		self:expect(")")
		return expr
	end
	error(makeError("Expected expression", token))
end

function Parser:parseVariable()
	local name = self:expectIdentifier().value
	local expr = node("variable", { name = name })
	while self:match(".") do
		local field = self:expectIdentifier().value
		expr = node("field", { base = expr, field = field })
	end
	if self:match("[") then
		local index = self:parseExpression()
		self:expect("]")
		expr = node("index", { base = expr, index = index })
	end
	return expr
end

function Parser:parseCall()
	local name = self:expectIdentifier().value
	self:expect("(")
	local args = {}
	if not self:match(")") then
		repeat
			args[#args + 1] = self:parseExpression()
		until not self:match(",")
		self:expect(")")
	end
	return node("call", { name = name, args = args })
end

local Emitter = {}
Emitter.__index = Emitter

function Emitter.new()
	return setmetatable({
		bytes = {},
		stringHeap = {},
		stringOffsets = {},
		locals = {},
		statics = {},
		globals = {},
		localOrder = {},
		staticOrder = {},
		globalOrder = {},
		types = {},
		nextLocal = 0,
		nextStatic = 0,
		nextGlobal = 0,
		natives = {},
		nativeInfo = {},
		nativeSlots = {},
		subprograms = {},
		subprogramAddresses = {},
		callPatches = {},
		labels = {},
		labelPatches = {},
		labelScope = "SCRIPT",
		loopStack = {},
		currentParamCount = 0,
		currentReturnSize = 0,
		warnings = {},
	}, Emitter)
end

function Emitter:typeSize(typeName)
	local typeInfo = self.types[string.upper(typeName)]
	if typeInfo then
		return typeInfo.size
	end
	return typeSizes[typeName]
end

function Emitter:pc()
	return #self.bytes
end

function Emitter:byte(value)
	self.bytes[#self.bytes + 1] = bit32.band(value, 0xff)
end

function Emitter:op(op)
	self:byte(op)
end

function Emitter:u16(value)
	self:byte(bit32.rshift(bit32.band(value, 0xffff), 8))
	self:byte(value)
end

function Emitter:s16(value)
	if value < 0 then
		value += 0x10000
	end
	self:u16(value)
end

function Emitter:u24(value)
	self:byte(bit32.rshift(value, 16))
	self:byte(bit32.rshift(value, 8))
	self:byte(value)
end

function Emitter:u32(value)
	self:byte(bit32.rshift(value, 24))
	self:byte(bit32.rshift(value, 16))
	self:byte(bit32.rshift(value, 8))
	self:byte(value)
end

function Emitter:patchS16(offset, value)
	if value < 0 then
		value += 0x10000
	end
	self.bytes[offset + 1] = bit32.band(bit32.rshift(value, 8), 0xff)
	self.bytes[offset + 2] = bit32.band(value, 0xff)
end

function Emitter:forwardJump(op)
	self:op(op)
	local target = self:pc()
	self:s16(0)
	return target
end

function Emitter:placeJump(target)
	local distance = self:pc() - (target + 2)
	self:patchS16(target, distance)
end

function Emitter:backwardJump(op, pc)
	self:op(op)
	local distance = pc - (self:pc() + 2)
	self:s16(distance)
end

function Emitter:labelKey(name)
	return self.labelScope .. "::" .. string.upper(name)
end

function Emitter:emitInt(value)
	if value >= 0 and value <= 7 then
		self:op(OP.PUSH_CONST_0 + value)
	elseif value >= 0 and value < 256 then
		self:op(OP.PUSH_CONST_U8)
		self:byte(value)
	elseif value == -1 then
		self:op(OP.PUSH_CONST_M1)
	elseif value >= -32768 and value <= 32767 then
		self:op(OP.PUSH_CONST_S16)
		self:s16(value)
	elseif value >= 0 and value < 0x1000000 then
		self:op(OP.PUSH_CONST_U24)
		self:u24(value)
	else
		self:op(OP.PUSH_CONST_U32)
		self:u32(value)
	end
end

function Emitter:emitFloat(value)
	if value == -1 then
		self:op(OP.PUSH_CONST_FM1)
	elseif value >= 0 and value <= 7 and value == math.floor(value) then
		self:op(OP.PUSH_CONST_F0 + value)
	else
		local packed = buffer.create(4)
		buffer.writef32(packed, 0, value)
		self:op(OP.PUSH_CONST_F)
		self:u32(buffer.readu32(packed, 0))
	end
end

function Emitter:declareLocal(statement)
	local key = string.upper(statement.name)
	if self.locals[key] then
		error("Duplicate local '" .. statement.name .. "'")
	end
	local elemSize = self:typeSize(statement.typeName)
	local size = statement.arrayCount and (1 + statement.arrayCount * elemSize) or elemSize
	self.locals[key] = {
		name = statement.name,
		typeName = statement.typeName,
		offset = self.nextLocal,
		size = size,
		elemSize = elemSize,
		arrayCount = statement.arrayCount,
		scope = "local",
	}
	self.localOrder[#self.localOrder + 1] = self.locals[key]
	self.nextLocal += size
	if statement.arrayCount then
		self:emitInt(statement.arrayCount)
		self:emitAddress(self.locals[key])
		self:op(OP.STORE)
	end
	if statement.init then
		self:emitAssignment(node("assignment", {
			target = node("variable", { name = statement.name }),
			op = "=",
			value = statement.init,
		}))
	end
end

function Emitter:declareStorage(statement, scope)
	local key = string.upper(statement.name)
	local store = scope == "global" and self.globals or self.statics
	local order = scope == "global" and self.globalOrder or self.staticOrder
	if store[key] then
		error("Duplicate " .. scope .. " '" .. statement.name .. "'")
	end
	local elemSize = self:typeSize(statement.typeName)
	local offset = scope == "global" and self.nextGlobal or self.nextStatic
	local size = statement.arrayCount and (1 + statement.arrayCount * elemSize) or elemSize
	local info = {
		name = statement.name,
		typeName = statement.typeName,
		offset = offset,
		size = size,
		elemSize = elemSize,
		arrayCount = statement.arrayCount,
		scope = scope,
	}
	store[key] = info
	order[#order + 1] = info
	if scope == "global" then
		self.nextGlobal += size
	else
		self.nextStatic += size
	end
end

function Emitter:emitAddress(storage)
	if storage.scope == "global" then
		if storage.offset < 65536 then
			self:op(OP.GLOBAL_U16)
			self:u16(storage.offset)
		elseif storage.offset < 0x1000000 then
			self:op(OP.GLOBAL_U24)
			self:u24(storage.offset)
		else
			error("OP_GLOBAL overflow for " .. storage.name)
		end
	elseif storage.scope == "static" then
		if storage.offset < 256 then
			self:op(OP.STATIC_U8)
			self:byte(storage.offset)
		elseif storage.offset < 65536 then
			self:op(OP.STATIC_U16)
			self:u16(storage.offset)
		elseif storage.offset < 0x1000000 then
			self:op(OP.STATIC_U24)
			self:u24(storage.offset)
		else
			error("OP_STATIC overflow for " .. storage.name)
		end
	elseif storage.offset < 256 then
		self:op(OP.LOCAL_U8)
		self:byte(storage.offset)
	elseif storage.offset < 65536 then
		self:op(OP.LOCAL_U16)
		self:u16(storage.offset)
	else
		error("OP_LOCAL overflow for " .. storage.name)
	end
end

function Emitter:resolveVariable(name)
	local key = string.upper(name)
	return self.locals[key] or self.statics[key] or self.globals[key]
end

function Emitter:exprType(expr)
	if expr.kind == "variable" then
		local storage = self:resolveVariable(expr.name)
		return storage and storage.typeName
	elseif expr.kind == "index" then
		return self:exprType(expr.base)
	elseif expr.kind == "field" then
		local baseType = self:exprType(expr.base)
		local typeInfo = baseType and self.types[string.upper(baseType)]
		local field = typeInfo and typeInfo.fields and typeInfo.fields[string.upper(expr.field)]
		return field and field.typeName
	end
	return nil
end

function Emitter:emitAddressExpr(expr)
	if expr.kind == "field" then
		self:emitAddressExpr(expr.base)
		local baseType = self:exprType(expr.base)
		local typeInfo = baseType and self.types[string.upper(baseType)]
		local field = typeInfo and typeInfo.fields and typeInfo.fields[string.upper(expr.field)]
		if not field then
			error("Unknown field '" .. expr.field .. "'")
		end
		local offset = field.offset
		if offset ~= 0 then
			self:emitInt(offset)
			self:op(OP.IOFFSET)
		end
	elseif expr.kind == "index" then
		if expr.base.kind ~= "variable" then
			error("Only simple arrays can be indexed in this compiler slice")
		end
		local base = self:resolveVariable(expr.base.name)
		if not base then
			error("Unknown variable '" .. expr.base.name .. "'")
		end
		self:emitAddress(base)
		self:emitExpression(expr.index)
		if base.elemSize < 256 then
			self:op(OP.ARRAY_U8)
			self:byte(base.elemSize)
		else
			self:op(OP.ARRAY_U16)
			self:u16(base.elemSize)
		end
	elseif expr.kind == "variable" then
		local storage = self:resolveVariable(expr.name)
		if not storage then
			error("Unknown variable '" .. expr.name .. "'")
		end
		self:emitAddress(storage)
	else
		error("Expression is not assignable")
	end
end

function Emitter:emitLoadVariable(expr)
	if expr.kind == "index" or expr.kind == "field" then
		self:emitAddressExpr(expr)
		self:op(OP.LOAD)
		return
	elseif expr.kind ~= "variable" then
		error("Only variables can be loaded in this compiler slice")
	end
	local localInfo = self:resolveVariable(expr.name)
	if not localInfo then
		error("Unknown variable '" .. expr.name .. "'")
	end
	if localInfo.size == 1 or localInfo.arrayCount then
		self:emitAddress(localInfo)
		self:op(OP.LOAD)
	else
		self:emitInt(localInfo.size)
		self:emitAddress(localInfo)
		self:op(OP.LOAD_N)
	end
end

function Emitter:emitStoreVariable(expr)
	if expr.kind == "index" or expr.kind == "field" then
		self:emitAddressExpr(expr)
		self:op(OP.STORE)
		return
	elseif expr.kind ~= "variable" then
		error("Only variables can be assigned in this compiler slice")
	end
	local localInfo = self:resolveVariable(expr.name)
	if not localInfo then
		error("Unknown variable '" .. expr.name .. "'")
	end
	if localInfo.size == 1 or localInfo.arrayCount then
		self:emitAddress(localInfo)
		self:op(OP.STORE)
	else
		self:emitInt(localInfo.size)
		self:emitAddress(localInfo)
		self:op(OP.STORE_N)
	end
end

local intBinaryOps = {
	["+"] = OP.IADD,
	["+@"] = OP.FADD,
	["-"] = OP.ISUB,
	["-@"] = OP.FSUB,
	["*"] = OP.IMUL,
	["/"] = OP.IDIV,
	["%"] = OP.IMOD,
	["&"] = OP.IAND,
	["|"] = OP.IOR,
	["^"] = OP.IXOR,
	["="] = OP.IEQ,
	["=="] = OP.IEQ,
	["!="] = OP.INE,
	["<>"] = OP.INE,
	[">"] = OP.IGT,
	[">="] = OP.IGE,
	["<"] = OP.ILT,
	["<="] = OP.ILE,
	AND = OP.IAND,
	ANDALSO = OP.IAND,
	OR = OP.IOR,
	ORELSE = OP.IOR,
}

function Emitter:emitExpression(expr)
	if expr.kind == "number" then
		if expr.value == math.floor(expr.value) then
			self:emitInt(expr.value)
		else
			self:emitFloat(expr.value)
		end
	elseif expr.kind == "boolean" then
		self:emitInt(expr.value and 1 or 0)
	elseif expr.kind == "variable" or expr.kind == "index" or expr.kind == "field" then
		self:emitLoadVariable(expr)
	elseif expr.kind == "binary" then
		if (expr.op == "<<" or expr.op == ">>") and expr.right.kind == "number" then
			self:emitExpression(expr.left)
			self:emitInt(2 ^ expr.right.value)
			self:op(expr.op == "<<" and OP.IMUL or OP.IDIV)
			return
		elseif expr.op == "<<" or expr.op == ">>" then
			error("Dynamic shift counts are not emitted by this Luau compiler yet")
		end
		self:emitExpression(expr.left)
		self:emitExpression(expr.right)
		local op = intBinaryOps[expr.op]
		if not op then
			error("Unsupported binary operator '" .. expr.op .. "'")
		end
		self:op(op)
	elseif expr.kind == "unary" then
		self:emitExpression(expr.expr)
		if expr.op == "-" then
			self:op(OP.INEG)
		elseif expr.op == "!" or expr.op == "NOT" then
			self:op(OP.INOT)
		else
			error("Unsupported unary operator '" .. expr.op .. "'")
		end
	elseif expr.kind == "call" then
		self:emitCall(expr, true)
	elseif expr.kind == "string" then
		self:emitString(expr.value)
	elseif expr.kind == "vector" then
		self:emitExpression(expr.x)
		self:emitExpression(expr.y)
		self:emitExpression(expr.z)
	elseif expr.kind == "catch" then
		self:op(OP.CATCH)
	elseif expr.kind == "countOf" then
		if expr.value.kind ~= "variable" then
			error("COUNT_OF currently expects a simple array variable")
		end
		local storage = self:resolveVariable(expr.value.name)
		if not storage or not storage.arrayCount then
			error("COUNT_OF expects an array")
		end
		self:emitAddress(storage)
		self:op(OP.LOAD)
	elseif expr.kind == "countOfType" then
		local typeInfo = self.types[expr.typeName]
		if not typeInfo or not typeInfo.values then
			error("COUNT_OF(type) expects an enum type")
		end
		local count = 0
		for _ in pairs(typeInfo.values) do
			count += 1
		end
		self:emitInt(count)
	elseif expr.kind == "sizeOfType" then
		self:emitInt(self:typeSize(expr.typeName))
	elseif expr.kind == "sizeOf" then
		local typeName = self:exprType(expr.value)
		if not typeName then
			error("SIZE_OF expects a typed value")
		end
		self:emitInt(self:typeSize(typeName))
	else
		error("Unsupported expression kind '" .. expr.kind .. "'")
	end
end

function Emitter:emitString(value)
	local offset = self.stringOffsets[value]
	if offset == nil then
		offset = #self.stringHeap
		self.stringOffsets[value] = offset
		for i = 1, #value do
			self.stringHeap[#self.stringHeap + 1] = string.byte(value, i)
		end
		self.stringHeap[#self.stringHeap + 1] = 0
	end
	self:emitInt(offset)
	self:op(OP.STRING)
end

function Emitter:emitAssignment(statement)
	if statement.op == "=" then
		self:emitExpression(statement.value)
	else
		self:emitLoadVariable(statement.target)
		self:emitExpression(statement.value)
		local op = ({ ["+="] = OP.IADD, ["-="] = OP.ISUB, ["*="] = OP.IMUL, ["/="] = OP.IDIV, ["&="] = OP.IAND, ["|="] = OP.IOR, ["^="] = OP.IXOR })[statement.op]
		self:op(op)
	end
	self:emitStoreVariable(statement.target)
end

function Emitter:registerNatives(natives)
	for _, native in ipairs(natives) do
		if not native.nativeType then
			native.hash = native.hash or simpleHash(native.name)
			local key = string.upper(native.name)
			self.natives[key] = native
			self.nativeInfo[key] = native
		end
	end
end

function Emitter:registerSubprograms(subprograms)
	for _, subprogram in ipairs(subprograms) do
		self.subprograms[string.upper(subprogram.name)] = subprogram
	end
end

function Emitter:emitCall(call, expectReturn)
	for _, arg in ipairs(call.args) do
		self:emitExpression(arg)
	end

	local key = string.upper(call.name)
	local subprogram = self.subprograms[key]
	if subprogram then
		self:op(OP.CALL)
		local patch = self:pc()
		self:u24(0)
		self.callPatches[#self.callPatches + 1] = { name = key, pc = patch }
		return
	end
	local native = self.natives[key]
	local paramSize = #call.args
	local returnSize = 0
	if native then
		paramSize = 0
		for _, param in ipairs(native.params) do
			paramSize += param.size
		end
		returnSize = native.returnSize
	else
		self.warnings[#self.warnings + 1] = string.format("Treating '%s' as an unresolved native with hash placeholder", call.name)
		native = { name = call.name, hash = simpleHash(key), returnSize = expectReturn and 1 or 0, params = {} }
		self.nativeInfo[key] = native
		returnSize = native.returnSize
	end

	local slot = self.nativeSlots[key]
	if not slot then
		slot = 0
		for _ in pairs(self.nativeSlots) do
			slot += 1
		end
		self.nativeSlots[key] = slot
	end

	if key == "IS_BIT_SET" then
		self:op(OP.IS_BIT_SET)
		return
	end

	self:op(OP.NATIVE)
	self:byte(returnSize + bit32.lshift(paramSize, 2))
	self:byte(bit32.rshift(slot, 8))
	self:byte(slot)
end

function Emitter:patchU24(offset, value)
	self.bytes[offset + 1] = bit32.band(bit32.rshift(value, 16), 0xff)
	self.bytes[offset + 2] = bit32.band(bit32.rshift(value, 8), 0xff)
	self.bytes[offset + 3] = bit32.band(value, 0xff)
end

function Emitter:emitEnter(paramCount, localCount)
	self:op(OP.ENTER)
	self:byte(paramCount)
	local localCountPatch = self:pc()
	self:u16(localCount or 0)
	self:byte(0)
	return localCountPatch
end

function Emitter:emitSubprogram(subprogram)
	self.subprogramAddresses[string.upper(subprogram.name)] = self:pc()
	local savedLocals = self.locals
	local savedLocalOrder = self.localOrder
	local savedNextLocal = self.nextLocal
	local savedParamCount = self.currentParamCount
	local savedReturnSize = self.currentReturnSize
	local savedLabelScope = self.labelScope
	self.labelScope = string.upper(subprogram.name)
	self.locals = {}
	self.localOrder = {}
	self.nextLocal = 0
	local paramCount = 0
	for _, param in ipairs(subprogram.params) do
		local key = string.upper(param.name)
		self.locals[key] = {
			name = param.name,
			typeName = param.typeName,
			offset = self.nextLocal,
			size = param.size,
			elemSize = param.size,
			scope = "local",
		}
		self.localOrder[#self.localOrder + 1] = self.locals[key]
		self.nextLocal += param.size
		paramCount += param.size
	end
	local localCountPatch = self:emitEnter(paramCount, 0)
	self.currentParamCount = paramCount
	self.currentReturnSize = subprogram.returnType and self:typeSize(subprogram.returnType) or 0
	self:emitBlock(subprogram.body)
	self:op(OP.LEAVE)
	self:byte(paramCount)
	self:byte(self.currentReturnSize)
	self:patchS16(localCountPatch, self.nextLocal)
	self.locals = savedLocals
	self.localOrder = savedLocalOrder
	self.nextLocal = savedNextLocal
	self.currentParamCount = savedParamCount
	self.currentReturnSize = savedReturnSize
	self.labelScope = savedLabelScope
end

function Emitter:emitStatement(statement)
	if statement.kind == "declaration" then
		self:declareLocal(statement)
	elseif statement.kind == "block" then
		self:emitBlock(statement.body)
	elseif statement.kind == "assignment" then
		self:emitAssignment(statement)
	elseif statement.kind == "callStatement" then
		self:emitCall(statement.call, false)
	elseif statement.kind == "if" then
		self:emitExpression(statement.condition)
		local falseJump = self:forwardJump(OP.JZ)
		self:emitBlock(statement.thenBody)
		if statement.elseBody then
			local doneJump = self:forwardJump(OP.J)
			self:placeJump(falseJump)
			self:emitBlock(statement.elseBody)
			self:placeJump(doneJump)
		else
			self:placeJump(falseJump)
		end
	elseif statement.kind == "while" then
		local top = self:pc()
		local loopInfo = { breaks = {}, reloops = {}, reloopTarget = top }
		self.loopStack[#self.loopStack + 1] = loopInfo
		self:emitExpression(statement.condition)
		local exitJump = self:forwardJump(OP.JZ)
		self:emitBlock(statement.body)
		for _, jump in ipairs(loopInfo.reloops) do
			self:patchS16(jump, top - (jump + 2))
		end
		self.loopStack[#self.loopStack] = nil
		self:backwardJump(OP.J, top)
		self:placeJump(exitJump)
		for _, jump in ipairs(loopInfo.breaks) do
			self:placeJump(jump)
		end
	elseif statement.kind == "for" then
		self:emitExpression(statement.initialValue)
		self:emitStoreVariable(statement.target)
		local top = self:pc()
		local loopInfo = { breaks = {}, reloops = {}, reloopTarget = top }
		self.loopStack[#self.loopStack + 1] = loopInfo
		self:emitLoadVariable(statement.target)
		self:emitExpression(statement.finalValue)
		self:op(statement.step > 0 and OP.ILE or OP.IGE)
		local exitJump = self:forwardJump(OP.JZ)
		self:emitBlock(statement.body)
		local incrementPc = self:pc()
		for _, jump in ipairs(loopInfo.reloops) do
			self:patchS16(jump, incrementPc - (jump + 2))
		end
		self.loopStack[#self.loopStack] = nil
		self:emitLoadVariable(statement.target)
		self:emitInt(statement.step)
		self:op(OP.IADD)
		self:emitStoreVariable(statement.target)
		self:backwardJump(OP.J, top)
		self:placeJump(exitJump)
		for _, jump in ipairs(loopInfo.breaks) do
			self:placeJump(jump)
		end
	elseif statement.kind == "repeatLoop" then
		self:emitInt(0)
		self:emitStoreVariable(statement.target)
		local top = self:pc()
		local loopInfo = { breaks = {}, reloops = {}, reloopTarget = top }
		self.loopStack[#self.loopStack + 1] = loopInfo
		self:emitLoadVariable(statement.target)
		self:emitExpression(statement.count)
		self:op(OP.ILT)
		local exitJump = self:forwardJump(OP.JZ)
		self:emitBlock(statement.body)
		local incrementPc = self:pc()
		for _, jump in ipairs(loopInfo.reloops) do
			self:patchS16(jump, incrementPc - (jump + 2))
		end
		self.loopStack[#self.loopStack] = nil
		self:emitLoadVariable(statement.target)
		self:emitInt(1)
		self:op(OP.IADD)
		self:emitStoreVariable(statement.target)
		self:backwardJump(OP.J, top)
		self:placeJump(exitJump)
		for _, jump in ipairs(loopInfo.breaks) do
			self:placeJump(jump)
		end
	elseif statement.kind == "return" then
		if statement.value then
			self:emitExpression(statement.value)
		end
		self:op(OP.LEAVE)
		self:byte(self.currentParamCount)
		self:byte(statement.value and (self.currentReturnSize ~= 0 and self.currentReturnSize or 1) or 0)
	elseif statement.kind == "label" then
		local key = self:labelKey(statement.name)
		if self.labels[key] then
			error("Duplicate label '" .. statement.name .. "'")
		end
		self.labels[key] = self:pc()
	elseif statement.kind == "goto" then
		self:op(OP.J)
		local patch = self:pc()
		self:s16(0)
		self.labelPatches[#self.labelPatches + 1] = { name = self:labelKey(statement.name), pc = patch }
	elseif statement.kind == "throw" then
		self:emitExpression(statement.value)
		self:op(OP.THROW)
	elseif statement.kind == "breakLoop" then
		local loopInfo = self.loopStack[#self.loopStack]
		if not loopInfo then
			error("BREAKLOOP outside loop")
		end
		loopInfo.breaks[#loopInfo.breaks + 1] = self:forwardJump(OP.J)
	elseif statement.kind == "reloop" then
		local loopInfo = self.loopStack[#self.loopStack]
		if not loopInfo then
			error("RELOOP outside loop")
		end
		self:op(OP.J)
		local patch = self:pc()
		self:s16(0)
		loopInfo.reloops[#loopInfo.reloops + 1] = patch
	elseif statement.kind == "switch" then
		self:emitSwitch(statement)
	elseif statement.kind == "break" or statement.kind == "fallthru" then
		error(statement.kind .. " outside SWITCH")
	else
		error("Unsupported statement kind '" .. statement.kind .. "'")
	end
end

local function constSwitchValue(expr)
	if expr.kind == "number" then
		return expr.value
	elseif expr.kind == "boolean" then
		return expr.value and 1 or 0
	end
	return nil
end

function Emitter:emitSwitch(statement)
	local endJumps = {}
	local casePatches = {}
	self:emitExpression(statement.expr)
	self:op(OP.SWITCH)
	self:byte(#statement.cases)
	for _, caseInfo in ipairs(statement.cases) do
		local value = constSwitchValue(caseInfo.value)
		if value == nil or value ~= math.floor(value) then
			error("SWITCH CASE values must be integer constants")
		end
		self:u32(value)
		local patch = self:pc()
		self:s16(0)
		casePatches[#casePatches + 1] = patch
	end
	local defaultJump = self:forwardJump(OP.J)
	for index, caseInfo in ipairs(statement.cases) do
		self:patchS16(casePatches[index], self:pc() - (casePatches[index] + 2))
		local breaks = self:emitSwitchBody(caseInfo.body)
		for _, jump in ipairs(breaks) do
			endJumps[#endJumps + 1] = jump
		end
	end
	if statement.defaultBody then
		self:placeJump(defaultJump)
		local breaks = self:emitSwitchBody(statement.defaultBody)
		for _, jump in ipairs(breaks) do
			endJumps[#endJumps + 1] = jump
		end
	else
		self:placeJump(defaultJump)
	end
	for _, jump in ipairs(endJumps) do
		self:placeJump(jump)
	end
end

function Emitter:emitSwitchBody(block)
	local breaks = {}
	for _, statement in ipairs(block) do
		if statement.kind == "break" then
			breaks[#breaks + 1] = self:forwardJump(OP.J)
		elseif statement.kind ~= "fallthru" then
			self:emitStatement(statement)
		end
	end
	return breaks
end

function Emitter:emitBlock(block)
	for _, statement in ipairs(block) do
		self:emitStatement(statement)
	end
end

function Emitter:emitProgram(program)
	self.types = program.types or {}
	self:registerNatives(program.natives)
	self:registerSubprograms(program.subprograms)
	for _, statement in ipairs(program.statics) do
		if statement.kind == "block" then
			for _, child in ipairs(statement.body) do
				self:declareStorage(child, "static")
			end
		else
			self:declareStorage(statement, "static")
		end
	end
	for _, statement in ipairs(program.globals) do
		if statement.kind == "block" then
			for _, child in ipairs(statement.body) do
				self:declareStorage(child, "global")
			end
		else
			self:declareStorage(statement, "global")
		end
	end
	local localCountPatch = self:emitEnter(0, 0)
	self:emitBlock(program.body)
	self:op(OP.LEAVE)
	self:byte(0)
	self:byte(0)
	self:patchS16(localCountPatch, self.nextLocal)
	for _, subprogram in ipairs(program.subprograms) do
		self:emitSubprogram(subprogram)
	end
	for _, patch in ipairs(self.callPatches) do
		local address = self.subprogramAddresses[patch.name]
		if not address then
			error("Unable to resolve subprogram call '" .. patch.name .. "'")
		end
		self:patchU24(patch.pc, address)
	end
	for _, patch in ipairs(self.labelPatches) do
		local address = self.labels[patch.name]
		if not address then
			error("Unable to resolve label '" .. patch.name .. "'")
		end
		self:patchS16(patch.pc, address - (patch.pc + 2))
	end
end

local function toHex(bytes)
	local out = {}
	for i, byte in ipairs(bytes) do
		out[i] = string.format("%02X", byte)
	end
	return table.concat(out, " ")
end

local function appendU32(bytes, value)
	bytes[#bytes + 1] = bit32.band(bit32.rshift(value, 24), 0xff)
	bytes[#bytes + 1] = bit32.band(bit32.rshift(value, 16), 0xff)
	bytes[#bytes + 1] = bit32.band(bit32.rshift(value, 8), 0xff)
	bytes[#bytes + 1] = bit32.band(value, 0xff)
end

local function appendZeroWords(bytes, count)
	for _ = 1, count do
		appendU32(bytes, 0)
	end
end

local function storageWordCount(order)
	local count = 0
	for _, item in ipairs(order) do
		count += item.size
	end
	return count
end

function Compiler.buildProgramImage(compiled)
	local nativeCount = 0
	for _ in pairs(compiled.nativeSlots) do
		nativeCount += 1
	end
	local nativeHashes = table.create(nativeCount)
	for key, slot in pairs(compiled.nativeSlots) do
		local native = compiled.natives[key]
		nativeHashes[slot + 1] = native and native.hash or simpleHash(key)
	end

	local bytes = {}
	for _, byte in ipairs(compiled.bytes) do
		bytes[#bytes + 1] = byte
	end
	for _, byte in ipairs(compiled.stringHeap) do
		bytes[#bytes + 1] = byte
	end
	for i = 1, nativeCount do
		appendU32(bytes, 0)
		appendU32(bytes, nativeHashes[i] or 0)
	end
	appendZeroWords(bytes, storageWordCount(compiled.statics))
	appendZeroWords(bytes, storageWordCount(compiled.globals))

	return {
		header = {
			opcodeSize = #compiled.bytes,
			staticSize = storageWordCount(compiled.statics),
			globalSize = storageWordCount(compiled.globals),
			argStructSize = 0,
			nativeSize = nativeCount,
			stringHeapSize = #compiled.stringHeap,
			globalsHash = 0,
			globalsBlock = 0,
			encrypted = false,
			compressed = false,
		},
		bytes = bytes,
		hex = toHex(bytes),
		nativeHashes = nativeHashes,
	}
end

function Compiler.expandIncludes(source, options, seen)
	options = options or {}
	seen = seen or {}
	local includes = options.includes or {}
	local chunks = {}
	local tokens = Compiler.lex(source)
	for i, token in ipairs(tokens) do
		if token.value == "USING" then
			local nextToken = tokens[i + 1]
			if nextToken and nextToken.kind == "string" and includes[nextToken.value] and not seen[nextToken.value] then
				seen[nextToken.value] = true
				chunks[#chunks + 1] = Compiler.expandIncludes(includes[nextToken.value], options, seen)
			end
		end
	end
	chunks[#chunks + 1] = source
	return table.concat(chunks, "\n")
end

function Compiler.compile(source, options)
	source = Compiler.expandIncludes(source, options)
	local parser = Parser.new(Compiler.lex(source))
	local program = parser:parse()
	local emitter = Emitter.new()
	emitter:emitProgram(program)
	local result = {
		ast = program,
		bytes = emitter.bytes,
		hex = toHex(emitter.bytes),
		locals = emitter.localOrder,
		statics = emitter.staticOrder,
		globals = emitter.globalOrder,
		stringHeap = emitter.stringHeap,
		natives = emitter.nativeInfo,
		nativeSlots = emitter.nativeSlots,
		warnings = program.warnings,
		emitWarnings = emitter.warnings,
	}
	result.programImage = Compiler.buildProgramImage(result)
	return result
end

return Compiler