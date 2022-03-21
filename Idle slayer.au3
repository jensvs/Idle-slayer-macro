#comments-start
 AutoIt Version: 3.3.16.0
 Author:         Devil4ngle
#comments-end

; Disable Caps for better background
Opt("SendCapslockMode", 0)
; Set window Mode for PixelSearch
Opt("PixelCoordMode", 0)
; Set window Mode for MouseClick
Opt("MouseCoordMode", 0)

#comments-start
; GUI
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

$IdleSlayerBot = GUICreate("Idle Slayer Bot", 805, 605, 199, 145)
GUISetBkColor(0x696969)
; Create BonusStage GroupBox
$GroupBonusStage = GUICtrlCreateGroup("Bonus Stage", 16, 8, 185, 81, BitOR($GUI_SS_DEFAULT_GROUP,$BS_FLAT))
GUICtrlSetFont(-1, 11, 800, 0, "MS Sans Serif")
; Create Checkbox Hardmode
$CheckBoxHardmode = GUICtrlCreateCheckbox("Hardmode", 32, 32, 97, 17)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
; Create Checkbox Silver Death
$CheckBoxSilverDeath = GUICtrlCreateCheckbox("Silver Death", 32, 56, 97, 17)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
GUICtrlCreateGroup("", -99, -99, 1, 1)

; Create Chesthunt GroupBox
$GroupChesthunt = GUICtrlCreateGroup("Chesthunt", 16, 96, 185, 81, BitOR($GUI_SS_DEFAULT_GROUP,$BS_FLAT))
GUICtrlSetFont(-1, 11, 800, 0, "MS Sans Serif")
; Create Checkbox LockPicking100
$CheckBoxLockPicking100 = GUICtrlCreateCheckbox("Lock Picking 100", 32, 144, 150, 17)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
; Create Checkbox Chesthunt
$CheckBoxChesthunt = GUICtrlCreateCheckbox("Enable Chesthunt", 32, 120, 150, 17)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
GUICtrlCreateGroup("", -99, -99, 1, 1)

; Create Upgrades GroupBox
$GroupUpgrades = GUICtrlCreateGroup("Upgrades", 16, 184, 185, 81, BitOR($GUI_SS_DEFAULT_GROUP,$BS_FLAT))
GUICtrlSetFont(-1, 11, 800, 0, "MS Sans Serif")
; Create Checkbox Auto Buy Equipment
$CheckBoxEquipment = GUICtrlCreateCheckbox("Auto Buy Equipment", 32, 208, 150, 17)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
; Create Checkbox Auto Buy Upgrades
$CheckBoxUpgrades = GUICtrlCreateCheckbox("Auto Buy Upgrades", 32, 232, 150, 17)
GUICtrlSetFont(-1, 10, 400, 0, "MS Sans Serif")
GUICtrlCreateGroup("", -99, -99, 1, 1)

; Create Label and Combobox Bonus Stage Selection
$Combo1 = GUICtrlCreateCombo("Combo1", 384, 16, 65, 28, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
$BonusStageSelection = GUICtrlCreateLabel("Bonus Stage Selection", 232, 16, 150, 20)
GUICtrlSetFont(-1, 11, 400, 0, "MS Sans Serif")

; Create Buttons
$ButtonStart = GUICtrlCreateButton("Start", 16, 336, 75, 25, $BS_FLAT)
$ButtonPause = GUICtrlCreateButton("Pause", 96, 336, 75, 25, $BS_FLAT)
$ButtonStop = GUICtrlCreateButton("Stop", 176, 336, 75, 25, $BS_FLAT)

; Create Console Edit
$EditConsole = GUICtrlCreateEdit("", 16, 368, 769, 217, BitOR($ES_AUTOVSCROLL,$ES_WANTRETURN,$WS_VSCROLL), 0)
GUICtrlSetData(-1, "editconsole")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, 0x000000)

; Create KeyConfig Edit
$KeyConfig = GUICtrlCreateEdit("", 600, 28, 185, 273, BitOR($ES_AUTOVSCROLL,$ES_WANTRETURN,$WS_VSCROLL), 0)
GUICtrlSetData(-1, "KeyConfig")
GUICtrlSetBkColor(-1, 0xC8C8C8)
; Create KeyConfig Label
$KeyConfigLabel = GUICtrlCreateLabel("Key Config", 600, 8, 185, 20, $SS_CENTER)
GUICtrlSetFont(-1, 11, 800, 0, "MS Sans Serif")
GUICtrlSetBkColor(-1, 0xC8C8C8)
GUISetState(@SW_SHOW)

; Create Globals for Checkboxes
Global $Hardmode = False
Global $SilverDeath = False
Global $Chesthunt = False
Global $Lockpicking100 = False
Global $BuyEquipment = False
Global $BuyUpgrades = False
#comments-end


; Infinite Loop
While 1
	ControlFocus("Idle Slayer", "", "")
	ControlSend("Idle Slayer", "", "", "{Up}{Right}{e}")
	Sleep(150)

	#comments-start
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
	#comments-end

	; Silver box collect
	PixelSearch(580, 40, 580, 40, 0xFF0000)
	If Not @error Then
		MouseClick("left", 644, 49, 1, 0)
	EndIf

	; Chest-hunt
	PixelSearch(598, 45, 598, 45, 0xD0C172)
	If Not @error Then
		Chesthunt()
	EndIf


	; Collect minions
	PixelSearch(99, 113, 99, 113, 0xFFFF7A)
	If Not @error Then
		CollectMinion()
	EndIf

	; Bonus stage
	PixelSearch(860, 670, 860, 670, 0xAC8371)
	If Not @error Then
		BonusStage()
	EndIf
WEnd

Func CollectMinion()
	MouseClick("left", 95, 90, 1, 0)
	Sleep(400)
	MouseClick("left", 332, 680, 1, 0)
	Sleep(100)
	MouseClick("left", 318, 182, 1, 0)
	Sleep(100)
	MouseClick("left", 318, 182, 1, 0)
	Sleep(100)
	MouseClick("left", 570, 694, 1, 0)
EndFunc   ;==>CollectMinion

Func Chesthunt()
	Sleep(2000)
	Local $saverX = 0
	Local $saverY = 0
	Local $pixelX = 185
	Local $pixelY = 325
	; Locate saver
	For $y = 1 To 3
		For $x = 1 To 10
			PixelSearch($pixelX, $pixelY - 1, $pixelX + 5, $pixelY, 0xFFEB04)
			If Not @error Then
				$saverX = $pixelX
				$saverY = $pixelY
				ExitLoop (2)
			EndIf
			$pixelX += 95
		Next
		$pixelY += 95
		$pixelX = 185
	Next
	; Actual chest hunt
	$pixelX = 185
	$pixelY = 325
	For $y = 1 To 3
		For $x = 1 To 10
			; After opening 2 chest open saver
			If $x == 3 And $y == 1 And $saverX > 0 Then
				MouseClick("left", $saverX + 33, $saverY - 23, 1, 0)
				Sleep(550)
			EndIf
			; Skip saver no matter what
			If $pixelY == $saverY And $pixelX == $saverX Then
				; Go next line If saver is last chest
				If $x == 10 Then
					ExitLoop (1)
				Else
					$x += 1
					$pixelX += 95
				EndIf
			EndIf
			; Open chest
			MouseClick("left", $pixelX + 33, $pixelY - 23, 1, 0)
			Sleep(550)
			; Check if chest hunt ended
			PixelSearch(400, 695, 400, 695, 0xB40000)
			If Not @error Then
				ExitLoop (2)
			EndIf
			; if mimic wait some more
			PixelSearch(434, 211, 434, 211, 0xFF0000)
			If Not @error Then
				Sleep(1500)
			EndIf
			$pixelX += 95
		Next
		$pixelY += 95
		$pixelX = 185
	Next
	; Look for close button until found
	Do
		Sleep(50)
		PixelSearch(400, 694, 400, 694, 0xB40000)
	Until Not @error
	MouseClick("left", 643, 693, 1, 0)
	; Boost and sleep
	ControlSend("Idle Slayer", "", "", "{Right}")
	Sleep(2000)
EndFunc   ;==>Chesthunt

Func BonusStage()
	BonusStageSlider()
	Sleep(4000)
	PixelSearch(443, 97, 443, 97, 0xFFFFFF)
	If Not @error Then ;if Spirit Boost do noting untill close appear
		Do
			Sleep(200)
		Until BonusStageFail()
	Else
		;Run until block
		Do
			Sleep(200)
			PixelSearch(220, 465, 220, 465, 0xA0938E)
		Until Not @error
		Sleep(200)
		BonusStageNSP()
	EndIf

EndFunc   ;==>BonusStage

Func BonusStageSlider()
	;Top left
	PixelSearch(443, 560, 443, 560, 0x007E00)
	If Not @error Then
		MouseClickDrag("left", 840, 560, 450, 560)
		Return
	EndIf

	;Bottom left
	PixelSearch(443, 620, 443, 620, 0x007E00)
	If Not @error Then
		MouseClickDrag("left", 840, 620, 450, 620)
		Return
	EndIf

	;Top right
	PixelSearch(850, 560, 850, 560, 0x007E00)
	If Not @error Then
		MouseClickDrag("left", 450, 560, 840, 560)
		Return
	EndIf

	;Bottom right
	PixelSearch(850, 620, 850, 620, 0x007E00)
	If Not @error Then
		MouseClickDrag("left", 450, 620, 840, 620)
		Return
	EndIf
EndFunc   ;==>BonusStageSlider

Func BonusStageFail()
	PixelSearch(810, 631, 810, 631, 0x723536)
	If Not @error Then
		MouseClick("left", 721, 577, 1, 0)
		Return True
	EndIf
	Return False
EndFunc   ;==>BonusStageFail

Func BonusStageNSP()
	;Section 1 start
	cSend(94, 1640) ;1
	cSend(32, 1218) ;2
	cSend(94, 1563) ;3
	cSend(109, 1828) ;4
	cSend(63, 640) ;5
	cSend(47, 688) ;6
	cSend(78, 1906) ;7
	cSend(141, 1625) ;8
	cSend(47, 3187) ;9
	cSend(47, 734) ;10
	cSend(47, 750) ;11
	cSend(78, 1203) ;12
	cSend(110, 5000) ;13
	If BonusStageFail() Then
		Return
	EndIf
	; Section 1 Collection
	cSend(46, 6047)
	cSend(47, 219)
	cSend(78, 1313)
	cSend(62, 2141)
	cSend(31, 1000)
	; Section 2 sync
	Do
		PixelSearch(700, 149, 700, 149, 0x7A444A)
	Until Not @error
	; Section 2 start
	cSend(156, 719) ;1
	cSend(47, 687) ;2
	cSend(360, 1390) ;3
	cSend(485, 344) ;4
	cSend(406, 859) ;5
	cSend(78, 1203) ;6
	cSend(94, 922) ;7
	cSend(109, 954) ;8
	cSend(31, 672) ;9
	cSend(515, 1344) ;10
	cSend(484, 297) ;11
	cSend(78, 1297) ;12
	cSend(156, 813) ;13
	cSend(172, 984) ;14
	cSend(31, 625) ;15
	cSend(610, 1890) ;16
	cSend(469, 219) ;17
	cSend(297, 1000) ;18
	cSend(156, 1531) ;19
	cSend(110, 1390) ;20
	cSend(360, 5984) ;21
	If BonusStageFail() Then
		Return
	EndIf
	; Section 2 Collection
	cSend(531, 2313)
	cSend(344, 1234)
	cSend(62, 454)
	cSend(62, 1125)
	cSend(47, 3047)
	cSend(62, 110)
	cSend(62, 9219)
	; Section 3 Start
	cSend(109, 1203) ;1
	cSend(31, 641) ;2
	cSend(47, 1578) ;3
	cSend(47, 2437) ;4
	cSend(110, 1297) ;5
	cSend(31, 656) ;6
	cSend(47, 1625) ;7
	cSend(31, 2313) ;8
	cSend(109, 1516) ;9
	cSend(47, 640) ;10
	cSend(47, 1547) ;11
	cSend(47, 1969) ;12
	cSend(93, 1203) ;13
	cSend(47, 625) ;14
	cSend(47, 5125) ;15
	If BonusStageFail() Then
		Return
	EndIf
	;Section 3 Collection
	cSend(891, 1406)
	cSend(94, 344)
	cSend(78, 359)
	cSend(78, 3453)
	cSend(63, 9062)
	;Section 4 Start
	cSend(32, 4578) ;1
	cSend(31, 859) ;2
	cSend(47, 1375) ;3
	cSend(47, 1406) ;4
	cSend(641, 703) ;5
	cSend(31, 1344) ;6
	cSend(47, 1484) ;7
	cSend(578, 766) ;8
	cSend(31, 1407) ;9
	cSend(31, 1437) ;10
	cSend(563, 719) ;11
	cSend(46, 1438) ;12
	cSend(47, 1422) ;13
	cSend(547, 750) ;14
	cSend(46, 1625) ;15
	cSend(94, 391) ;16
	cSend(281, 1391) ;17
	cSend(109, 2406) ;18
	cSend(63, 390) ;19
	cSend(63, 2672) ;20
	cSend(62, 485) ;21
	cSend(47)
	Sleep(4000)
	If BonusStageFail() Then
		Return
	EndIf
EndFunc   ;==>BonusStageNSP

Func cSend($pressDelay, $postPressDelay = 0, $key = "Up")
	ControlSend("Idle Slayer", "", "", "{" & $key & " Down}")
	Sleep($pressDelay)
	ControlSend("Idle Slayer", "", "", "{" & $key & " Up}")
	Sleep($postPressDelay)
EndFunc   ;==>cSend
