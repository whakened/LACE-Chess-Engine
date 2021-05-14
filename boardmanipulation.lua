function displayBoard(b)
	print("+---+---+---+---+---+---+---+---+")
	for i=1,57,8 do
		print("| ".. b:sub(i,i) .." | ".. b:sub(i+1,i+1) .." | ".. b:sub(i+2,i+2) .." | ".. b:sub(i+3,i+3) .." | ".. b:sub(i+4,i+4) .." | ".. b:sub(i+5,i+5) .." | ".. b:sub(i+6,i+6) .." | ".. b:sub(i+7,i+7) .." |")
		print("+---+---+---+---+---+---+---+---+")
	end
end
function displayBoardAsBlack(b)
	print("+---+---+---+---+---+---+---+---+")
	for i=64,8,-8 do
		print("| ".. b:sub(i,i) .." | ".. b:sub(i-1,i-1) .." | ".. b:sub(i-2,i-2) .." | ".. b:sub(i-3,i-3) .." | ".. b:sub(i-4,i-4) .." | ".. b:sub(i-5,i-5) .." | ".. b:sub(i-6,i-6) .." | ".. b:sub(i-7,i-7) .." |")
		print("+---+---+---+---+---+---+---+---+")
	end
end
function moveInterpret(move)
	coordA=move:sub(1,2)
	coordB=move:sub(3,4)
	if coordA:sub(1,1)=="a" then
		trueCoordA=57
	elseif coordA:sub(1,1)=="b" then
		trueCoordA=58
	elseif coordA:sub(1,1)=="c" then
		trueCoordA=59
	elseif coordA:sub(1,1)=="d" then
		trueCoordA=60
	elseif coordA:sub(1,1)=="e" then
		trueCoordA=61
	elseif coordA:sub(1,1)=="f" then
		trueCoordA=62
	elseif coordA:sub(1,1)=="g" then
		trueCoordA=63
	elseif coordA:sub(1,1)=="h" then
		trueCoordA=64
	end
	if coordA:sub(2,2)~=1 then
		trueCoordA=(trueCoordA - (8*(tonumber(coordA:sub(2,2))-1)))
	end
	if coordB:sub(1,1)=="a" then
		trueCoordB=57
	elseif coordB:sub(1,1)=="b" then
		trueCoordB=58
	elseif coordB:sub(1,1)=="c" then
		trueCoordB=59
	elseif coordB:sub(1,1)=="d" then
		trueCoordB=60
	elseif coordB:sub(1,1)=="e" then
		trueCoordB=61
	elseif coordB:sub(1,1)=="f" then
		trueCoordB=62
	elseif coordB:sub(1,1)=="g" then
		trueCoordB=63
	elseif coordB:sub(1,1)=="h" then
		trueCoordB=64
	end
	if coordB:sub(2,2)~=1 then
		trueCoordB=(trueCoordB - (8*(tonumber(coordB:sub(2,2))-1)))
	end
	fromSquare = trueCoordA
	toSquare = trueCoordB
	return fromSquare,toSquare
end

