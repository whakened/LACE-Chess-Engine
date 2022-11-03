function evaluate(tempBoard, whiteFrom, blackFrom)
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
	for _ in pairs(whiteFrom) do wMobility = wMobility + 10 end
	for _ in pairs(blackFrom) do bMobility = bMobility + 10 end
	materialScore = (vK*(wK-bK)+vQ*(wQ-bQ)+vR*(wR-bR)+vN*(wN-bN)+vB*(wB-bB)+vP*(wP-bP))+((wK+wQ+wR+wB+wN+wP)-(bK+bQ+bR+bB+bN+bP))*10
	score = (materialScore+(wMobility-bMobility))/500 + (positioningScore)/1000
	require("pawns")
	checkPawns(tempBoard, "w")
	score = score - 0.1*(isolatedPawns+backwardsPawns+doubledPawns+blockedPawns)
	checkPawns(tempBoard, "b")
	score = score + 0.1*(isolatedPawns+backwardsPawns+doubledPawns+blockedPawns)
	return bestScore
end
tempBoard = "rnbqkbnrpppppppp................................PPPPPPPPRNBQKBNR"
whiteFrom,blackFrom = 25,25
print(evaluate(tempBoard,whiteFrom,blackFrom))
