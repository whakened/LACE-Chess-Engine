N,E,S,W = -8,1,8,-1
generatedFromSquaresWhite = {}
generatedToSquaresWhite = {}
totalMovesWhite = 0
function checkFile(tile) --check what file the specified tile is on
	if tile==1 or tile==9 or tile==17 or tile==25 or tile==33 or tile==41 or tile==49 or tile==57 then
		return "a"
	elseif tile==2 or tile==10 or tile==18 or tile==26 or tile==34 or tile==42 or tile==50 or tile==58 then
		return "b"
	elseif tile==3 or tile==11 or tile==19 or tile==27 or tile==35 or tile==43 or tile==51 or tile==59 then
		return "c"
	elseif tile==4 or tile==12 or tile==20 or tile==28 or tile==36 or tile==44 or tile==52 or tile==60 then
		return "d"
	elseif tile==5 or tile==13 or tile==21 or tile==29 or tile==37 or tile==45 or tile==53 or tile==61 then
		return "e"
	elseif tile==6 or tile==14 or tile==22 or tile==30 or tile==38 or tile==46 or tile==54 or tile==62 then
		return "f"
	elseif tile==7 or tile==15 or tile==23 or tile==31 or tile==39 or tile==47 or tile==55 or tile==63 then
		return "g"
	elseif tile==8 or tile==16 or tile==24 or tile==32 or tile==40 or tile==48 or tile==56 or tile==64 then
		return "h"
	end
end
function checkRank(tile) --check what rank the specified tile is on
	--print(b)
	if tile>=1 and tile<=8 then
		return "8"
	elseif tile>=9 and tile<=16 then
		return "7"
	elseif tile>=17 and tile<=24 then
		return "6"
	elseif tile>=25 and tile<=32 then
		return "5"
	elseif tile>=33 and tile<=40 then
		return "4"
	elseif tile>=41 and tile<=48 then
		return "3"
	elseif tile>=49 and tile<=56 then
		return "2"
	elseif tile>=57 and tile<=64 then
		return "1"
	else
		return "nilRank"
	end
end
function checkSquare(b, tile) --check what type of piece is on the specified tile, requires board to check string
	--print(b)
	if b:sub(tile,tile)=="P" or b:sub(tile,tile)=="N" or b:sub(tile,tile)=="B" or b:sub(tile,tile)=="R" or b:sub(tile,tile)=="Q" or b:sub(tile,tile)=="K" then
		return "whitePiece"
	elseif b:sub(tile,tile)=="p" or b:sub(tile,tile)=="n" or b:sub(tile,tile)=="b" or b:sub(tile,tile)=="r" or b:sub(tile,tile)=="q" or b:sub(tile,tile)=="k" then
		return "blackPiece"
	elseif b:sub(tile,tile)=="." then
		return "emptySpace"
	--elseif b:sub(tile,tile)=="K" then               --commented, since we want the kings to be attackable to determine check
	--	return "whiteKing"
	--elseif b:sub(tile,tile)=="k" then
	--	return "blackKing"
	else
		return "nilEntry"
	end
end
function moveGeneration(board, enPassantSquare) --generate moves for white and black
	N,E,S,W = -8,1,8,-1 --general directions
	generatedFromSquaresWhite = {} --white's move table (squares the pieces move *from*)
	generatedToSquaresWhite = {} --white's move table (squares the pieces move *to*)
	totalMovesWhite = 0 --prepare how many psuedo-legal moves white has
	generatedFromSquaresBlack = {} --black's move table (squares the pieces move *from*)
	generatedToSquaresBlack = {} --black's move table (squares the pieces move *to*)
	totalMovesBlack = 0 --prepare how many psuedo-legal moves black has
	--print(board)
	local storedBoard = board --not needed due to realization that board should work perfectly fine, but im too lazy to remove this
	--print(storedBoard)
	for i=1,64,1 do --loop through the whole board
		if board:sub(i,i)=="P" then --if we find a white pawn, then [pawn logic]
			if (checkSquare(storedBoard, i+N)=="emptySpace") and (checkRank(i)~="8") then --don't try moving it forward on another piece, and don't try moving pawn out of the board
				table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,i+N) --add to move tables
				if (checkSquare(storedBoard, i+N+N)=="emptySpace") and (checkRank(i)=="2") then --double advance logic, same as before just yknow dont move on another piece
					table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,i+N+N); --add to move tables
				end
			end
			if (checkFile(i)~="a") and (checkSquare(storedBoard, i+N+W)=="blackPiece") or (i+N+W == enPassantSquare) then --if we can capture forwards to the left
				table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,i+N+W) --add to move tables
			end
			if (checkFile(i)~="h") and (checkSquare(storedBoard, i+N+E)=="blackPiece") then --if we can capture forwards to the right
				table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,i+N+E) --add to move tables
			end
		elseif board:sub(i,i)=="N" then  --if we find a white knight, then [knight logic]
			if (checkSquare(storedBoard, i+N+N+W)=="emptySpace") or (checkSquare(storedBoard, i+N+N+W)=="blackPiece") then --if its a square we can land on
				if (checkRank(i)~="8") and (checkRank(i)~="7") and (checkFile(i)~="a") then --dont let knight move improperly
					table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,i+N+N+W) --add to move tables
				end
			end
			if (checkSquare(storedBoard, i+N+N+E)=="emptySpace") or (checkSquare(storedBoard, i+N+N+E)=="blackPiece") then --keep doing different knight move checks
				if (checkRank(i)~="8") and (checkRank(i)~="7") and (checkFile(i)~="h") then
					table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,i+N+N+E)
				end
			end
			if (checkSquare(storedBoard, i+E+E+N)=="emptySpace") or (checkSquare(storedBoard, i+E+E+N)=="blackPiece") then
				if (checkRank(i)~="8") and (checkFile(i)~="g") and (checkFile(i)~="h") then
					table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,i+E+E+N)
				end
			end
			if (checkSquare(storedBoard, i+E+E+S)=="emptySpace") or (checkSquare(storedBoard, i+E+E+S)=="blackPiece") then
				if (checkRank(i)~="1") and (checkFile(i)~="g") and (checkFile(i)~="h") then
					table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,i+E+E+S)
				end
			end
			if (checkSquare(storedBoard, i+S+S+E)=="emptySpace") or (checkSquare(storedBoard, i+S+S+E)=="blackPiece") then
				if (checkRank(i)~="1") and (checkRank(i)~="2") and (checkFile(i)~="h") then
					table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,i+S+S+E)
				end
			end
			if (checkSquare(storedBoard, i+S+S+W)=="emptySpace") or (checkSquare(storedBoard, i+S+S+W)=="blackPiece") then
				if (checkRank(i)~="1") and (checkRank(i)~="2") and (checkFile(i)~="a") then
					table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,i+S+S+W)
				end
			end
			if (checkSquare(storedBoard, i+W+W+S)=="emptySpace") or (checkSquare(storedBoard, i+W+W+S)=="blackPiece") then
				if (checkRank(i)~="1") and (checkFile(i)~="a") and (checkFile(i)~="b") then
					table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,i+W+W+S)
				end
			end
			if (checkSquare(storedBoard, i+W+W+N)=="emptySpace") or (checkSquare(storedBoard, i+W+W+N)=="blackPiece") then
				if (checkRank(i)~="8") and (checkFile(i)~="a") and (checkFile(i)~="b") then
					table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,i+W+W+N)
				end
			end
		elseif board:sub(i,i)=="B" or board:sub(i,i)=="Q" then --if its a white bishop or a queen
			tileDo = i
			for ii=1,8,1 do --loop to make sliders work properly
				if (checkSquare(storedBoard, tileDo+N+E)=="emptySpace") and (checkRank(tileDo)~="8") and (checkFile(tileDo)~="h") then --if the move is logical
					table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,tileDo+N+E) --add to move tables
				elseif (checkSquare(storedBoard, tileDo+N+E)=="blackPiece") and (checkRank(tileDo)~="8") and (checkFile(tileDo)~="h") then --if its logical but its a capture
					table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,tileDo+N+E) --add to move tables
					break --end loop since we don't want to move past a piece
				else --if its not a logical move at all
					break --end loop since we dont want an illogical move
				end
				tileDo=tileDo+N+E --increment tile to check, otherwise we have several entries for one legal move
			end
			tileDo = i --reset tileDo to the current square for other move checks
			for ii=1,8,1 do --same stuff as before but now its a different direction
				if (checkSquare(storedBoard, tileDo+E+S)=="emptySpace")  and (checkRank(tileDo)~="1") and (checkFile(tileDo)~="h") then
					table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,tileDo+E+S)
				elseif (checkSquare(storedBoard, tileDo+E+S)=="blackPiece") and (checkRank(tileDo)~="1") and (checkFile(tileDo)~="h") then
					table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,tileDo+E+S)
					break
				else
					break
				end
				tileDo=tileDo+E+S
			end
			tileDo = i
			for ii=1,8,1 do
				if (checkSquare(storedBoard, tileDo+S+W)=="emptySpace")  and (checkRank(tileDo)~="1") and (checkFile(tileDo)~="a") then
					table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,tileDo+S+W)
				elseif (checkSquare(storedBoard, tileDo+S+W)=="blackPiece") and (checkRank(tileDo)~="1") and (checkFile(tileDo)~="a") then
					table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,tileDo+S+W)
					break
				else
					break
				end
				tileDo=tileDo+S+W
			end
			tileDo = i
			for ii=1,8,1 do
				if (checkSquare(storedBoard, tileDo+N+W)=="emptySpace")  and (checkRank(tileDo)~="8") and (checkFile(tileDo)~="a") then
					table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,tileDo+N+W)
				elseif (checkSquare(storedBoard, tileDo+N+W)=="blackPiece") and (checkRank(tileDo)~="8") and (checkFile(tileDo)~="a") then
					table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,tileDo+N+W)
					break
				else
					break
				end
				tileDo=tileDo+N+W
			end
		elseif board:sub(i,i)=="R" or board:sub(i,i)=="Q" then --if its a white rook or a queen
			tileDo = i --same stuff as bishop logic, just now its in up/down/left/right
			for ii=1,8,1 do
				if (checkSquare(storedBoard, tileDo+N)=="emptySpace") and (checkRank(tileDo)~="8") then
					table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,tileDo+N)
				elseif (checkSquare(storedBoard, tileDo+N)=="blackPiece") and (checkRank(tileDo)~="8") then
					table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,tileDo+N)
					break
				else
					break
				end
				tileDo=tileDo+N
			end
			tileDo = i
			for ii=1,8,1 do
				if (checkSquare(storedBoard, tileDo+E)=="emptySpace") and (checkFile(tileDo)~="h") then
					table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,tileDo+E)
				elseif (checkSquare(storedBoard, tileDo+E)=="blackPiece") and (checkFile(tileDo)~="h") then
					table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,tileDo+E)
					break
				else
					break
				end
				tileDo=tileDo+E
			end
			tileDo = i
			for ii=1,8,1 do
				if (checkSquare(storedBoard, tileDo+S)=="emptySpace") and (checkRank(tileDo)~="1") then
					table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,tileDo+S)
				elseif (checkSquare(storedBoard, tileDo+S)=="blackPiece") and (checkRank(tileDo)~="1") then
					table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,tileDo+S)
					break
				else
					break
				end
				tileDo=tileDo+S
			end
			tileDo = i
			for ii=1,8,1 do
				if (checkSquare(storedBoard, tileDo+W)=="emptySpace") and (checkFile(tileDo)~="a") then
					table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,tileDo+W)
				elseif (checkSquare(storedBoard, tileDo+W)=="blackPiece") and (checkFile(tileDo)~="a") then
					table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,tileDo+W)
					break
				else
					break
				end
				tileDo=tileDo+W
			end
		elseif board:sub(i,i)=="K" then --if its a white king
			if (checkSquare(storedBoard, i+N)=="emptySpace") or (checkSquare(storedBoard, i+N)=="blackPiece") and (checkRank(i)~="8") then --all the rook and bishop moves but one time
				table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,i+N)
			end
			if (checkSquare(storedBoard, i+N+E)=="emptySpace") or (checkSquare(storedBoard, i+N+E)=="blackPiece") and (checkRank(i)~="8") and (checkFile(i)~="h") then
				table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,i+N+E)
			end
			if (checkSquare(storedBoard, i+E)=="emptySpace") or (checkSquare(storedBoard, i+E)=="blackPiece") and (checkFile(i)~="h") then
				table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,i+E)
			end
			if (checkSquare(storedBoard, i+E+S)=="emptySpace") or (checkSquare(storedBoard, i+E+S)=="blackPiece") and (checkRank(i)~="1") and (checkFile(i)~="h") then
				table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,i+E+S)
			end
			if (checkSquare(storedBoard, i+S)=="emptySpace") or (checkSquare(storedBoard, i+S)=="blackPiece") and (checkRank(i)~="1") then
				table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,i+S)
			end
			if (checkSquare(storedBoard, i+S+W)=="emptySpace") or (checkSquare(storedBoard, i+S+W)=="blackPiece")and (checkRank(i)~="1") and (checkFile(i)~="a") then
				table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,i+S+W)
			end
			if (checkSquare(storedBoard, i+W)=="emptySpace") or (checkSquare(storedBoard, i+W)=="blackPiece") and (checkFile(i)~="a") then
				table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,i+W)
			end
			if (checkSquare(storedBoard, i+W+N)=="emptySpace") or (checkSquare(storedBoard, i+W+N)=="blackPiece") and (checkRank(i)~="8") and (checkFile(i)~="a") then
				table.insert(generatedFromSquaresWhite,i); table.insert(generatedToSquaresWhite,i+W+N)
			end
		elseif board:sub(i,i)=="p" then --same stuff as before just for the black pieces
			if (checkSquare(storedBoard, i+S)=="emptySpace") and (checkRank(i)~="1") then
				table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,i+S)
				if (checkSquare(storedBoard, i+S+S)=="emptySpace") and (checkRank(i)=="7") then
					table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,i+S+S);
				end
			end
			if (checkFile(i)~="a") and (checkSquare(storedBoard, i+S+W)=="whitePiece") then
				table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,i+S+W)
			end
			if (checkFile(i)~="h") and (checkSquare(storedBoard, i+S+E)=="whitePiece") then
				table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,i+S+E)
			end
		elseif board:sub(i,i)=="n" then
			if (checkSquare(storedBoard, i+N+N+W)=="emptySpace") or (checkSquare(storedBoard, i+N+N+W)=="whitePiece") then
				if (checkRank(i)~="8") and (checkRank(i)~="7") and (checkFile(i)~="a") then
					table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,i+N+N+W)
				end
			end
			if (checkSquare(storedBoard, i+N+N+E)=="emptySpace") or (checkSquare(storedBoard, i+N+N+E)=="whitePiece") then
				if (checkRank(i)~="8") and (checkRank(i)~="7") and (checkFile(i)~="h") then
					table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,i+N+N+E)
				end
			end
			if (checkSquare(storedBoard, i+E+E+N)=="emptySpace") or (checkSquare(storedBoard, i+E+E+N)=="whitePiece") then
				if (checkRank(i)~="8") and (checkFile(i)~="g") and (checkFile(i)~="h") then
					table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,i+E+E+N)
				end
			end
			if (checkSquare(storedBoard, i+E+E+S)=="emptySpace") or (checkSquare(storedBoard, i+E+E+S)=="whitePiece") then
				if (checkRank(i)~="1") and (checkFile(i)~="g") and (checkFile(i)~="h") then
					table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,i+E+E+S)
				end
			end
			if (checkSquare(storedBoard, i+S+S+E)=="emptySpace") or (checkSquare(storedBoard, i+S+S+E)=="whitePiece") then
				if (checkRank(i)~="1") and (checkRank(i)~="2") and (checkFile(i)~="h") then
					table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,i+S+S+E)
				end
			end
			if (checkSquare(storedBoard, i+S+S+W)=="emptySpace") or (checkSquare(storedBoard, i+S+S+W)=="whitePiece") then
				if (checkRank(i)~="1") and (checkRank(i)~="2") and (checkFile(i)~="a") then
					table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,i+S+S+W)
				end
			end
			if (checkSquare(storedBoard, i+W+W+S)=="emptySpace") or (checkSquare(storedBoard, i+W+W+S)=="whitePiece") then
				if (checkRank(i)~="1") and (checkFile(i)~="a") and (checkFile(i)~="b") then
					table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,i+W+W+S)
				end
			end
			if (checkSquare(storedBoard, i+W+W+N)=="emptySpace") or (checkSquare(storedBoard, i+W+W+N)=="whitePiece") then
				if (checkRank(i)~="8") and (checkFile(i)~="a") and (checkFile(i)~="b") then
					table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,i+W+W+N)
				end
			end
		elseif board:sub(i,i)=="b" or board:sub(i,i)=="q" then
			tileDo = i
			for ii=1,8,1 do
				if (checkSquare(storedBoard, tileDo+N+E)=="emptySpace") and (checkRank(tileDo)~="8") and (checkFile(tileDo)~="h") then
					table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,tileDo+N+E)
				elseif (checkSquare(storedBoard, tileDo+N+E)=="whitePiece") and (checkRank(tileDo)~="8") and (checkFile(tileDo)~="h") then
					table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,tileDo+N+E)
					break
				else
					break
				end
				tileDo=tileDo+N+E
			end
			tileDo = i
			for ii=1,8,1 do
				if (checkSquare(storedBoard, tileDo+E+S)=="emptySpace")  and (checkRank(tileDo)~="1") and (checkFile(tileDo)~="h") then
					table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,tileDo+E+S)
				elseif (checkSquare(storedBoard, tileDo+E+S)=="whitePiece") and (checkRank(tileDo)~="1") and (checkFile(tileDo)~="h") then
					table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,tileDo+E+S)
					break
				else
					break
				end
				tileDo=tileDo+E+S
			end
			tileDo = i
			for ii=1,8,1 do
				if (checkSquare(storedBoard, tileDo+S+W)=="emptySpace")  and (checkRank(tileDo)~="1") and (checkFile(tileDo)~="a") then
					table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,tileDo+S+W)
				elseif (checkSquare(storedBoard, tileDo+S+W)=="whitePiece") and (checkRank(tileDo)~="1") and (checkFile(tileDo)~="a") then
					table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,tileDo+S+W)
					break
				else
					break
				end
				tileDo=tileDo+S+W
			end
			tileDo = i
			for ii=1,8,1 do
				if (checkSquare(storedBoard, tileDo+N+W)=="emptySpace")  and (checkRank(tileDo)~="8") and (checkFile(tileDo)~="a") then
					table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,tileDo+N+W)
				elseif (checkSquare(storedBoard, tileDo+N+W)=="whitePiece") and (checkRank(tileDo)~="8") and (checkFile(tileDo)~="a") then
					table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,tileDo+N+W)
					break
				else
					break
				end
				tileDo=tileDo+N+W
			end
		elseif board:sub(i,i)=="r" or board:sub(i,i)=="q" then
			tileDo = i
			for ii=1,8,1 do
				if (checkSquare(storedBoard, tileDo+N)=="emptySpace") and (checkRank(tileDo)~="8") then
					table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,tileDo+N)
				elseif (checkSquare(storedBoard, tileDo+N)=="whitePiece") and (checkRank(tileDo)~="8") then
					table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,tileDo+N)
					break
				else
					break
				end
				tileDo=tileDo+N
			end
			tileDo = i
			for ii=1,8,1 do
				if (checkSquare(storedBoard, tileDo+E)=="emptySpace") and (checkFile(tileDo)~="h") then
					table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,tileDo+E)
				elseif (checkSquare(storedBoard, tileDo+E)=="whitePiece") and (checkFile(tileDo)~="h") then
					table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,tileDo+E)
					break
				else
					break
				end
				tileDo=tileDo+E
			end
			tileDo = i
			for ii=1,8,1 do
				if (checkSquare(storedBoard, tileDo+S)=="emptySpace") and (checkRank(tileDo)~="1") then
					table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,tileDo+S)
				elseif (checkSquare(storedBoard, tileDo+S)=="whitePiece") and (checkRank(tileDo)~="1") then
					table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,tileDo+S)
					break
				else
					break
				end
				tileDo=tileDo+S
			end
			tileDo = i
			for ii=1,8,1 do
				if (checkSquare(storedBoard, tileDo+W)=="emptySpace") and (checkFile(tileDo)~="a") then
					table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,tileDo+W)
				elseif (checkSquare(storedBoard, tileDo+W)=="whitePiece") and (checkFile(tileDo)~="a") then
					table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,tileDo+W)
					break
				else
					break
				end
				tileDo=tileDo+W
			end
		elseif board:sub(i,i)=="k" then
			if (checkSquare(storedBoard, i+N)=="emptySpace") or (checkSquare(storedBoard, i+N)=="whitePiece") and (checkRank(i)~="8") then
				table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,i+N)
			end
			if (checkSquare(storedBoard, i+N+E)=="emptySpace") or (checkSquare(storedBoard, i+N+E)=="whitePiece") and (checkRank(i)~="8") and (checkFile(i)~="h") then
				table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,i+N+E)
			end
			if (checkSquare(storedBoard, i+E)=="emptySpace") or (checkSquare(storedBoard, i+E)=="whitePiece") and (checkFile(i)~="h") then
				table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,i+E)
			end
			if (checkSquare(storedBoard, i+E+S)=="emptySpace") or (checkSquare(storedBoard, i+E+S)=="whitePiece") and (checkRank(i)~="1") and (checkFile(i)~="h") then
				table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,i+E+S)
			end
			if (checkSquare(storedBoard, i+S)=="emptySpace") or (checkSquare(storedBoard, i+S)=="whitePiece") and (checkRank(i)~="1") then
				table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,i+S)
			end
			if (checkSquare(storedBoard, i+S+W)=="emptySpace") or (checkSquare(storedBoard, i+S+W)=="whitePiece")and (checkRank(i)~="1") and (checkFile(i)~="a") then
				table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,i+S+W)
			end
			if (checkSquare(storedBoard, i+W)=="emptySpace") or (checkSquare(storedBoard, i+W)=="whitePiece") and (checkFile(i)~="a") then
				table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,i+W)
			end
			if (checkSquare(storedBoard, i+W+N)=="emptySpace") or (checkSquare(storedBoard, i+W+N)=="whitePiece") and (checkRank(i)~="8") and (checkFile(i)~="a") then
				table.insert(generatedFromSquaresBlack,i); table.insert(generatedToSquaresBlack,i+W+N)
			end
		end
	end
	for _ in pairs(generatedFromSquaresWhite) do totalMovesWhite = totalMovesWhite + 1 end --set how many psuedo-legal moves white has
	for _ in pairs(generatedFromSquaresBlack) do totalMovesBlack = totalMovesBlack + 1 end --set how many psuedo-legal moves black has
	--print(totalMovesWhite)
	--print("succlsles")
	--require("legalmovegen")
	--checkLegality(board, generatedFromSquaresWhite, generatedToSquaresWhite, generatedFromSquaresBlack, generatedToSquaresBlack, enPassantSquare, "w")
	--whiteFrom=newWhiteFrom
	--whiteTo=newWhiteTo
	--checkLegality(board, generatedFromSquaresWhite, generatedToSquaresWhite, generatedFromSquaresBlack, generatedToSquaresBlack, enPassantSquare, "b")
	--blackFrom=newBlackFrom
	--blackTo=newBlackTo
	--totalMovesWhite=0
	--totalMovesBlack=0
	--for _ in pairs(whiteFrom) do totalMovesWhite = totalMovesWhite + 1 end --set how many legal moves white has
	--for _ in pairs(whiteTo) do totalMovesBlack = totalMovesBlack + 1 end --set how many legal moves black has
	return totalMovesWhite,totalMovesBlack,generatedFromSquaresWhite,generatedToSquaresWhite,generatedFromSquaresBlack,generatedToSquaresBlack --return all our variables
end
