Script "stack_DocEditorPlus_field_id_1057"

/*
# Name: field "fldImports" of group "gpPreferences" of card "WidgetWizard" of stack "DocEditorPlus"
# ID: field id 1057 of group id 1023 of card id 1020 of stack "DocEditorPlus"
*/


constant kHandlers="fldModuleHandlers"

on selectionChanged
   local tLines
   local tText
   local tScroll
   
   lock screen
   put the scroll of me into tScroll
   put the text of the clickline into tText
   put the hilitedlines of me into tLines
   ImportPreferences.Change tLines
   if word 2 of the clickline is among the items of tLines then
      put widgetAvailableHandlersOfModule(tText) into field kHandlers
      if field kHandlers is not empty then
         show field kHandlers
      end if
   else
      put empty into field kHandlers
      hide field kHandlers
   end if
   set the scroll of me to tScroll
   unlock screen
end selectionChanged
