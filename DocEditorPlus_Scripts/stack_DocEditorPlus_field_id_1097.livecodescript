Script "stack_DocEditorPlus_field_id_1097"

/*
# Name: field "fldSnippets" of group "gpSnippets" of card "WidgetWizard" of stack "DocEditorPlus"
# ID: field id 1097 of group id 1026 of card id 1020 of stack "DocEditorPlus"
*/


on selectionChanged
   local tLineNumber
   local tSnippet
   local tScroll
   
   hide field "fldSnippet"
   lock screen
   put the scroll of me into tScroll
   put word 2 of the clickline into tLineNumber
   if tLineNumber is among the items of the hilitedlines of me then
      put the text of the clickline into tSnippet
      AddSnippet tSnippet
      put snippetTextOf(tSnippet) into field "fldSnippet"
      show field "fldSnippet"
   else
      DeleteSnippet tSnippet
   end if
   set the scroll of me to tScroll
   unlock screen
end selectionChanged
