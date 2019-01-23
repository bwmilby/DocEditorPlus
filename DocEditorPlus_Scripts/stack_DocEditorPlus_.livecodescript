Script "stack_DocEditorPlus_"

/*
# Name: stack "DocEditorPlus"
# ID: stack "DocEditorPlus"
*/


--
-- Extension builder additions
--

function loadedExtensionPath
   local tFile
   put the text of field "FilePath" of card "DocEditor" into tFile
   if tFile is not empty then
      set the itemdelimiter to "/"
      return item 1 to -2 of tFile
   end if
end loadedExtensionPath

--
-- Behavior code for menu buttons
--

on mouseDown pButtonNumber
   local tTarget, tButton
   put the name of the target into tTarget
   put char 5 to -2 of word 2 of tTarget into tButton
   if (tTarget begins with "widget" && quote & "btn") or \
         (tTarget begins with "field" && quote & "lbl") then
      try
         set the highlight of widget ("btn" & tButton) to true
      end try
   end if
end mouseDown

on mouseUp pButtonNumber
   local tTarget, tButton
   put the name of the target into tTarget
   put char 5 to -2 of word 2 of tTarget into tButton
   if (tTarget begins with "widget" && quote & "btn") or \
         (tTarget begins with "field" && quote & "lbl") then
      try
         set the highlight of widget ("btn" & tButton) to false
      end try
      switch tButton
         case "OpenFile"
         case "Loadfile"
         case "SaveFile"
         case "ProcessFile"
         case "PreviewFile"
         case "ViewInfo"
            send tButton to card "DocEditor" in 1 ticks
            break
         case "Package"
            revIDEDeveloperExtensionBuildPackage loadedExtensionPath()
            break
         case "Uninstall"
            revIDEDeveloperExtensionUninstall loadedExtensionPath()
            break
         case "Install"
            revIDEDeveloperExtensionInstall loadedExtensionPath()
            break
         case "StopTesting"
            revIDEDeveloperExtensionStopTesting
            break
         case "Test"
            revIDEDeveloperExtensionTest loadedExtensionPath()
            break
         case "WidgetWizard"
            send "goWidgetWizard" to card "DocEditor" in 1 ticks
            break
      end switch
   end if
end mouseUp
