CoordMode, Mouse, Window

Class Stone
{
	__New(shape, color := 0)
	{
		if (color != 0)
		{
			this.shape := shape
			this.color := color
		}
		else
		{
			this.shape := shape // 10
			this.color := Mod(shape, 10)
		}
	}
	
	ToInt()
	{
		return ((this.shape * 10) + this.color)
	}
}

Class Pouch
{
	__New(str := "")
	{
		if (str != "")
		{
			this.Clear()
			Loop, Parse, str, `,
				this.Stones[A_Index] := new Stone(A_LoopField)
		}
	}

	Clear()
	{
		this.Stones := Object()
	}
	
	Init()
	{
		tIndex := [1, 2, 3, 4, 5, 6]
		this.ShuffleArray(tIndex)
		tIniStones := Object()
		Loop, 6
		{
			;Les peces inicials han de ser cada una d'una forma i color diferents
			shp := A_Index
			Random, c, 1, tIndex.Length()
			val := tIndex[c]
			tIndex.RemoveAt(c)
			Loop, 6
			{
				col := A_Index
				st := new Stone(shp,col)
				if (A_Index = val) ; si és la que ha sortit per random la guardem per retornar-la a les inicials
					tIniStones.Push(st)
				else
					this.Stones.Push(st)
			}
		}
		this.Stones.InsertAt(1,tIniStones*) ;insertem momentàniament les que queden fora al principi de l'array per duplicar més fàcilment les que hi ha
		this.Stones.InsertAt((this.Stones.Length() + 1), this.Stones*) ;així es dupliquen totes
		this.Stones.RemoveAt(1,6) ;i ara tornem a esborrar les inicials
		this.ShuffleArray(tIniStones)
		return tIniStones
	}
	
	ShuffleArray(ByRef arr)
	{
		Random,, A_TickCount
		
		max := arr.Length()
		Loop
		{
			lim := max - A_Index + 1
			if (lim = 0)
				break
			Random, pos, 1, lim
			elem := arr.RemoveAt(pos)
			arr.InsertAt(max, elem)
		}
	}
	
	Shuffle()
	{
		this.ShuffleArray(this.Stones)
	}
	
	PickStone()
	{
		return this.Stones.Pop()
	}
	
	StonesInPouch()
	{
		return this.Stones.Length()
	}
	
	ToStr()
	{
		str := ""
		Loop, % this.Stones.Length()
			str .= this.Stones[A_Index].ToInt() . ","
		str := RTrim(str, ",")
		return str
	}
}

Class Board
{
	__New(str := "")
	{
		if (str != "")
		{
			this.Clear()
			Loop, Parse, str, `;
			{
				pair := A_LoopField
				Loop, Parse, pair, `,
				{
					if (A_Index = 1)
					{
						pos := A_LoopField - 1
						r := (pos // 12) + 1
						c := Mod(pos, 12) + 1
					}
					else
						this.PutStone(c, r, new Stone(A_LoopField))
				}
			}
		}
	}
	
	Clear()
	{
		this.brd := Object()
	}
	
	SetInitialStones(ByRef tIni)
	{
		pos := [[2,2], [2,13], [9,2], [9,13], [5,7], [6,8]]
		for i, elem in tIni
			this.brd[pos[i][1],pos[i][2]] := elem
		tIni := ""
	}
	
	PutStone(c, r, st)
	{
		c++
		r++
		this.brd[r,c] := st
	}
	
	ValidPlace(c, r, st)
	{
		c++
		r++
		if (this.brd[r,c] != "")
			return 0
		nbors := Object()
		if (this.brd[r-1,c] != "")
			nbors.Push(this.brd[r-1,c])
		if (this.brd[r+1,c] != "")
			nbors.Push(this.brd[r+1,c])
		if (this.brd[r,c-1] != "")
			nbors.Push(this.brd[r,c-1])
		if (this.brd[r,c+1] != "")
			nbors.Push(this.brd[r,c+1])
		nei := nbors.Length()
		if (nei = 0)
		{
			nbors := ""
			return 0
		}
		col := 0
		shp := 0
		both := 0
		for i,v in nbors
		{
			if (v.color = st.color)
			{
				if (v.shape = st.shape)
					both++
				else
					col++
			}
			else
			{
				if (v.shape = st.shape)
					shp++
				else
					return 0
			}
		}
		if (both = 1)
		{
			if (shp > col)
				col++
			else if (col >= shp)
				shp++
		}
		if ((nei = 1 and (col = 1 or shp = 1)) or (nei = 2 and (col = 1 and shp = 1)) or (nei = 3 and (col > 0 and shp > 0)) or (nei = 4 and (col = 2 and shp = 2)))
			return %nei%
		return 0
	}
	
	ThereAreValidPlaces(st)
	{
		pos_mov := []
		Loop, 8 ;rows
		{
			r := A_Index
			Loop, 12 ;cols
			{
				c := A_Index
				matches := this.ValidPlace(c, r, st)
				if (matches > 0)
				{
					pos_mov.Push(r,c,matches)
					return pos_mov
				}
			}
		}
		return ""
	}
	
	ToStr()
	{
		str := ""
		Loop, 8 ;rows
		{
			r := A_Index
			Loop, 12 ;cols
			{
				c := A_Index
				st := this.brd[r + 1, c + 1]
				if (st != "")
				{
					pos := (r - 1) * 12 + c
					str .= pos . "," . st.ToInt() . ";"
				}				
			}
		}
		str := RTrim(str, ";")
		return str
	}
}

Class Game
{
	__New(ByRef pouch, ByRef board)
	{
		this.path := A_ScriptDir . "\pics\"
		this.file_hi := A_ScriptDir . "\hiscores.dat"
		this.pouch := pouch
		this.board := board
		this.SetBoard()
		mh := ObjBindMethod(this, "MenuHandler")
		this.menu := "GameMenu"
		Menu, submenu, Add, New, %mh%
		Menu, submenu, Add, Load, %mh%
		Menu, submenu, Add, Save, %mh%
		Menu, % this.menu, Add, Game, :submenu
		Menu, % this.menu, Add, High Scores, %mh%
		Menu, % this.menu, Add
		Menu, % this.menu, Add, Exit, %mh%
	}
	
	Init()
	{
		if (this.loading)
		{
			this.pouch := this.load_pouch
			this.score := this.load_score
			this.board := this.load_board
			msgbox,, Ishido - Load Game, Game loaded.
		}
		else
		{
			this.pouch.Clear()
			this.board.Clear()
			tIni := this.pouch.Init()
			this.board.SetInitialStones(tIni)
			this.pouch.Shuffle()
			this.score := Object()
			this.score.Push(0, 0, 0) ; first position: FW, second position: points, third position: stones left
		}
		this.GetHiScores()
		this.stop_game := false
		this.load_board := ""
		this.load_score := ""
		this.load_pouch := ""
		this.loading := false
	}
	
	MenuHandler()
	{
		if (A_ThisMenuItem = "Exit")
			ExitApp
		if (A_ThisMenuItem = "New")
		{
			msgbox, 4, Ishido - New Game, Are you sure you want to end current game?
			IfMsgBox, Yes
			{
				this.stop_game := true
				this.move_done := true
			}
			return
		}
		if (A_ThisMenuItem = "High Scores")
		{
			this.ShowHiScores()
			return
		}
		if (A_ThisMenuItem = "Load")
		{
			this.LoadGame()
			this.loading := true
			this.move_done := true
			this.stop_game := true
			return
		}
		if (A_ThisMenuItem = "Save")
		{
			this.SaveGame()
			return
		}
	}
	
	GetHiScores()
	{
		IfExist, % this.file_hi
		{
			this.HiScores := Object()
			Loop, Read, % this.file_hi
			{
				i := A_Index
				Loop, Parse, A_LoopReadLine, `t
					this.HiScores[i,A_Index] := A_LoopField
			}
		}
	}
	
	CreateHiScoresFile()
	{
		IfExist, % this.file_hi
			FileDelete, % this.file_hi
		Loop, 3
		{
			i := A_Index
			str := this.HiScores[i,1] . "`t" . this.HiScores[i,2] . "`t" . this.HiScores[i,3] . "`t" . this.HiScores[i,4]
			if (i < 3)
				str .= "`n"
			FileAppend, %str%, % this.file_hi
		}
	}
	
	UpdateHiScores()
	{
		some_change := false
		FormatTime, hisc_date
		if (this.HiScores != "")
		{
			Loop, 3
			{
				better := (A_Index = 3) ? (this.score[A_Index] <= this.HiScores[A_Index,A_Index]) : (this.score[A_Index] >= this.HiScores[A_Index,A_Index])
				if (better)
				{
					hi := this.score
					hi.Push(hisc_date)
					this.HiScores[A_Index] := hi
					some_change := true
				}
			}
		}
		else
		{
			some_change := true
			Loop, 3
			{
				i := A_Index
				Loop, 3
				{
					v := A_Index
					this.HiScores[i,v] := this.score[v]
				}
				this.HiScores[i,4] := hisc_date
			}
		}
		if (some_change)
			this.ShowHiScores("You made a High Score!`n`n")
		this.CreateHiScoresFile()
	}
	
	ShowHiScores(str := "")
	{
		if (this.HiScores != "")
		{
			str .= "* Higher four-ways achieved: " . this.HiScores[1][1] . "`n    on " . this.HiScores[1][4] . "(with " . this.HiScores[1][2] . " points and " . this.HiScores[1][3] " stones left)`n`n"
			str .= "* Higher score achieved: " . this.HiScores[2][2] . "`n    on " . this.HiScores[2][4] . "(with " . this.HiScores[2][1] . " four-ways and " . this.HiScores[2][3] " stones left)`n`n"
			str .= "* Less stones left in pouch: " . this.HiScores[3][3] . "`n    on " . this.HiScores[3][4] . "(with " . this.HiScores[3][1] . " four-ways and " . this.HiScores[3][2] . " points)"
		}
		else
			str := "No high score achieved yet"
		msgbox,, Ishido - High Scores, %str%
	}
	
	LoadGame()
	{
		FileSelectFile, LoadFile, 3, %A_ScriptDir%, Ishido - Load Game, (*.isg)
		if (LoadFile != "")
		{
			msgbox, 4, Ishido - Load Game, Are you sure you want to load this game?`nCurrent game will end.
			IfMsgBox, Yes
			{
				FileGetSize, size, %LoadFile%
				if (size > 0)
				{
					Loop, 3
					{
						FileReadLine, line, %LoadFile%, A_Index
						if (A_Index = 1) ;score
						{
							this.load_score := Object()
							Loop, Parse, line, `,
								this.load_score.InsertAt(this.load_score.Length() + 1, A_LoopField)
						}
						if (A_Index = 2) ;board
							this.load_board := New Board(line)
						if (A_Index = 3) ;pouch
							this.load_pouch := New Pouch(line)
					}
				}
				else
					msgbox,, Ishido - Load Game, This game cannot be loaded, file is empty.
			}
		}
	}
	
	SaveGame()
	{
		FileSelectFile, SavedFile, S16, %A_ScriptDir%\save.isg, Ishido - Save Game, (*.isg)
		if (SavedFile != "")
		{
			FileDelete, %SavedFile%
			FileAppend, % this.score[1] . "," . this.score[2] . "," . this.score[3] . "`n", %SavedFile%
			FileAppend, % this.board.ToStr() . "`n", %SavedFile%
			FileAppend, % this.pouch.ToStr() . "," . this.touchstone.ToInt(), %SavedFile%
			
			FileGetSize, size, %SavedFile%
			if (size > 0)
				msgbox,, Ishido - Save Game, Game Saved.
			else	
				msgbox,, Ishido - Save Game, There has been some error saving the game...
		}
	}
	
	ClickPic(wParam, lParam, msg, hwnd)
	{
		global
		local X, Y, c, r
		
		if (wParam = 1)
		{
			X := lParam & 0xFFFF
			Y := lParam >> 16
			if (X > 20 and X < 500 and Y > 20 and Y < 500)
			{
				c := Floor((X - 20) / 40) + 1
				r := Floor((Y - 20) / 60) + 1
				this.DrawStone(this.touchstone, c, r)
			}
		}
		if (wParam = 2)
			Menu, % this.menu, Show
	}
	
	UpdateScore(op := "stone", elements := 0)
	{
		global FW, Points
		static tPCH := [1000, 500, 100]
		static tFW := [25, 50, 100, 200, 400, 600, 800, 1000, 5000, 10000, 25000, 50000]
		
		if (op = "pouch")
		{
			if (this.score[3] <= 2)
				this.score[2] += tPCH[this.score[3] + 1]
		}
		else
		{
			play := 2 ** (elements - 1)
			if (this.score[1] > 0)
				play := play * 2 * this.score[1]
			this.score[2] += play
			if (elements = 4)
			{
				this.score[1]++
				GuiControl,, FW, % this.score[1]
				this.score[2] += tFW[this.score[1]]
			}
		}
		GuiControl,, Points, % this.score[2]
	}
	
	ShowScore()
	{
		if (this.score[3] = 0)
			str_bag := "You emptied the bag!"
		else if (this.score[3] = 1)
			str_bag := "You left 1 stone in the pouch."
		else
			str_bag := "You left " . this.score[3] . " stones in the pouch."
			
		return "You made " . this.score[1] . " four-ways and " . this.score[2] . " points.`n" . str_bag . "`nDo you want to play again?"
	}
	
	UpdatePouch()
	{
		global StonesRemaining
		
		GuiControl,, StonesRemaining, % this.pouch.StonesInPouch()
	}
	
	ShowEffectFW(c, r)
	{
		global EffectFW
		
		X := ((c - 2) * 40) + 20
		Y := ((r - 2) * 60) + 20
		GuiControl, Move, EffectFW, x%X% y%Y%
		GuiControl, Show, EffectFW
		Sleep, 800
		GuiControl, Hide, EffectFW
	}
	
	DrawStone(st, c := 0, r := 0)
	{
		global
		
		if (c = 0 or r = 0)
			GuiControl,, StonePicked, % this.path . st.shape . st.color . ".png"
		else
		{
			if (r = this.PossibleMove[1] and c = this.PossibleMove[2])
			{
				matches := this.PossibleMove[3]
				this.PossibleMove := Object()
			}	
			else
				matches := this.board.ValidPlace(c, r, st, true)
			if (matches > 0)
			{
				this.board.PutStone(c, r, st)
				GuiControl,, Pic%r%%c%, % this.path . st.shape . st.color . ".png"
				GuiControl,, StonePicked
				if (matches = 4)
					this.ShowEffectFW(c, r)
				if (c != 1 and c != 12 and r != 1 and r != 8) ;the Within
					this.UpdateScore("stone", matches)
				this.move_done := true
			}
		}
	}
	
	SetBoard()
	{
		global
		local c, r, k, s, X, Y, str
		
		Gui, New, -Resize -MaximizeBox +OwnDialogs
		Gui, Add, Picture, x0 y0, % this.path . "board.png"

		Loop, 8 ;rows
		{
			r := A_Index
			s := r - 1
			Loop, 12 ;cols
			{
				c := A_Index
				k := c - 1
				X:= (k * 40) + 20
				Y:= (s * 60) + 20
				str := "x" . X . " y" . Y . "w40 h60 vPic" . r . c
				Gui, Add, Picture, %str%
			}
		}	
		Gui, Add, Picture, x0 y0 BackgroundTrans Hidden Disabled vEffectFW, % this.path . "FW.png"
		Gui, Add, Picture, x570 y60 w40 h60 vStonePicked
		Gui, Font, s24 q5, Wingdings
		Gui, Add, Text, x560 y200 BackgroundTrans c121212, z
		Gui, Font
		Gui, Font, s16 q5
		Gui, Add, Text, x610 y205 w20 BackgroundTrans c121212 vFW, 0
		Gui, Font
		Gui, Font, s16 q5
		Gui, Add, Text, x520 y290 w140 Center BackgroundTrans c121212 vPoints
		Gui, Font
		Gui, Add, Picture, x530 y370 BackgroundTrans, % this.path . "pouch.png"
		Gui, Font, s24 q5
		Gui, Add, Text, x572 y435 center BackgroundTrans c121212 vStonesRemaining, 65
		Gui, Font
		Gui, Show, w680 h520, Ishido`, the Way of Stones
		OnMessage(0x201, ObjBindMethod(this, "ClickPic"))
		OnMessage(0x204, ObjBindMethod(this, "ClickPic"))
		return
	}
	
	ResetBoard()
	{
		global
		local c, r
		
		Loop, 8 ;rows
		{
			r := A_Index
			Loop, 12 ;cols
			{
				c := A_Index
				st := this.board.brd[r + 1, c + 1]
				if (st != "")
					GuiControl,, Pic%r%%c%, % this.path . st.shape . st.color . ".png"
				else
					GuiControl,, Pic%r%%c%
			}
		}
		GuiControl,, FW, % this.score[1]
		GuiControl,, Points, % this.score[2]		
	}
	
	Play()
	{
		wanna_quit := false
		while (!wanna_quit)
		{
			this.Init()
			this.ResetBoard()
			final := false
			while (!final)
			{
				this.score[3] := this.pouch.StonesInPouch()
				if (this.score[3] = 0)
					final := true
				else
				{
					this.touchstone := this.pouch.PickStone()
					this.DrawStone(this.touchstone)
					this.UpdatePouch()
					this.PossibleMove := this.board.ThereAreValidPlaces(this.touchstone)
					if (this.PossibleMove = "")
					{
						msgbox,, Ishido, There are no more moves.
						final := true
					}
					else
					{
						this.move_done := false
						while (!this.move_done)
							continue
						if (this.stop_game)
							final := true
					}
				}
			}
			if (!this.stop_game)
			{
				this.UpdateScore("pouch")
				msgbox, 4, Ishido - Score, % this.ShowScore()
				IfMsgBox No
					wanna_quit := true
				this.UpdateHiScores()
			}
		}
	}
}

; Main program
pouch := New Pouch
board := New Board
game := New Game(pouch, board)
game.Play()
GuiClose:
ExitApp
