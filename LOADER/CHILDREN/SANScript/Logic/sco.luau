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

-- AI Generated at 05/08/2026 - 2:03 AM

--!nocheck
--!native

local Sco = {}

Sco.SCR_MAGIC = bit32.bor(string.byte("S"), bit32.lshift(string.byte("C"), 8), bit32.lshift(string.byte("R"), 16), bit32.lshift(12, 24))

local function pushU32BE(out, value)
	out[#out + 1] = bit32.band(bit32.rshift(value, 24), 0xff)
	out[#out + 1] = bit32.band(bit32.rshift(value, 16), 0xff)
	out[#out + 1] = bit32.band(bit32.rshift(value, 8), 0xff)
	out[#out + 1] = bit32.band(value, 0xff)
end

local function pushU32LE(out, value)
	out[#out + 1] = bit32.band(value, 0xff)
	out[#out + 1] = bit32.band(bit32.rshift(value, 8), 0xff)
	out[#out + 1] = bit32.band(bit32.rshift(value, 16), 0xff)
	out[#out + 1] = bit32.band(bit32.rshift(value, 24), 0xff)
end

local function readU32BE(bytes, index)
	return bit32.bor(bit32.lshift(bytes[index], 24), bit32.lshift(bytes[index + 1], 16), bit32.lshift(bytes[index + 2], 8), bytes[index + 3])
end

local function readU32LE(bytes, index)
	return bit32.bor(bytes[index], bit32.lshift(bytes[index + 1], 8), bit32.lshift(bytes[index + 2], 16), bit32.lshift(bytes[index + 3], 24))
end

local function adler32(bytes)
	local a = 1
	local b = 0
	for _, byte in ipairs(bytes) do
		a = (a + byte) % 65521
		b = (b + a) % 65521
	end
	return bit32.bor(bit32.lshift(b, 16), a)
end

function Sco.zlibStore(bytes)
	local out = { 0x78, 0x01 }
	local index = 1
	while index <= #bytes do
		local remaining = #bytes - index + 1
		local len = math.min(remaining, 65535)
		local final = index + len > #bytes and 1 or 0
		out[#out + 1] = final
		out[#out + 1] = bit32.band(len, 0xff)
		out[#out + 1] = bit32.rshift(len, 8)
		local nlen = bit32.bxor(len, 0xffff)
		out[#out + 1] = bit32.band(nlen, 0xff)
		out[#out + 1] = bit32.rshift(nlen, 8)
		for i = 0, len - 1 do
			out[#out + 1] = bytes[index + i]
		end
		index += len
	end
	pushU32BE(out, adler32(bytes))
	return out
end

function Sco.zlibInflateStore(bytes)
	if bytes[1] ~= 0x78 then
		error("Unsupported zlib header")
	end
	local out = {}
	local index = 3
	while true do
		local header = bytes[index]
		index += 1
		local final = bit32.band(header, 1) == 1
		local blockType = bit32.rshift(header, 1)
		if blockType ~= 0 then
			error("Only stored deflate blocks are implemented in pure Luau")
		end
		local len = bytes[index] + bit32.lshift(bytes[index + 1], 8)
		local nlen = bytes[index + 2] + bit32.lshift(bytes[index + 3], 8)
		index += 4
		if bit32.band(bit32.bxor(len, nlen), 0xffff) ~= 0xffff then
			error("Invalid stored deflate length")
		end
		for i = 0, len - 1 do
			out[#out + 1] = bytes[index + i]
		end
		index += len
		if final then
			break
		end
	end
	return out
end

function Sco.pack(compiled, options)
	options = options or {}
	if options.encrypt or options.encryptionKey then
		error("AES-backed SCO encryption needs the platform key schedule; use encryptionKey = 0 for Roblox/local Luau packs")
	end
	local image = compiled.programImage
	local compressed = Sco.zlibStore(image.bytes)
	local header = {}
	pushU32LE(header, Sco.SCR_MAGIC)
	pushU32BE(header, image.header.globalsHash or 0)
	pushU32BE(header, #compressed)
	pushU32BE(header, 0)
	pushU32BE(header, image.header.opcodeSize)
	pushU32BE(header, image.header.staticSize)
	pushU32BE(header, image.header.globalSize)
	pushU32BE(header, image.header.argStructSize or 0)
	pushU32BE(header, image.header.nativeSize)
	pushU32BE(header, image.header.stringHeapSize)
	pushU32BE(header, image.header.globalsBlock or 0)
	pushU32BE(header, 0)
	local out = table.create(#header + #compressed)
	for _, byte in ipairs(header) do
		out[#out + 1] = byte
	end
	for _, byte in ipairs(compressed) do
		out[#out + 1] = byte
	end
	return {
		bytes = out,
		header = image.header,
		compressedSize = #compressed,
		encryptionKey = 0,
	}
end

function Sco.unpack(bytes)
	local magic = readU32LE(bytes, 1)
	if magic ~= Sco.SCR_MAGIC then
		error("Bad SCO magic")
	end
	local header = {
		globalsHash = readU32BE(bytes, 5),
		compressedSize = readU32BE(bytes, 9),
		encryptionKey = readU32BE(bytes, 13),
		opcodeSize = readU32BE(bytes, 17),
		staticSize = readU32BE(bytes, 21),
		globalSize = readU32BE(bytes, 25),
		argStructSize = readU32BE(bytes, 29),
		nativeSize = readU32BE(bytes, 33),
		stringHeapSize = readU32BE(bytes, 37),
		globalsBlock = readU32BE(bytes, 41),
	}
	if header.encryptionKey ~= 0 then
		error("Encrypted SCO payloads require the platform AES key")
	end
	local compressed = {}
	for i = 49, 48 + header.compressedSize do
		compressed[#compressed + 1] = bytes[i]
	end
	return {
		header = header,
		imageBytes = Sco.zlibInflateStore(compressed),
	}
end

return Sco