Script "stack_DocEditorPlus_image_id_1094"

/*
# Name: image "gears.gif" of group "gpSnippets" of card "WidgetWizard" of stack "DocEditorPlus"
# ID: image id 1094 of group id 1026 of card id 1020 of stack "DocEditorPlus"
*/


on mouseUp
   local tSnippets
   
   --connect to the github repository if possible
   put empty into tSnippets
   put url (rootURL() & "snippetlist.txt") into tSnippets
   if tSnippets is not empty then
      -- remove empty lines
      filter tSnippets without empty
      sort tSnippets
      put tSnippets into field "fldSnippets"
   else
      --else say we can't connect
      answer "there was an error retrieving the snippet list"
   end if
end mouseUp
