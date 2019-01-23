Script "stack_DocEditorPlus_button_id_1106"

/*
# Name: button "btnTest" of group "gpTestSnippet" of card "WidgetWizard" of stack "DocEditorPlus"
# ID: button id 1106 of group id 1027 of card id 1020 of stack "DocEditorPlus"
*/


on mouseUp
   try
      dispatch "TestSnippet" to group "gpSnippets"
   catch e
      switch e
         case "noContent"
            put e & cr after msg
            break
      end switch
   end try
end mouseUp


