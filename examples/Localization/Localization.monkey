Strict

#rem
	Script:			Localization.monkey
	Description:	Sample script that shows how to use the ftLocalization class
	Author: 		Michael Hartlef
	Version:      	2.0
#End

' Set the AutoSuspend functionality to TRUE so OnResume/OnSuspend are called
#MOJO_AUTO_SUSPEND_ENABLED=True

'Set to false to disable webaudio support for mojo audio, and to use older multimedia audio system instead.
#HTML5_WEBAUDIO_ENABLED=True

' Import the fantomX framework which imports mojo2 itself
Import fantomX

' The _g variable holds an instance to the cGame class
Global _g:cGame

'***************************************
' The cGame class controls the app
Class cGame Extends App
	' Create a field to store the instance of the cEngine class, which is an instance
	' of the ftEngine class itself
	Field fE:cEngine
	
	' Create a field for the instance of the localization class
	Field cTrans:ftLocalization
	
	'------------------------------------------
	Method OnCreate:Int()
		' Create an instance of the fantomX, which was created via the cEngine class
		fE = New cEngine
		
		' Create an instance of the localization class
		cTrans = New ftLocalization
		
		' Load the text file with the translationslocalization class from a string
		Local locStr:String  = LoadString("translation.txt")

		' Load localization class from a string
		' Local locStr:String  = "Play;DE:Spielen~nOptions;DE:Optionen"
		cTrans.LoadFromString(locStr)
		
		' Load a font to create some text
		Local font1 := fE.LoadFont("font")
		
		' Now create two text objects with the translated text
		fE.CreateText(font1, "Play means " + cTrans.GetString("Play","DE") + " in german.", 5, 20)
		fE.CreateText(font1, "Play means " + cTrans.GetString("Play","JP") + " in japanese.", 5, 60)
		fE.CreateText(font1, "Options means " + cTrans.GetString("Options","DE") + " in german.", 5, 100)
		
		fE.CreateText(font1, cTrans.GetString("MultiLine","DE"), 5, 200)
		
		Return 0
	End
	'------------------------------------------
	Method OnUpdate:Int()
		' If the CLOSE key was hit, exit the app ... needed for GLFW and Android I think. 
		If KeyHit( KEY_CLOSE ) Then fE.ExitApp()
		
		' Determine the delta time and the update factor for the engine
		Local timeDelta:Float = Float(fE.CalcDeltaTime())/60.0

		' Update all objects of the engine
		If fE.GetPaused() = False Then
			fE.Update(timeDelta)
		Endif
		Return 0
	End
	'------------------------------------------
	Method OnRender:Int()
		' Check if the engine is not paused
		If fE.GetPaused() = False Then
			' Clear the screen 
			fE.Clear( 0,0,0)
		
			' Render all visible objects of the engine
			fE.Render()
			
			' Now draw the current FPS value to the screen
			fE.SetColor(255, 255, 0)
			fE.GetCanvas().DrawText( "FPS= "+fE.GetFPS(),fE.GetLocalX(10), fE.GetLocalY(10))

			' Last, flip the previously drawn content to the screen, make it visible
			fE.RenderFlush()			
		Endif
		Return 0
	End
	'------------------------------------------
	Method OnLoading:Int()
		' If loading of assets in OnCreate takes longer, render a simple loading screen
		fE.RenderLoadingBar()
		
		Return 0
	End
	'------------------------------------------
	Method OnResume:Int()
		' Set the pause flag of the engine to FALSE so objects, timers and transitions are updated again
		fE.SetPaused(False)
		
		Return 0
	End
	'------------------------------------------
	Method OnSuspend:Int()
		' Set the pause flag of the engine to TRUE so objects, timers and transitions are paused (not updated)
		fE.SetPaused(True)
		
		Return 0
	End
End	

'***************************************
' The cEngine class extends the ftEngine class to override the On... methods
Class cEngine Extends ftEngine
	' No On.. callback methods are used in this example
End

'***************************************
Function Main:Int()
	' Create an instance of the cGame class and store it inside the global var '_g'
	_g = New cGame
	
	Return 0
End
