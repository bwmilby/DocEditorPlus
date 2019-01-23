Script "stack_DocEditorPlus_button_id_1080"

/*
# Name: button "btnCreate" of group "gpProject" of card "WidgetWizard" of stack "DocEditorPlus"
# ID: button id 1080 of group id 1024 of card id 1020 of stack "DocEditorPlus"
*/


constant kVariablesField="fldVariables"
constant kPropertiesField="fldProperties"
constant kMetadataField="fldMetadata"
constant kTypesField="fldTypes"

on mouseUp
   local tContents
   local tVariableArray, tPropertyArray, tMetadataArray, tTypesArray
   local tFolder
   
   initialize
   put variableList() into tVariableArray
   put propertyList() into tPropertyArray
   put metadataList() into tMetadataArray
   put typesList() into tTypesArray
   put createFolder() into tFolder
   if tFolder is not empty then
      put initialImports() after tContents
      put initialMetadata() after tContents
      put defaultBody(tVariableArray, tPropertyArray, tMetadataArray, tTypesArray) after tContents
      createWidgetFileInFolder tContents
   end if
end mouseUp

private function propertyList
   local tPropertyArray
   
   -- NOTE: a leading "m" will get added to the variable names
   -- when they're assigned in the defaultBody function
   set the itemdelimiter to tab
   repeat for each line tProperty in field kPropertiesField
      put item 2 of tProperty into tPropertyArray[item 1 of tProperty]["getter"]
      put item 3 of tProperty into tPropertyArray[item 1 of tProperty]["setter"]
      put item 1 of tProperty into tPropertyArray[item 1 of tProperty]["label"]
      put "com.livecode.pi" into tPropertyArray[item 1 of tProperty]["editor"]
      put "" into tPropertyArray[item 1 of tProperty]["default"]
   end repeat
   return tPropertyArray
end propertyList

function variableList
    local tVariableArray
    
    -- NOTE: a leading "m" will get added to the variable names
    -- when they're assigned in the defaultBody function
    set the itemdelimiter to tab
    repeat for each line tVariable in field kVariablesField
        put item 2 of tVariable into tVariableArray[item 1 of tVariable]["type"]
    end repeat
    -- mMouseIsDown is required by the mouse functions
    put "Boolean" into tVariableArray["mMouseIsDown"]["type"]
    return tVariableArray
end variableList

/**
* Get metadata from the metadata field,
* return it in an array for further processing
*/
function metadataList
   local tMetadataArray
   
   set the itemdelimiter to tab
   repeat for each line tMetadataName in field kMetadataField
      put item 2 of tMetadataName into tMetadataArray[item 1 of tMetadataName]["value"]
   end repeat
   return tMetadataArray
end metadataList

function typesList
   local tTypesArray
   
   set the itemdelimiter to tab
   repeat for each line tTypeName in field kTypesField
      put item 2 of tTypeName into tTypesArray[item 1 of tTypeName]["value"]
   end repeat
   return tTypesArray
end typesList
