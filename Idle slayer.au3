#comments-start
 AutoIt Version: 3.3.16.0
 Author:         Devil4ngle
#comments-end

#include <AutoItConstants.au3>

; Disable Caps for better background
Opt("SendCapslockMode", 0)
; Set window Mode for PixelSearch
Opt("PixelCoordMode", 0)
; Set window Mode for MouseClick
Opt("MouseCoordMode", 0)

HotKeySet("{F6}", "StartScript")
HotKeySet("{F4}", "StopScript")

Global $run = 1
Global $buyUpgrades = False

; Infinite Loop
While $run
	;Jump and shoot
	ControlFocus("Idle Slayer", "", "")
	ControlSend("Idle Slayer", "", "", "{Up}{Right}")
	Sleep(150)

	; Rage
	PixelSearch(1103, 115, 1103, 115, 0x990306)
	If Not @error Then
		Sleep(2000)
		MouseClick("left", 1104, 112, 1, 0)
		Sleep(300)
		$buyUpgrades = True
	EndIf

	; Upgrades
	If $buyUpgrades Then
		MouseClick("left", 1171, 683, 1, 0)

		; Check if bag is open
		PixelSearch(1222, 657, 1222, 657, 0xA61010, 10)
		If Not @error Then
			Sleep(300)
			BuyEquipment()
			$buyUpgrades = False
		EndIf
	EndIf

	; Silver box collect
	PixelSearch(650, 36, 650, 36, 0xFFC000)
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

Func BuyEquipment()
	; Navigate to Equipment pick Max and scroll up
	MouseClick("left", 859, 686, 1, 0)
	Sleep(300)
	MouseClick("left", 1187, 612, 1, 0)
	Sleep(300)
	MouseWheel($MOUSE_WHEEL_UP, 50)
	Sleep(300)
	
	; Check for buyable equipment
	$loopCount = 1
	While $loopCount < 5 And $run
		$location = PixelSearch(1160, 170, 1160, 590, 0x11AA23)
		If @error Then
			MouseWheel($MOUSE_WHEEL_DOWN, 10)
			$loopCount += 1
			Sleep(300)
		EndIf

		If IsArray($location) = 1 Then
			MouseClick("left", $location[0], $location[1], 1, 0)
			Sleep(300)
		EndIf
	WEnd

	MouseWheel($MOUSE_WHEEL_UP, 50)
	Sleep(300)
	BuyUpgrades()
EndFunc

Func BuyUpgrades()
	; Navigate to upgrade and scroll up
	MouseClick("left", 927, 683, 1, 0)
	Sleep(300)
	MouseWheel($MOUSE_WHEEL_UP, 50)
	Sleep(300)

	$runWhile = 1
	$somethingBought = False

	While $runWhile And $run
		$RB_Magnet_Found = False
		$SRB_Magnet_Found = False

		; Check if RandomBox Magnet is next upgrade
		PixelSearch(882, 195, 909, 223, 0xF4B41B)
		If Not @error Then
			$RB_Magnet_Found = True
		EndIf

		; Check if Specifal RandomBox Magnet is next upgrade
		PixelSearch(879, 288, 913, 322, 0xE478FF)
		If Not @error Then
			$SRB_Magnet_Found = True
		EndIf

		; Click upgrade depending if Magnets are buyable
		If $RB_Magnet_Found Then
			If $SRB_Magnet_Found Then
				PixelSearch(1150, 369, 1238, 439, 0x11AA23, 10)
				If @error Then
					$runWhile = 0
					ContinueLoop
				EndIf

				MouseClick("left", 1185, 395, 1, 0)
				$somethingBought = True
				Sleep(300)
			Else
				PixelSearch(1150, 275, 1238, 340, 0x11AA23, 10)
				If @error Then
					$runWhile = 0
					ContinueLoop
				EndIf

				MouseClick("left", 1185, 297, 1, 0)
				$somethingBought = True
				Sleep(300)
			EndIf
		Else
			PixelSearch(1150, 178, 1238, 239, 0x11AA23, 10)
			If @error Then
				$runWhile = 0
				ContinueLoop
			EndIf

			MouseClick("left", 1185, 202, 1, 0)
			$somethingBought = True
			Sleep(300)
		EndIf
	Wend

	If $somethingBought Then
		BuyEquipment()
	Else
		MouseClick("left", 1222, 677, 1, 0)
		Sleep(300)
		MouseMove(623, 353)
	EndIf
EndFunc

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
		PixelSearch(780, 536, 780, 536, 0xBB26DF)
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

	cSend(406, 859) ;12
	cSend(78, 1203) ;13
	cSend(94, 922) ;14
	cSend(109, 954) ;15
	cSend(31, 672) ;16
	cSend(515, 1344) ;17
	cSend(469, 219) ;18
	cSend(297, 1000) ;19
	cSend(156, 1531) ;20
	cSend(110, 3000) ;21
	cSend(360, 2984) ;22
	cSend(531, 2313) ;23
	If BonusStageFail() Then
		Return
	EndIf
	; Section 2 Collection
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
	cSend(63, 8862)
	;Section 4 Start
	cSend(32, 4578) ;1
	cSend(31, 809) ;2
	cSend(41, 1375) ;3
	cSend(41, 1375) ;4
	cSend(641, 690) ;5
	cSend(41, 1375) ;6
	cSend(41, 1375) ;7
	cSend(641, 690) ;8
	cSend(41, 1375) ;9
	cSend(41, 1375) ;10
	cSend(641, 690) ;11
	cSend(41, 1375) ;12
	cSend(41, 1375) ;13
	cSend(641, 690) ;14
	cSend(41, 1375) ;15
	;Section 4 Collection
	cSend(120, 391) ;16
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
	Send("{" & $key & " Down}")
	Sleep($pressDelay)
	Send("{" & $key & " Up}")
	Sleep($postPressDelay)
	Return
EndFunc   ;==>cSend

Func StopScript()
	$run = 0
EndFunc

Func StartScript()
	$run = 1
EndFunc
