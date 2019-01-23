Script "stack_DocEditorPlus_button_id_1021"

/*
# Name: button "btnTabControl" of card "WidgetWizard" of stack "DocEditorPlus"
# ID: button id 1021 of card id 1020 of stack "DocEditorPlus"
*/


on menuPick pChosen, pPrev
   lock screen
   hideAllGroups
   switch pChosen
      case "Project"
         show group "gpProject"
         break
      case "Variables"
         show group "gpVariables"
         break
      case "Preferences"
         ImportPreferences.Set
         show group "gpPreferences"
         break
      case "Help"
      case "Hogwarts"
         show group "gpHelp"
         break
      case "Snippets"
         repeat for each line tURL in the cachedURLs
            unload URL tURL
         end repeat
         show group "gpSnippets"
         break
      default
         break
   end switch
   unlock screen
end menuPick

private command hideAllGroups
   constant kGroups="gpVariables,gpPreferences,gpProject,gpHelp,gpSnippets,gpTestSnippet"
   
   repeat for each item tGroup in kGroups
      hide group tGroup
   end repeat
end hideAllGroups
