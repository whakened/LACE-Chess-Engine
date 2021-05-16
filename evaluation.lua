function evaluatePosition(board, eps, depth, maxNodes, whiteFrom, whiteTo, blackFrom, blackTo)
	vK,vQ,vR,vB,vN,vP = 10000,900,500,350,300,100
	wK,wQ,wR,wB,wN,wP,bK,bQ,bR,bB,bN,bP=0,0,0,0,0,0,0,0,0,0,0,0
	wMobility,bMobility=0,0
	for i=1,64,1 do
		piece=board:sub(i,i)
		if piece=="K" then wK=wK+1 end
		if piece=="Q" then wQ=wQ+1 end
		if piece=="R" then wR=wR+1 end
		if piece=="B" then wB=wB+1 end
		if piece=="N" then wN=wN+1 end
		if piece=="P" then wP=wP+1 end
		if piece=="k" then bK=bK+1 end
		if piece=="q" then bQ=bQ+1 end
		if piece=="r" then bR=bR+1 end
		if piece=="b" then bB=bB+1 end
		if piece=="n" then bN=bN+1 end
		if piece=="p" then bP=bP+1 end
	end
	for _ in pairs(whiteFrom) do wMobility = wMobility + 10 end
	for _ in pairs(blackFrom) do bMobility = bMobility + 10 end

end
function basicEvaluation(board, whiteFrom, blackFrom)
	vK,vQ,vR,vB,vN,vP = 10000,900,500,350,300,100
	wK,wQ,wR,wB,wN,wP,bK,bQ,bR,bB,bN,bP=0,0,0,0,0,0,0,0,0,0,0,0
	wMobility,bMobility=0,0
	for i=1,64,1 do
		piece=board:sub(i,i)
		if piece=="K" then wK=wK+1 end
		if piece=="Q" then wQ=wQ+1 end
		if piece=="R" then wR=wR+1 end
		if piece=="B" then wB=wB+1 end
		if piece=="N" then wN=wN+1 end
		if piece=="P" then wP=wP+1 end
		if piece=="k" then bK=bK+1 end
		if piece=="q" then bQ=bQ+1 end
		if piece=="r" then bR=bR+1 end
		if piece=="b" then bB=bB+1 end
		if piece=="n" then bN=bN+1 end
		if piece=="p" then bP=bP+1 end
	end
	for _ in pairs(whiteFrom) do wMobility = wMobility + 10 end
	for _ in pairs(blackFrom) do bMobility = bMobility + 10 end
	--wScore = ((vK*wK)+(vQ*wQ)+(vR*wR)+(vB*wB)+(vN*wN)+(vP*wP)+wMobility)*(wK+wQ+wR+wB+wN+wP)
	--bScore = ((vK*bK)+(vQ*bQ)+(vR*bR)+(vB*bB)+(vN*bN)+(vP*bP)+bMobility)*(bK+bQ+bR+bB+bN+bP)
	--score = (wScore - bScore)/1000
	materialScore = vK*(wK-bK)+vQ*(wQ-bQ)+vR*(wR-bR)+vK*(wN-bN)+vB*(wB-bB)+vP*(wP-bP)
	score=(materialScore+(wMobility-bMobility))/1000
	print("Type     | Evaluation")
	print("-----------------")
	print("Material | ".. materialScore/1000)
	print("Mobility | ".. (wMobility-bMobility)/1000)
	print("-----------------")
	print("Total    | ".. score)
	return score
end
