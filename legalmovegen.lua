function checkLegality(board, whiteFrom, whiteTo, blackFrom, blackTo, eps, side) --1 2 3 4 and 5 are self explainable, en passant square, side to check legality
	--make temporary board to make moves on. make move from movelist, and after the move, if any king is found, add the move to a new list, and if not, then dont add it to the list.
	tempBoard = board --set up temporary board
	movesForWhite = 0 --prepare how many psuedo-legal moves white has
	for _ in pairs(whiteFrom) do movesForWhite = movesForWhite + 1 end --set it
	movesForBlack = 0 --prepare how many psuedo-legal moves black has
	for _ in pairs(blackFrom) do movesForBlack = movesForBlack + 1 end --set it
	newWhiteFrom = {}
	newWhiteTo = {}
	newBlackFrom = {}
	newBlackTo = {}
	if side=="w" then --if we are checking white's move legality
		whiteKingExists=false
		blackKingExists=false
		for i=1,movesForWhite,1 do --loop through the moves
			tempBoard=board
			tempBoard = board:sub(1,(whiteTo[i])-1) .. board:sub(whiteFrom[i],whiteFrom[i]) .. board:sub((whiteTo[i])+1,64)
			tempBoard = tempBoard:sub(1,(whiteFrom[i])-1) ..".".. tempBoard:sub((whiteFrom[i])+1,64)
			print(tempBoard .." | ".. string.len(tempBoard))
			require("movegen")
			moveGeneration(tempBoard, eps)
			blackFromNew=generatedBlackFromSquares
			blackToNew=generatedBlackToSquares
			for _ in pairs(blackFromNew) do movesForBlack = movesForBlack + 1 end
			print("woowoooooowow!")
			for o=1,movesForBlack,1 do
				print("WE AT LEAST WENT IN THE NEXT LOOP")
				tempBoard=board
				tempBoard = board:sub(1,(whiteTo[i])-1) .. board:sub(whiteFrom[i],whiteFrom[i]) .. board:sub((whiteTo[i])+1,64)
				tempBoard = tempBoard:sub(1,(whiteFrom[i])-1) ..".".. tempBoard:sub((whiteFrom[i])+1,64)
				tempBoard = tempBoard:sub(1,(blackToNew[o])-1) .. tempBoard:sub(blackFromNew[o],blackFromNew[o]) .. tempBoard:sub((blackToNew[o])+1,64)
				tempBoard = tempBoard:sub(1,(blackFromNew[o])-1) ..".".. tempBoard:sub((blackFromNew[o])+1,64)
				for p=1,64,1 do
					if tempBoard[p]=="K" then whiteKingExists=true;print("wKE white") end
					if tempBoard[p]=="k" then blackKingExists=true;print("bKE white") end
				end
			end
			if whiteKingExists==true and blackKingExists==true then
				table.insert(newWhiteFrom,whiteFrom[i]); table.insert(newWhiteTo,whiteTo[i])
				print("move added to white tables")
			end
		end
	elseif side=="b" then --if we are checking black's move legality
		whiteKingExists=false
		blackKingExists=false
		for i=1,movesFoBlack,1 do --loop through the moves
			tempBoard = board:sub(1,(blackTo[i])-1) .. board:sub(blackFrom[i],blackFrom[i]) .. board:sub((blackTo[i])+1,64)
			tempBoard = tempBoard:sub(1,(blackFrom[i])-1) ..".".. tempBoard:sub((blackFrom[i])+1,64)
			require("movegen")
			moveGeneration(tempBoard, eps)
			whiteFromNew=generatedWhiteFromSquares
			whiteToNew=generatedWhiteToSquares
			for _ in pairs(blackFromNew) do movesForBlack = movesForBlack + 1 end
			for o=1,movesForBlack,1 do
				tempBoard = tempBoard:sub(1,(whiteToNew[o])-1) .. tempBoard:sub(whiteFromNew[o],whiteFromNew[o]) .. tempBoard:sub((whiteToNew[o])+1,64)
				tempBoard = tempBoard:sub(1,(whiteFromNew[o])-1) ..".".. tempBoard:sub((whiteFromNew[o])+1,64)
				for p=1,64,1 do
					if tempBoard[p]=="K" then whiteKingExists=true;print("wKE black") end
					if tempBoard[p]=="k" then blackKingExists=true;print("bKE black") end
				end
			end
			if whiteKingExists==true and blackKingExists==true then
				table.insert(newBlackFrom,blackFrom[i]); table.insert(newBlackTo,blackTo[i])
				print("move added to black tables")
			end
		end
	end
	return newWhiteFrom,newWhiteTo,newBlackFrom,newBlackTo,eps
end
