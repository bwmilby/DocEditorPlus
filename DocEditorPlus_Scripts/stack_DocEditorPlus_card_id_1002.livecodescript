Script "stack_DocEditorPlus_card_id_1002"

/*
# Name: card "DocEditor" of stack "DocEditorPlus"
# ID: card id 1002 of stack "DocEditorPlus"
*/


local sDocHash

on openCard
   start using stack "revdocsparser"
   ClearData
   set the menuHistory of btn "Tab Menu" to 2
end openCard

on closecard
   ClearData
end closecard

on closeStackRequest
   saveCheck
   pass closeStackRequest
end closeStackRequest

--
-- Button commands
--

on openFile
   saveCheck
   answer file "Select a file to parse:"
   if the result is not "Cancel" then
      put it into field "FilePath"
      put empty into sDocHash
      loadFile
   else
      ShowHideButtons
   end if
end openFile

on loadFile
   saveCheck
   local tFile
   put the text of field "FilePath" into tFile
   if tFile is not empty then
      put empty into sDocHash
      ParseData revDocsUtf8FileContents(tFile)
      set the visible of field "Instructions" to false
   end if
   ShowHideButtons
end loadFile

on saveFile
   local tFile, tContents
   
   put the text of field TextFieldName() into tContents
   if tContents is empty then
      answer "Something went wrong.  There is nothing so save."
      exit to top
   end if
   
   put the text of field "FilePath" into tFile
   answer "Overwrite" && tFile & "?" with "Yes" or "No"
   if it is "Yes" then
      revIDESetUTF8FileContents tFile, tContents
      put messageDigest(tContents, "MD5") into sDocHash
   end if
end saveFile

on processFile
   if the text of field "CodeText" is not empty then
      ParseData the text of field "CodeText"
   else
      ParseData the text of field "DocText"
   end if
end processFile

on previewFile
   send "mouseUp" to button "Preview"
end previewFile

on goWidgetWizard
   saveCheck
   go card "WidgetWizard"
end goWidgetWizard

on viewInfo
   set the visible of field "Instructions" of me to not the visible of field "Instructions" of me
end viewInfo

--
--
--

command saveCheck
   if fileHasChanged() then
      answer "Unsaved changes will be lost if you continue.  Save changes?" \
            with "Yes" or "No" or "Cancel"
   end if
   if it is "Cancel" then exit to top
   if it is "Yes" then
      local tContents
      put the text of field TextFieldName() into tContents
      revIDESetUTF8FileContents the text of field "FilePath", tContents
      put messageDigest(tContents, "MD5") into sDocHash
   end if
end saveCheck

command ClearData
   lock screen
   set the text of field "FilePath" of me to empty
   set the arrayData of widget "DocTree" of me to empty
   set the text of field "ItemText" of me to empty
   set the text of field "CodeText" of me to empty
   set the text of field "DocText" of me to empty
   set the text of button "Tab Menu" to "LCB" & cr & "LCDOC" & cr & "Array"
   put empty into sDocHash
   ShowHideButtons
   unlock screen
end ClearData

function fileIsLCDOC
   return matchText(the text of field "FilePath", ".*(\.lcdoc)+")
end fileIsLCDOC

function fileIsLCB
   return matchText(the text of field "FilePath", ".*(\.(mlc|lcb))+")
end fileIsLCB

function fileIsLCS
   return matchText(the text of field "FilePath", ".*(\.livecodescript)+")
end fileIsLCS

command ParseData pContents
   local tFile, tIsLCB, tIsLCS, tIsLCDOC, tParsedA
   
   lock screen
   
   -- use the file name to determine type of file
   put the text of field "FilePath" into tFile
   put matchText(tFile, ".*(\.lcdoc)+") into tIsLCDOC
   put matchText(tFile, ".*(\.(mlc|lcb))+") into tIsLCB
   put matchText(tFile, ".*(\.livecodescript)+") into tIsLCS
   if not (tIsLCDOC or tIsLCB or tIsLCS) then
      answer "File name does not contain the correct extension (.lcdoc/.lcb/.livecodescript)"
      exit to top
   end if
   if sDocHash is empty then
      put messageDigest(pContents, "MD5") into sDocHash
   end if
   if tIsLCB and pContents is not empty then
      put pContents into field "CodeText"
      put revDocsGenerateDocsFileFromModular(pContents, tFile) into pContents
      set the text of button "Tab Menu" to "LCB" & cr & "LCDOC" & cr & "Array"
      set the menuHistory of btn "Tab Menu" to 3
   else if tIsLCS and pContents is not empty then
      put pContents into field "CodeText"
      put the long id of stack (tFile) into tFile
      put revDocsGenerateDocsFileFromText(pContents, tFile) into pContents
      set the text of button "Tab Menu" to "LCS" & cr & "LCDOC" & cr & "Array"
      set the menuHistory of btn "Tab Menu" to 3
   else
      put empty into field "CodeText"
      set the text of button "Tab Menu" to "LCDOC" & cr & "Array"
      set the menuHistory of btn "Tab Menu" to 2
   end if
   put pContents into field "DocText"
   
   if pContents is not empty then
      put revDocsParseDocText(pContents, tFile) into tParsedA
   else
      answer "The file did not contain valid dictionary data."
      exit to top
   end if
   
   set the arrayData of widget "DocTree" to tParsedA
   put empty into field "itemText"
   
   dispatch "validateEntries" to field "DocText"
   
   try
      set the hilitedElement of widget "DocTree" to "errors"
   end try
   
   unlock screen
end ParseData

function TextFieldName
   local tFile, tField 
   put the text of field "FilePath" into tFile
   if matchText(tFile, ".*(\.lcdoc)+") then
      put "DocText" into tField
   else
      put "CodeText" into tField
   end if
   return tField
end TextFieldName

command ShowHideButtons
   local tFile, tButtonList
   put the text of field "FilePath" into tFile
   lock screen
   if tFile is not empty and there is a file tFile then
      put "LoadFile,SaveFile" into tButtonList
      if field TextFieldName() is not empty then
         put ",ProcessFile,PreviewFile" after tButtonList
      end if
      repeat for each item tItem in tButtonList
         enable widget ("btn" & tItem)
         enable field ("lbl" & tItem)
      end repeat
      if fileIsLCB() then
         put "Package,Uninstall,Install,Test,StopTesting" into tButtonList
         repeat for each item tItem in tButtonList
            set the visible of widget ("btn" & tItem) to true
            set the visible of field ("lbl" & tItem) to true
         end repeat
      end if
   else
      put "LoadFile,SaveFile,ProcessFile,PreviewFile" into tButtonList
      repeat for each item tItem in tButtonList
         disable widget ("btn" & tItem)
         disable field ("lbl" & tItem)
      end repeat
      put "Package,Uninstall,Install,Test,StopTesting" into tButtonList
      repeat for each item tItem in tButtonList
         set the visible of widget ("btn" & tItem) to false
         set the visible of field ("lbl" & tItem) to false
      end repeat
   end if
   unlock screen
end ShowHideButtons

function fileHasChanged
   if sDocHash is empty then return false
   local tDocHash
   put messageDigest(the text of field TextFieldName(), "MD5") into tDocHash
   if tDocHash is sDocHash then return false
   else return true
end fileHasChanged
