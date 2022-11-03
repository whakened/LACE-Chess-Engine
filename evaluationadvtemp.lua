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

require("movegen")
require("legalmovegen")
require("pawns")
function iteratewhite(depth)
  moveGeneration(board, eps) --just the normal board
  whiteFrom = generatedFromSquaresWhite
  whiteFromStart = generatedFromSquaresWhite
  local saveListWhite = {}
  local saveListBlack = {}
  local blackFrom
  local blackTo
  local whiteTo = generatedToSquaresWhite
  local completed = false
  local iterationnum = 0
  local whiteQueueRunning = false
  local blackQueueRunning = false
  local megalist = {}

  function sleep(n)
    if n > 0 then os.execute("ping -n " .. tonumber(n+1) .. " localhost > NUL") end
  end

  function checkwhitelooprunning()
     whiteQueueRunning = false
     sleep(0.1)
     if whiteQueueRunning == false then
        return false
     else
        return true
     end
  end

  function checkblacklooprunning()
     blackQueueRunning = false
     sleep(0.1)
     if blackQueueRunning == false then
        return false
     else
        return true
     end
  end

  function whiteside(wf,wt,num)
     if iterationnum == depth then
        return
      end
     for w in pairs(wf) do
      whiteQueueRunning = true
      totalMovesWhite = totalMovesWhite + 1 -- i am assuming i need this here so i will add them, remove if no need
      tempBoard = tempBoard:sub(1,(wt[w])-1) .. tempBoard:sub(wf[w],wf[w]) .. tempBoard:sub((wt[w])+1,64)
      tempBoard = tempBoard:sub(1,(wf[w])-1) ..".".. tempBoard:sub((wf[w])+1,64)
      moveGeneration(tempBoard, eps)
      blackFrom = generatedFromSquaresBlack
      blackTo = generatedToSquaresBlack
	  saveListBlackLength = 0
	  for _ in pairs(saveListBlack) do saveListBlackLength = saveListBlackLength + 1 end
      saveListBlack[saveListBlackLength + 1] = blackFrom
	  saveListBlackLength = 0
	  for _ in pairs(saveListBlack) do saveListBlackLength = saveListBlackLength + 1 end
      saveListBlack[saveListBlackLength + 1] = blackTo
	  wfLength = 0
	  for _ in pairs(wf) do wfLength = wfLength + 1 end
      if w == wfLength then
        for slb in pairs(saveListBlack) do
          coroutine.create(function()
            if num then
              blackside(saveListBlack[slb], saveListBlack[slb + 1], num)
            else
              blackside(saveListBlack[slb], saveListBlack[slb + 1], slb)
            end
          end)
        end
        saveListBlack = {}
        if not checkwhitelooprunning() then
          iterationnum = iterationnum + 1
        end
      end
    end
  end

  function blackside(bf,bt,num)
    if iterationnum == depth then
      return
    end
    for b in pairs(bf) do
      blackQueueRunning = true
      totalMovesBlack = totalMovesBlack + 1 -- i am assuming i need this here so i will add them, remove if no need
      tempBoard = tempBoard:sub(1,(bt[b])-1) .. tempBoard:sub(bf[b],bf[b]) .. tempBoard:sub((bt[b])+1,64)
      tempBoard = tempBoard:sub(1,(bf[b])-1) ..".".. tempBoard:sub((bf[b])+1,64)
      moveGeneration(tempBoard, eps)
      whiteFrom = generatedFromSquaresWhite
      whiteTo = generatedToSquaresWhite
	  saveListWhiteLength = 0
	  for _ in pairs(saveListWhite) do saveListWhiteLength = saveListWhiteLength + 1 end
      saveListWhite[saveListWhiteLength + 1] = whiteFrom
	  saveListWhiteLength = 0
	  for _ in pairs(saveListWhite) do saveListWhiteLength = saveListWhiteLength + 1 end
      saveListWhite[saveListWhiteLength + 1] = whiteTo
	  megalistLength = 0
	  for _ in pairs(megalist) do megalistLength = megalistLength + 1 end
      megalist[megalistLength + 1] = evaluate(tempBoard, whiteFrom, blackFrom)
	  bfLength = 0
	  for _ in pairs(bf) do bfLength = bfLength + 1 end
      if b == bfLength then
        for slw in pairs(saveListWhite) do
          coroutine.create(function()
             whiteside(saveListWhite[slw], saveListWhite[slw + 1], num)
          end)
        end
        saveListWhite = {}
        if not checkblacklooprunning() then
          iterationnum = iterationnum + 1
        end
      end
    end
  end

  whiteside(whiteFrom,whiteTo)

  return megalist
end
function evaluatePosition(theBoard, enps, depth, maxNodes, whiteFrom, whiteTo, blackFrom, blackTo)
	board = theBoard
	eps = enps
	iteratewhite(1)
	evalLength = 0
	for _ in pairs(megalist) do evalLength = evalLength + 1 end
	print(evalLength)
end
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
    return score
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
