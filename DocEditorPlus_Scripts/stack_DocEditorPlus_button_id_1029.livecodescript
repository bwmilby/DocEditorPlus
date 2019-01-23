Script "stack_DocEditorPlus_button_id_1029"

/*
# Name: button "btnVariables" of group "gpVariables" of card "WidgetWizard" of stack "DocEditorPlus"
# ID: button id 1029 of group id 1022 of card id 1020 of stack "DocEditorPlus"
*/


on menuPick pChosen, pPrev
   lock screen
   hideAll
   switch pChosen
      case "Variables"
         show field "fldVariables"
         show field "lblVariables"
         show field "lblVariableNames"
         show field "lblVariableTypes"
         break
      case "Properties"
         show field "fldProperties"
         show field "lblProperties"
         show field "lblPropertiesNames"
         show field "lblPropertiesGetters"
         show field "lblPropertiesSetters"
         break
      case "Metadata"
         show field "fldMetadata"
         show field "lblMetadata"
         show field "lblMetadataNames"
         show field "lblMetadataValues"
         break
      case "Types"
         show field "fldTypes"
         show field "lblTypes"
         show field "lblTypesNames"
         show field "lblTypesTypes"
         show field "lblTypesContents"
         break
      default
         break
   end switch
   unlock screen
end menuPick

private command hideAll
   lock screen
   hide field "fldVariables"
   hide field "lblVariables"
   hide field "lblVariableNames"
   hide field "lblVariableTypes"
   
   hide field "fldProperties"
   hide field "lblProperties"
   hide field "lblPropertiesNames"
   hide field "lblPropertiesGetters"
   hide field "lblPropertiesSetters"
   
   hide field "fldMetadata"
   hide field "lblMetadata"
   hide field "lblMetadataNames"
   hide field "lblMetadataValues"
   
   hide field "fldTypes"
   hide field "lblTypes"
   hide field "lblTypesNames"
   hide field "lblTypesTypes"
   hide field "lblTypesContents"
   unlock screen
end hideAll
