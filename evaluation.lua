pawnMap  = {198, 198, 198, 198, 198, 198, 198, 198,
			178, 198, 198, 198, 198, 198, 198, 178,
			178, 198, 208, 208, 208, 208, 198, 178,
			178, 198, 208, 388, 398, 208, 198, 178,
			178, 198, 208, 378, 378, 208, 198, 178,
			178, 198, 208, 258, 258, 208, 198, 178,
			178, 198, 198, 198, 198, 198, 198, 178,
			198, 198, 198, 198, 198, 198, 198, 198}

knightMap= {627, 762, 786, 798, 798, 786, 762, 627,
			763, 798, 822, 834, 834, 822, 798, 763,
			817, 852, 876, 888, 888, 876, 852, 817,
			797, 832, 856, 868, 868, 856, 832, 797,
			799, 834, 858, 870, 870, 858, 834, 799,
			758, 793, 817, 829, 829, 817, 793, 758,
			739, 774, 798, 810, 810, 798, 774, 739,
			683, 718, 742, 754, 754, 742, 718, 683}

bishopMap= {797, 824, 817, 808, 808, 817, 824, 797,
			814, 861, 834, 825, 825, 834, 861, 814,
			818, 845, 838, 829, 829, 838, 845, 818,
			824, 851, 844, 835, 835, 844, 851, 824,
			827, 854, 847, 838, 838, 847, 854, 827,
			826, 853, 846, 837, 837, 846, 853, 826,
			817, 894, 837, 828, 828, 837, 894, 817,
			792, 819, 812, 803, 803, 812, 819, 792}

rookMap  = {1258,1263,1268,1272,1272,1268,1263,1258,
			1258,1263,1268,1272,1272,1268,1263,1258,
			1258,1263,1268,1272,1272,1268,1263,1258,
			1258,1263,1268,1272,1272,1268,1263,1258,
			1258,1263,1268,1272,1272,1268,1263,1258,
			1258,1263,1268,1272,1272,1268,1263,1258,
			1258,1263,1268,1272,1272,1268,1263,1258,
			1258,1263,1268,1272,1272,1268,1263,1258}

function evaluatePosition(board, eps, depth, maxNodes, whiteFrom, whiteTo, blackFrom, blackTo)
	vK,vQ,vR,vB,vN,vP = 10000,900,500,350,300,100
	wK,wQ,wR,wB,wN,wP,bK,bQ,bR,bB,bN,bP=0,0,0,0,0,0,0,0,0,0,0,0
	wMobility,bMobility=0,0
	nodesSearched = 0
	mateDetected = false
	mateDetectedFrom = 0
	mateDetectedTo = 0
	evalTable = {}
	for _ in pairs(whiteFrom) do wMobility = wMobility + 10 end
	for _ in pairs(blackFrom) do bMobility = bMobility + 10 end
	for i=1,(wMobility/10),1 do
		if isCheckmate(board, eps, "w")==false then
			--tempBoard = tempBoard:sub(1,(newBlackTo[o])-1) .. tempBoard:sub(newBlackFrom[o],newBlackFrom[o]) .. tempBoard:sub((newBlackTo[o])+1,64)
			--tempBoard = tempBoard:sub(1,(newBlackFrom[o])-1) ..".".. tempBoard:sub((newBlackFrom[o])+1,64)
		elseif mateDetected==false then
			print("mate detected")
			--positioningScore=positioningScore+30000000
			mateDetected=true
			mateDetectedi = i
			mateDetectedFrom = whiteFrom[i]
			mateDetectedTo = whiteTo[i]
			print(mateDetectedFrom .. mateDetectedTo)
			printableTempBoard = tempBoard:sub(1,(mateDetectedTo)-1) .. tempBoard:sub(mateDetectedFrom,mateDetectedFrom) .. tempBoard:sub((mateDetectedTo)+1,64)
			printableTempBoard = printableTempBoard:sub(1,(mateDetectedFrom)-1) ..".".. printableTempBoard:sub((mateDetectedFrom)+1,64)
			require("boardmanipulation")
			displayBoard(printableTempBoard)
			--break
		end
		if mateDetected==true then
			--break
		end
		nodesSearched = nodesSearched + 1
		tempBoard=board
		tempBoard = board:sub(1,(whiteTo[i])-1) .. board:sub(whiteFrom[i],whiteFrom[i]) .. board:sub((whiteTo[i])+1,64)
		tempBoard = tempBoard:sub(1,(whiteFrom[i])-1) ..".".. tempBoard:sub((whiteFrom[i])+1,64)
		score = 0
		positioningScore = 0
		require("movegen")
		moveGeneration(tempBoard, eps)
		require("legalmovegen")
		checkLegality(tempBoard, generatedFromSquaresWhite, generatedToSquaresWhite, generatedFromSquaresBlack, generatedToSquaresBlack, enPassantSquare, "b")
		wMobility,bMobility=0,0
		for _ in pairs(newWhiteFrom) do wMobility = wMobility + 10 end
		for _ in pairs(newBlackFrom) do bMobility = bMobility + 10 end
		--[[if bMobility<=10 then
			print("exit loop: mate detected")
			positioningScore=positioningScore+30000000
			mateDetected=true
			mateDetectedFrom = whiteFrom[i]
			mateDetectedTo = whiteTo[i]
			break
		end]]
		tempBoardB = tempBoard
		bestScore = 99999
		for o=1,(bMobility/10),1 do
			nodesSearched = nodesSearched + 1
			tempBoard = tempBoardB
			--[[if isCheckmate(tempBoard, eps, "w")==false then
				tempBoard = tempBoard:sub(1,(newBlackTo[o])-1) .. tempBoard:sub(newBlackFrom[o],newBlackFrom[o]) .. tempBoard:sub((newBlackTo[o])+1,64)
				tempBoard = tempBoard:sub(1,(newBlackFrom[o])-1) ..".".. tempBoard:sub((newBlackFrom[o])+1,64)
			else
				print("mate detected")
				positioningScore=positioningScore+30000000
				mateDetected=true
				mateDetectedi = i
				mateDetectedFrom = whiteFrom[i]
				mateDetectedTo = whiteTo[i]
				print(mateDetectedFrom .. mateDetectedTo)
				printableTempBoard = tempBoard:sub(1,(mateDetectedTo)-1) .. tempBoard:sub(mateDetectedFrom,mateDetectedFrom) .. tempBoard:sub((mateDetectedTo)+1,64)
				printableTempBoard = printableTempBoard:sub(1,(mateDetectedFrom)-1) ..".".. printableTempBoard:sub((mateDetectedFrom)+1,64)
				require("boardmanipulation")
				displayBoard(printableTempBoard)
				--break
			end]]
			vK,vQ,vR,vB,vN,vP = 10000,900,500,350,300,100
			wK,wQ,wR,wB,wN,wP,bK,bQ,bR,bB,bN,bP=0,0,0,0,0,0,0,0,0,0,0,0
			wMobility,bMobility=0,0
			positioningScore=0
			for p=1,64,1 do
				piece=tempBoard:sub(p,p)
				if piece=="K" then wK=wK+1 end
				if piece=="Q" then wQ=wQ+1; positioningScore=positioningScore+rookMap[p]+bishopMap[p] end
				if piece=="R" then wR=wR+1; positioningScore=positioningScore+rookMap[p] end
				if piece=="B" then wB=wB+1; positioningScore=positioningScore+bishopMap[p] end
				if piece=="N" then wN=wN+1; positioningScore=positioningScore+knightMap[p] end
				if piece=="P" then wP=wP+1; positioningScore=positioningScore+pawnMap[p] end
				if piece=="k" then bK=bK+1 end
				if piece=="q" then bQ=bQ+1; positioningScore=positioningScore-rookMap[p]-bishopMap[p] end
				if piece=="r" then bR=bR+1; positioningScore=positioningScore-rookMap[p] end
				if piece=="b" then bB=bB+1; positioningScore=positioningScore-bishopMap[p] end
				if piece=="n" then bN=bN+1; positioningScore=positioningScore-knightMap[p] end
				if piece=="p" then bP=bP+1; positioningScore=positioningScore-pawnMap[p] end
			end
			tempWhiteFrom,tempWhiteTo,tempBlackFrom,tempBlackTo=newWhiteFrom,newWhiteTo,newBlackFrom,newBlackTo
			require("movegen")
			moveGeneration(tempBoard, eps)
			require("legalmovegen")
			checkLegality(tempBoard, generatedFromSquaresWhite, generatedToSquaresWhite, generatedFromSquaresBlack, generatedToSquaresBlack, enPassantSquare, "b")
			wMobility,bMobility=0,0
			for _ in pairs(tempWhiteFrom) do wMobility = wMobility + 10 end
			for _ in pairs(tempBlackFrom) do bMobility = bMobility + 10 end
			--[[if bMobility<=10 then
				print("mate detected")
				positioningScore=positioningScore+30000000
				mateDetected=true
				mateDetectedFrom = i
				mateDetectedTo = whiteTo[i]
				--break
			end]]
			--[[require("legalmovegen")
			if isCheckmate(tempBoard, eps, "w")==true then
				print("mate detected")
				positioningScore=positioningScore+30000000
				mateDetected=true
				mateDetectedi = i
				mateDetectedFrom = whiteFrom[i]
				mateDetectedTo = whiteTo[i]
				print(mateDetectedFrom .. mateDetectedTo)
				--break
			end]]
			newWhiteFrom,newWhiteTo,newBlackFrom,newBlackTo=tempWhiteFrom,tempWhiteTo,tempBlackFrom,tempBlackTo
			materialScore = (vK*(wK-bK)+vQ*(wQ-bQ)+vR*(wR-bR)+vN*(wN-bN)+vB*(wB-bB)+vP*(wP-bP))+((wK+wQ+wR+wB+wN+wP)-(bK+bQ+bR+bB+bN+bP))*10
			score = (materialScore+(wMobility-bMobility))/500 + (positioningScore)/1000
			require("pawns")
			checkPawns(tempBoard, "w")
			score = score - 0.1*(isolatedPawns+backwardsPawns+doubledPawns+blockedPawns)
			checkPawns(tempBoard, "b")
			score = score + 0.1*(isolatedPawns+backwardsPawns+doubledPawns+blockedPawns)
			if score < bestScore then bestScore = score end
			if score < bestScore then bestScore = score end
			--print(score)
		end
		for q=1,depth,1 do

		end
		evalTable[i] = bestScore
		print("Nodes: ".. nodesSearched .." | Score: ".. bestScore)
	end
	wMobility,bMobility=0,0
	for _ in pairs(whiteFrom) do wMobility = wMobility + 10 end
	for _ in pairs(blackFrom) do bMobility = bMobility + 10 end
	bestEval=-10000
	if mateDetected==false then
		for i=1,(wMobility/10),1 do
			if evalTable[i]>bestEval then
				bestEval = evalTable[i]
				bestMove=i
				--print(bestEval)
			end
		end
	else
		bestMove=mateDetectedi
	end
	return bestMove
end
function basicEvaluation(board, whiteFrom, blackFrom)
	vK,vQ,vR,vB,vN,vP = 10000,900,500,350,300,100
	wK,wQ,wR,wB,wN,wP,bK,bQ,bR,bB,bN,bP=0,0,0,0,0,0,0,0,0,0,0,0
	wMobility,bMobility=0,0
	positioningScore=0
	for i=1,64,1 do
		piece=board:sub(i,i)
		if piece=="K" then wK=wK+1 end
		if piece=="Q" then wQ=wQ+1; positioningScore=positioningScore+rookMap[i]+bishopMap[i] end
		if piece=="R" then wR=wR+1; positioningScore=positioningScore+rookMap[i] end
		if piece=="B" then wB=wB+1; positioningScore=positioningScore+bishopMap[i] end
		if piece=="N" then wN=wN+1; positioningScore=positioningScore+knightMap[i] end
		if piece=="P" then wP=wP+1; positioningScore=positioningScore+pawnMap[i] end
		if piece=="k" then bK=bK+1 end
		if piece=="q" then bQ=bQ+1; positioningScore=positioningScore-rookMap[i]-bishopMap[i] end
		if piece=="r" then bR=bR+1; positioningScore=positioningScore-rookMap[i] end
		if piece=="b" then bB=bB+1; positioningScore=positioningScore-bishopMap[i] end
		if piece=="n" then bN=bN+1; positioningScore=positioningScore-knightMap[i] end
		if piece=="p" then bP=bP+1; positioningScore=positioningScore-pawnMap[i] end
	end
	for _ in pairs(whiteFrom) do wMobility = wMobility + 10 end
	for _ in pairs(blackFrom) do bMobility = bMobility + 10 end
	--wScore = ((vK*wK)+(vQ*wQ)+(vR*wR)+(vB*wB)+(vN*wN)+(vP*wP)+wMobility)*(wK+wQ+wR+wB+wN+wP)
	--bScore = ((vK*bK)+(vQ*bQ)+(vR*bR)+(vB*bB)+(vN*bN)+(vP*bP)+bMobility)*(bK+bQ+bR+bB+bN+bP)
	--score = (wScore - bScore)/1000
	materialScore = (vK*(wK-bK)+vQ*(wQ-bQ)+vR*(wR-bR)+vN*(wN-bN)+vB*(wB-bB)+vP*(wP-bP))+((wK+wQ+wR+wB+wN+wP)-(bK+bQ+bR+bB+bN+bP))*10
	score=(materialScore+(wMobility-bMobility))/1000 + (positioningScore)/100
	print("Type     | Evaluation")
	print("-----------------")
	print("Material | ".. materialScore/1000)
	print("Mobility | ".. (wMobility-bMobility)/1000)
	print("Position | ".. (positioningScore)/100)
	--add attacks on us v them score
	print("-----------------")
	print("Total    | ".. score)
	return score
end
