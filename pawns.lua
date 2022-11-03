function checkPawns(board, side)
	isolatedPawns = 0
	backwardsPawns = 0
	doubledPawns = 0
	blockedPawns = 0
	passedPawns = 0
	if side=="w" then
		for i=1,64,1 do
			if board:sub(i,i)=="P" then
				require("movegen")
				if board:sub(i+8,i+8)=="P" then
					doubledPawns = doubledPawns + 1
				end
				if board:sub(i-8,i-8)~="." then
					blockedPawns = blockedPawns + 1
				end
				if (checkFile(i)~="a") and (checkFile(i)~="h") then
					if board:sub(i-7,i-7)=="P" and board:sub(i-9,i-9)=="P" then
						backwardsPawns = backwardsPawns + 1
					end
				end
				if board:sub(i-8,i-8)=="." and board:sub(i+8,i+8)=="." then
					if (checkFile(i)=="a") then
						if board:sub(i-9,i-9)=="." and board:sub(i+1,i+1)=="." and board:sub(i+9,i+9)=="." then
							isolatedPawns = isolatedPawns + 1
						end
					elseif (checkFile(i)=="h") then
						if board:sub(i-7,i-7)=="." and board:sub(i-1,i-1)=="." and board:sub(i+7,i+7)=="." then
							isolatedPawns = isolatedPawns + 1
						end
					else
						if board:sub(i-7,i-7)=="." and board:sub(i-1,i-1)=="." and board:sub(i+7,i+7)=="." and board:sub(i-9,i-9)=="." and board:sub(i+1,i+1)=="." and board:sub(i+9,i+9)=="." then
							isolatedPawns = isolatedPawns + 1
						end
					end
				end
			end
		end
	end
	if side=="b" then
		for i=1,64,1 do
			if board:sub(i,i)=="p" then
				require("movegen")
				if board:sub(i-8,i-8)=="p" then
					doubledPawns = doubledPawns + 1
				end
				if board:sub(i+8,i+8)~="." then
					blockedPawns = blockedPawns + 1
				end
				if (checkFile(i)=="a") then
					if board:sub(i+9,i+9)=="p" then
						backwardsPawns = backwardsPawns + 1
					end
				elseif (checkFile(i)=="h") then
					if board:sub(i+7,i+7)=="p" then
						backwardsPawns = backwardsPawns + 1
					end
				elseif board:sub(i+7,i+7)=="p" and board:sub(i+9,i+9)=="p" then
					backwardsPawns = backwardsPawns + 1
				end
				if board:sub(i-8,i-8)=="." and board:sub(i+8,i+8)=="." then
					if (checkFile(i)=="a") then
						if board:sub(i-9,i-9)=="." and board:sub(i+1,i+1)=="." and board:sub(i+9,i+9)=="." then
							isolatedPawns = isolatedPawns + 1
						end
					elseif (checkFile(i)=="h") then
						if board:sub(i-7,i-7)=="." and board:sub(i-1,i-1)=="." and board:sub(i+7,i+7)=="." then
							isolatedPawns = isolatedPawns + 1
						end
					else
						if board:sub(i-7,i-7)=="." and board:sub(i-1,i-1)=="." and board:sub(i+7,i+7)=="." and board:sub(i-9,i-9)=="." and board:sub(i+1,i+1)=="." and board:sub(i+9,i+9)=="." then
							isolatedPawns = isolatedPawns + 1
						end
					end
				end
			end
		end
	end
	return isolatedPawns,backwardsPawns,doubledPawns,blockedPawns,passedPawns
end
