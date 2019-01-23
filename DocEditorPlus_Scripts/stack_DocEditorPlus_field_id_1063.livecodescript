Script "stack_DocEditorPlus_field_id_1063"

/*
# Name: field "fldModuleHandlers" of group "gpPreferences" of card "WidgetWizard" of stack "DocEditorPlus"
# ID: field id 1063 of group id 1023 of card id 1020 of stack "DocEditorPlus"
*/


on selectionChanged
   local tLines
   
   put the hilitedlines of field "fldImports" into tLines
   ImportPreferences.Change tLines
end selectionChanged
