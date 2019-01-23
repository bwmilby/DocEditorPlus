Script "stack_DocEditorPlus_widget_id_1008"

/*
# Name: widget "DocTree" of card "DocEditor" of stack "DocEditorPlus"
# ID: widget id 1008 of card id 1002 of stack "DocEditorPlus"
# Widget Kind: com.livecode.widget.treeview
*/


-- Sent when an element is hilited
-- Use the hilitedElement property to get a comma-delimited list of
-- keys in the underlying array
on hiliteChanged
   local tElement, tArray, tIndex, tReference
   put the arrayData of widget "DocTree" into tArray
   put the hilitedElement of the target into tElement
   put 0 into tIndex
   repeat for each item tItem in tElement
      add 1 to tIndex
      put tItem into tReference[tIndex]
   end repeat
   if item 1 of tElement is "errors" then
      set the htmltext of field "ItemText" to tArray[tReference]
   else
      set the text of field "ItemText" to tArray[tReference]
   end if
end hiliteChanged
