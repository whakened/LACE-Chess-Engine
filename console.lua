local cmd = ""
local board = "rnbqkbnrpppppppp................................PPPPPPPPRNBQKBNR"
local startpos = board
enPassantSquare = 0
castlingRights = {true,true,true,true} --white O-O, white O-O-O, black O-O, black O-O-O
print('LACE (Lua Alternative Chess Engine) 0.0.1alpha | Developed by WhakeNeD')
print("Enter 'Help' for a list of commands")
print("")
function mainBody()
	cmdproper = io.read()
	cmd = string.lower(cmdproper)
	print("")
	if cmd=="help" then print("Commands:\nHelp | Shows a list of commands\n\nBoardstate [action] [type/input] | A set of commands referring to the board\n\tGet [type] | Shows the board following the third parameter\n\t\tRaw | Shows the board's string by itself\n\t\tFormatted [side] | Shows the board as an 8x8 box\n\t\t\tW | From white's perspective\n\t\t\tB | From black's perspective\n\tSet [input] | Sets the board\n\t\tStartpos | Sets the board to the starting position of a normal game\n\t\t[Raw board] | Sets the board to a specific board, definable by 'boardstate get raw'\n\nAction [action] | Performs a specific task\n\tMove [x#y#] | Moves a piece on the board from [x#] to [y#]. Uses long algebraic notation\n\nLace [task] | Makes LACE perform a task on the board\n\tEvaluate [side] | Returns an evaluation of the labelled side\n\t\tw | White\n\t\tb | Black\n\tMove [side] | Makes a move on the labelled side\n\t\tw | White\n\t\tb | Black\n\nExit | Exits the engine")
	elseif cmd:sub(1,10)=="boardstate" then
		if cmd:sub(12,14)=="get" then
			if cmd:sub(16,18)=="raw" then print(board)
			elseif cmd:sub(16,24)=="formatted" then
				--print(board:sub(1,8) .."\n".. board:sub(9,16) .."\n".. board:sub(17,24) .."\n".. board:sub(25,32) .."\n".. board:sub(33,40) .."\n".. board:sub(41,48) .."\n".. board:sub(49,56) .."\n".. board:sub(57,64))
				if cmd:sub(26,26)=="w" then accessDetailedBoard(1)
				elseif cmd:sub(26,26)=="b" then accessDetailedBoard(2)
				else print("Invalid command.") end
			else print("Invalid command.") end
		elseif cmd:sub(12,14)=="set" then
			if cmd:sub(16,23)=="startpos" then board=startpos
			elseif (cmdproper:sub(16,79)) then board=cmdproper:sub(16,79)
			else print("Invalid command.") end
		else print("Invalid command.") end
	elseif cmd:sub(1,6)=="action" then
		if cmd:sub(8,11)=="move" then
			require("boardmanipulation")
			moveInterpret(cmd:sub(13,16))
			local tBoard = board:sub(1,toSquare-1) .. board:sub(fromSquare,fromSquare) .. board:sub(toSquare+1,64)
			local tBoard = tBoard:sub(1,fromSquare-1) ..".".. tBoard:sub(fromSquare+1,64)
			board=tBoard
		else print("Invalid command.") end
	elseif cmd:sub(1,4)=="lace" then
		if cmd:sub(6,13)=="evaluate" then
			print("Evaluation does not yet exist with LACE.")
		elseif cmd:sub(6,9)=="move" then
			if cmd:sub(11,11)=="w" then
				require("movegen")
				moveGeneration(board, enPassantSquare)
				print(totalMovesWhite .." possible moves detected for White.")
				math.randomseed(os.time())
				math.random()
				math.random()
				local moveToMake = math.floor((1+(math.random()*totalMovesWhite))+0.5)
				if moveToMake > totalMovesWhite then moveToMake = totalMovesWhite end
				print(whiteFrom[moveToMake] .." goes to ".. whiteTo[moveToMake])
				local tBoard = board:sub(1,(generatedToSquaresWhite[moveToMake])-1) .. board:sub(generatedFromSquaresWhite[moveToMake],generatedFromSquaresWhite[moveToMake]) .. board:sub((generatedToSquaresWhite[moveToMake])+1,64)
				local tBoard = tBoard:sub(1,(generatedFromSquaresWhite[moveToMake])-1) ..".".. tBoard:sub((generatedFromSquaresWhite[moveToMake])+1,64)
				board=tBoard
			elseif cmd:sub(11,11)=="b" then
				require("movegen")
				moveGeneration(board)
				print(totalMovesBlack .." possible moves detected for Black.")
				math.randomseed(os.time())
				math.random()
				math.random()
				local moveToMake = math.floor((1+(math.random()*totalMovesBlack))+0.5)
				if moveToMake > totalMovesBlack then moveToMake = totalMovesBlack end
				print(generatedFromSquaresBlack[moveToMake] .." goes to ".. generatedToSquaresBlack[moveToMake])
				local tBoard = board:sub(1,(generatedToSquaresBlack[moveToMake])-1) .. board:sub(generatedFromSquaresBlack[moveToMake],generatedFromSquaresBlack[moveToMake]) .. board:sub((generatedToSquaresBlack[moveToMake])+1,64)
				local tBoard = tBoard:sub(1,(generatedFromSquaresBlack[moveToMake])-1) ..".".. tBoard:sub((generatedFromSquaresBlack[moveToMake])+1,64)
				board=tBoard
			else print("Invalid command.") end
		else print("Invalid command.") end
	elseif cmd=="exit" then os.exit()
	else print("Invalid command.") end
	mainBody()
end
function accessDetailedBoard(view)
	require("boardmanipulation")
	if view==1 then displayBoard(board) elseif view==2 then displayBoardAsBlack(board) end
end
mainBody()
