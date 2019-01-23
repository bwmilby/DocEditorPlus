Script "stack_DocEditorPlus_field_id_1099"

/*
# Name: field "fldSnippet" of group "gpSnippets" of card "WidgetWizard" of stack "DocEditorPlus"
# ID: field id 1099 of group id 1026 of card id 1020 of stack "DocEditorPlus"
*/


on selectionChanged
   local tLines
   
   put the hilitedlines of me into tLines
   ImportPreferences.Change tLines
end selectionChanged
