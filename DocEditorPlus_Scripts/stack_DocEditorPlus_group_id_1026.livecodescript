Script "stack_DocEditorPlus_group_id_1026"

/*
# Name: group "gpSnippets" of card "WidgetWizard" of stack "DocEditorPlus"
# ID: group id 1026 of card id 1020 of stack "DocEditorPlus"
*/


 /**
* fldSnippets
* Mark Wieder and Ah, Software
*
* Snippet files have the following format. The requirements section is optional.

Requirements
Handler

The requirements section is a json object and may have the following elements:
variable
property
metadata
handler

The intention is that if there isn't already a declaration for the variable and property
they will be added to the list to be created.
Required handlers will then be recursed so that they will also be added.

Sample snippet file for an OnTimer handler:

{
"require":
{
"handlers": ["setUseTimer", "nextFullSecond"],
"variables": ["mUseTimer"],
"mUseTimer":
{
"is": "variable",
"type": "Boolean"
}
}
}

-- author: Bernd Niggeman
public handler OnTimer()
if mUseTimer then
    redraw all
    schedule timer in nextFullSecond() seconds
else
    cancel timer
end if
end handler
*/

local sSnippetArray

function SnippetArray
    return sSnippetArray
end SnippetArray

function snippetHandlers
    local tHandlers
    
    repeat for each key tSnippet in sSnippetArray
        put sSnippetArray[tSnippet]["handler"] & cr & cr after tHandlers
    end repeat
    return tHandlers
end snippetHandlers

command AddSnippet pSnippet
   local tSnippetText
   local tRequirements
   local tRequiredHandlers, tRequiredVariables, tRequiredProperties
   local tRequiredMetadata, tRequiredTypes
   local tRequirementsArray, tPropertyArray, tMetadataArray, tTypesArray
   
   -- split into requirements and content
   put snippetTextOf(pSnippet) into tSnippetText
   put handlerFor(tSnippetText) into sSnippetArray[pSnippet]["handler"]
   
   -- get the requirements json object
   put requirementsFor(tSnippetText) into tRequirements
   try
      if tRequirements is not empty then
         put JSONToArray(tRequirements) into tRequirementsArray
         put tRequirementsArray["require"] into sSnippetArray[pSnippet]["requirements"]
         -- now recurse the requirements section
         put tRequirementsArray["require"]["handlers"] into tRequiredHandlers
         
         --          put tRequirementsArray["require"]["variables"] into tRequiredVariables
         --          repeat for each element tVariable in tRequiredVariables
         --             AddVariable tVariable, tRequirementsArray["require"][tVariable]["type"]
         --          end repeat
         AddVariablesFrom tRequirementsArray
         
         --          put tRequirementsArray["require"]["properties"] into tRequiredProperties
         --          repeat for each element tProperty in tRequiredProperties
         --             put tRequirementsArray["require"][tProperty] into tPropertyArray
         --             AddProperty tProperty, tPropertyArray["get"], tPropertyArray["set"]
         --          end repeat
         AddPropertiesFrom tRequirementsArray
         
         --          put tRequirementsArray["require"]["metadata"] into tRequiredMetadata
         --          repeat for each element tMetadata in tRequiredMetadata
         --             put tRequirementsArray["require"][tMetadata] into tMetadataArray
         --             AddMetadata tMetadata, tMetadataArray["value"]
         --          end repeat
         AddMetadataFrom tRequirementsArray
         
         --          put tRequirementsArray["require"]["type"] into tRequiredTypes
         --          repeat for each element tType in tRequiredTypes
         --             put tRequirementsArray["require"][tType] into tTypesArray
         --             AddType tType, tTypesArray["type"], tTypesArray["value"]
         --          end repeat
         AddTypesFrom tRequirementsArray
         repeat for each element tHandler in tRequiredHandlers
            AddSnippet tHandler -- recursion
         end repeat
      end if
   catch e
      answer "can't parse the requirements json object"
      put e
   end try
end AddSnippet

command AddVariablesFrom pRequirementsArray
   local tRequiredVariables
   local tArray
   
   put pRequirementsArray["require"]["variables"] into tRequiredVariables
   repeat for each element tVariable in tRequiredVariables
      AddVariable tVariable, pRequirementsArray["require"][tVariable]["type"]
   end repeat
end AddVariablesFrom

constant kPropertiesField="fldProperties"
command AddProperty pName, pGetter, pSetter
   lock screen
   if pName & tab & pGetter & pSetter is not in field kPropertiesField then
      put pName & tab & pGetter & pSetter & cr after field kPropertiesField
   end if
   unlock screen
end AddProperty
 
command AddPropertiesFrom pRequirementsArray
   local tRequiredProperties
   local tArray
   
   put pRequirementsArray["require"]["metadata"] into tRequiredProperties
   repeat for each element tProperty in tRequiredProperties
      put pRequirementsArray["require"][tProperty] into tArray
      AddProperty tProperty, tArray["get"], tArray["set"]
   end repeat
end AddPropertiesFrom

command AddMetadataFrom pRequirementsArray
   local tRequiredMetadata
   local tArray
   
   put pRequirementsArray["require"]["metadata"] into tRequiredMetadata
   repeat for each element tMetadata in tRequiredMetadata
      put pRequirementsArray["require"][tMetadata] into tArray
      AddMetadata tMetadata, tArray["value"]
   end repeat
end AddMetadataFrom

command AddTypesFrom pRequirementsArray
   local tRequiredTypes
   local tArray
   
   put pRequirementsArray["require"]["type"] into tRequiredTypes
   repeat for each element tType in tRequiredTypes
      put pRequirementsArray["require"][tType] into tArray
      AddType tType, tArray["type"], tArray["value"]
   end repeat
end AddTypesFrom

command DeleteSnippet pSnippet
   delete variable sSnippetArray[pSnippet]
end DeleteSnippet

command TestSnippet
   local tTestArray
   local tSnippetText
   local tRequirements
   local tRequiredHandlers, tRequiredVariables, tRequiredProperties
   local tRequiredMetadata, tRequiredTypes
   local tRequirementsArray, tPropertyArray, tMetadataArray, tTypesArray
   
   replace "$AUTHOR" with field "fldAuthor" in field "fldDeleteMe"
   -- split into requirements and content
   put field "fldDeleteMe" into tSnippetText
   if tSnippetText is empty then
      throw "noContent"
   end if
   put handlerFor(tSnippetText) into tTestArray["handler"]
   
   -- get the requirements json object
   put requirementsFor(tSnippetText) into tRequirements
   try
      if tRequirements is not empty then
         put JSONToArray(tRequirements) into tRequirementsArray
         put tRequirementsArray["require"] into tTestArray["requirements"]
         -- now recurse the requirements section
         put tRequirementsArray["require"]["handlers"] into tRequiredHandlers
         
         put tRequirementsArray["require"]["variables"] into tRequiredVariables
         repeat for each element tVariable in tRequiredVariables
            AddVariable tVariable, tRequirementsArray["require"][tVariable]["type"]
         end repeat
         
         put tRequirementsArray["require"]["properties"] into tRequiredProperties
         repeat for each element tProperty in tRequiredProperties
            put tRequirementsArray["require"][tProperty] into tPropertyArray
            AddProperty tProperty, tPropertyArray["get"], tPropertyArray["set"]
         end repeat
         
         put tRequirementsArray["require"]["metadata"] into tRequiredMetadata
         repeat for each element tMetadata in tRequiredMetadata
            put tRequirementsArray["require"][tMetadata] into tMetadataArray
            AddMetadata tMetadata, tMetadataArray["value"]
         end repeat
         
         put tRequirementsArray["require"]["type"] into tRequiredTypes
         repeat for each element tType in tRequiredTypes
            put tRequirementsArray["require"][tType] into tTypesArray
            AddType tType, tTypesArray["type"], tTypesArray["value"]
         end repeat
         
         repeat for each element tHandler in tRequiredHandlers
            TestSnippet tHandler -- recursion
         end repeat
      end if
      answer "OK"
   catch e
      answer "can't parse the requirements json object"
   end try
end TestSnippet

/**
* recursion
*/
private function snippetHandlerFrom pHandler
    local tSnippetText
    
    -- get the snippet list from github
    put snippetTextOf(pHandler) into tSnippetText
    -- return the handler section of the snippet file
    return handlerFor(tSnippetText)
end snippetHandlerFrom

 /**
* get the snippet list from github
*/
function snippetTextOf pSelection
   local tSnippets
   local tSnippetText
   
   --connect to the github repository if possible
   put url (rootURL() & "snippets/" & pSelection & ".txt") into tSnippets
   -- use this for testing
   --put field "fldDeleteMe" into tSnippets
   if tSnippets is not empty then
      -- get the snippet list from github
      -- put the snippet list into the snippets field
      put tSnippets into tSnippetText
   else
      --else say we can't connect
      answer "there was an error retrieving the snippet list"
   end if
   return tSnippetText
end snippetTextOf

 /**
* return the requirements json object of the snippet file
*/
private function requirementsFor pSnippetText
   local tOffset
   local tRequirements
   
   put separator(pSnippetText) into tOffset
   if tOffset is not 0 then
      put line 1 to tOffset-1 of pSnippetText into tRequirements
   end if
   -- allow comments
   filter tRequirements without "--*"
   return tRequirements
end requirementsFor

 /**
* return the handler section of the snippet file
*/
private function handlerFor pSnippetText
   local tOffset
   
  put separator(pSnippetText) into tOffset
   return line tOffset to -1 of pSnippetText
end handlerFor

private function separator pSnippetText
   local tOffset
   
   put lineoffset("private handler ", pSnippetText) into tOffset
   if tOffset is 0 then
      put lineoffset("public handler ", pSnippetText) into tOffset
      if tOffset is 0 then
         put lineoffset("handler ", pSnippetText) into tOffset
      end if
   end if
   return tOffset
end separator
