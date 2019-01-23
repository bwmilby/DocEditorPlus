Script "stack_DocEditorPlus_button_id_1003"

/*
# Name: button "Tab Menu" of card "DocEditor" of stack "DocEditorPlus"
# ID: button id 1003 of card id 1002 of stack "DocEditorPlus"
*/


on menuPick pChosenItem, pPreviousTab
   lock screen
   set the visible of field "CodeText" to (pChosenItem is "LCB" or pChosenItem is "LCS")   
   set the visible of field "DocText" to (pChosenItem is "LCDOC")   
   set the visible of widget "DocTree" to (pChosenItem is "Array")
   set the visible of field "ItemText" to (pChosenItem is "Array")
   unlock screen
end menuPick
