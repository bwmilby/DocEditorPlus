Script "stack_DocEditorPlus_card_id_1020"

/*
# Name: card "WidgetWizard" of stack "DocEditorPlus"
# ID: card id 1020 of stack "DocEditorPlus"
*/


/**
stack: Widget Wizard
license: public domain
author: Mark Wieder and Ah, Software
*/

local sIdentifier="YourNameHere"
local sMetadataVersion="1.0.0"
local sMetadataAuthor="Your name Here"
local sMetadataEmail="your@name.here"
local sMetadataWidgetTitle="My Widget"
local sMetadataWidgetName="MyWidget"
local sDescription
local sMetadataWidgetType="widget"

local sWidgetFolder

constant kRootURL="https://raw.githubusercontent.com/mwieder/LiveCodeBuilder-snippets/master/"

constant kModulesField="fldImports"
constant kVariablesField="fldVariables"
constant kPropertiesField="fldProperties"
constant kMetadataField="fldMetadata"
constant kTypesField="fldTypes"

-- this is the Android Native Button svg data
constant kDefaultSvgIcon="M25.34,0H2.1A2.1,2.1,0,0,0,0,2.1V13.19a2.1,2.1,0,0,0,2.1,2.1H25.34a2.1,2.1,0,0,0,2.1-2.1V2.1A2.1,2.1,0,0,0,25.34,0Zm-15,9.49a.76.76,0,0,1-1.51.15.85.85,0,0,1,0-.15q0-1.58,0-3.16a.76.76,0,0,1,1.51-.12.91.91,0,0,1,0,.13q0,.78,0,1.57T10.35,9.49Zm7.08,1.11a.8.8,0,0,1-.4.71.78.78,0,0,1-.42.12h-.49c-.05,0-.05,0-.05.05,0,.54,0,1.08,0,1.62a.76.76,0,0,1-1.51.13.75.75,0,0,1,0-.14q0-.81,0-1.62s0,0,0,0h-.94s0,0,0,0c0,.55,0,1.09,0,1.64a.76.76,0,0,1-1.51.12.76.76,0,0,1,0-.14q0-.81,0-1.62s0,0,0,0h-.5a.82.82,0,0,1-.81-.64.8.8,0,0,1,0-.18q0-2.44,0-4.88s0,0,0,0h6.71s0,0,0,0Q17.43,8.17,17.43,10.6Zm0-5.18H10.68s0,0,0,0a2.93,2.93,0,0,1,.14-.86,3,3,0,0,1,.49-.92,3.27,3.27,0,0,1,.89-.79l.18-.1s0,0,0,0l-.51-.92a.11.11,0,0,1,0-.16.11.11,0,0,1,.16,0l.17.3.35.64s0,0,.06,0a3.5,3.5,0,0,1,.93-.26,3.67,3.67,0,0,1,1.89.24h0c.07,0,.07,0,.1,0l.5-.9a.11.11,0,0,1,.12-.07.11.11,0,0,1,.09.08.12.12,0,0,1,0,.09l-.51.91s0,0,0,.07a3.23,3.23,0,0,1,1.35,1.34,2.91,2.91,0,0,1,.33,1.08c0,.09,0,.17,0,.26S17.43,5.42,17.41,5.42Zm1.82,2.49q0,.79,0,1.59a.76.76,0,0,1-1.51.11.85.85,0,0,1,0-.12q0-1.58,0-3.15a.76.76,0,0,1,1.51-.15.88.88,0,0,1,0,.16Q19.24,7.12,19.24,7.91Zm-3.35-4a.28.28,0,1,1-.28-.28A.29.29,0,0,1,15.89,3.89Zm-3.14,0a.28.28,0,1,1-.28-.28A.28.28,0,0,1,12.75,3.89Z"
constant kRequiredImports="canvas,engine,widget,library.widgetutils"

command initialize
   initialize.Metadata.Project field "fldProject"
   initialize.Metadata.Version field "fldVersion"
   initialize.Metadata.Author field "fldAuthor"
   --initialize.Metadata.Email field "fldAuthorEmail"
   
   -- create company identifier from company name
   -- by removing whitespace and punctuation and lowercasing
   put initialize.Metadata.Company(field "fldCompany") into sIdentifier
   
   --put initialize.Metadata.LicenseType(the hilitedButton of group "gpLicense") into sCommunity
   put initialize.Metadata.WidgetType(the hilitedButton of group "gpWidgetType") into sMetadataWidgetType
   
   initialize.Metadata.Title field "fldTitle"
   initialize.Metadata.Description field "fldDescription"
   put empty into field "fldModuleHandlers"
   Modules.SetDefaults
end initialize

private command initialize.Metadata.Project pText
   if pText is not empty then
      put pText into sMetadataWidgetName
   end if
end initialize.Metadata.Project

private command initialize.Metadata.Version pText
   if pText is not empty then
      put pText into sMetadataVersion
   end if
end initialize.Metadata.Version

private command initialize.Metadata.Author pText
   if pText is not empty then
      put pText into sMetadataAuthor
   end if
end initialize.Metadata.Author

private command initialize.Metadata.Title pText
   if pText is not empty then
      put pText into sMetadataWidgetTitle
   end if
end initialize.Metadata.Title

private command initialize.Metadata.Description pText
   if pText is not empty then
      put pText into sDescription
   end if
end initialize.Metadata.Description

private function initialize.Metadata.Company pText
   local tCompany
   
   -- create company identifier from company name
   -- by removing whitespace and punctuation and lowercasing
   if pText is not empty then
      put replacetext(pText, "[^A-Za-z0-9_]", "") into tCompany
      if char 1 of tCompany is a number then
         put "_" before tCompany
      end if
   end if
   return tCompany
end initialize.Metadata.Company

private function initialize.Metadata.LicenseType pLicenseGroup
   local tLicenseType
   
   switch pLicenseGroup
      case 1
         put "community" into tLicenseType
         break
      case 2
         put "org" into tLicenseType
         break
      case 3
         put "com" into tLicenseType
         break
   end switch
   
   return tLicenseType
end initialize.Metadata.LicenseType
   
private function initialize.Metadata.WidgetType pWidgetTypeGroup
   local tWidgetType
   
   switch pWidgetTypeGroup
      case 1
         put "widget" into tWidgetType
         break
      case 2
         put "library" into tWidgetType
         break
      case 3
         put "module" into tWidgetType
         break
   end switch
   return tWidgetType
end initialize.Metadata.WidgetType

function createFolder
   local tSavedDefaultFolder
   
   put the defaultfolder into tSavedDefaultFolder
   answer folder "where do you want to place the folder?"
   if it is not empty then
      put it into sWidgetFolder
      set the defaultfolder to it
      if there is no folder sMetadataWidgetName then
         create folder sMetadataWidgetName
      end if
   end if
   set the defaultfolder to tSavedDefaultFolder
   return sWidgetFolder
end createFolder

command createWidgetFileInFolder pContents
   local tFile
   local tSavedDefaultFolder
   local tType
   
   put the defaultfolder into tSavedDefaultFolder
   set the defaultfolder to sWidgetFolder & "/" & sMetadataWidgetName
   put widgetOrLibrary?() into tType
   put "/* copyright" && word -1 of the long date && field "fldCompany" && "*/" & cr after tFile
   put "/**" & cr after tFile
   put field "fldDocumentation" & cr after tFile
   put "*/" & cr & cr after tFile
   if sMetadataWidgetName is empty then
      put "MyWidget" into sMetadataWidgetName
   end if
   put lower(sMetadataWidgetType && "community.livecode" & "." & sIdentifier & "." & sMetadataWidgetName) & cr & cr after tFile
   put pContents & cr after tFile
   put defaultHandlers() & cr after tFile
   put dragHandlers() & cr after tFile
   put "end" && tType & cr after tFile
   put tFile into url ("file:" & sMetadataWidgetName & ".lcb")
   set the defaultfolder to tSavedDefaultFolder
end createWidgetFileInFolder
 
private function widgetOrLibrary?
   local tType
   
   put "widget" into tType
   if the hilite of button "btnTypeLibrary" then
      put "library" into tType
   end if
   return tType
end widgetOrLibrary?

function initialMetadata
   local tMetadata
   
   if sMetadataWidgetTitle is empty then
      put "My Widget" into sMetadataWidgetTitle
   end if
   put "metadata title is" && q(sMetadataWidgetTitle) & cr into tMetadata
   --put "metadata type is" && q(sMetadataWidgetType) & cr after tMetadata
   if sMetadataAuthor is empty then
      put "My Name" into sMetadataAuthor
   end if
   put "metadata author is" && q(sMetadataAuthor) & cr after tMetadata
   put "metadata version is" && q(sMetadataVersion) & cr after tMetadata
   put "metadata preferredSize is" && q("128,128") & cr after tMetadata
   if sDescription is not empty then
      put "metadata description is" && q(sDescription) & cr after tMetadata
   end if
   put "metadata creator is" && q("Widget Wizard") & cr after tMetadata
   put "metadata svgicon is" && q(kDefaultSvgIcon) & cr after tMetaData
   --put "metadata uservisible is true" & cr after tMetadata
   return tMetadata & cr
end initialMetadata

private function IsModule?
    return sMetadataWidgetType is "module"
end IsModule?

private function IsWidget?
    return sMetadataWidgetType is "widget"
end IsWidget?

private function IsLibrary?
    return sMetadataWidgetType is "library"
end IsLibrary?

--> modules

 /**
* find the extension interfaces folder
*/
private function modulesLocation
    return specialfolderpath("engine") & "/Toolchain/modules/lci/"
end modulesLocation

 /**
* return the list of modules from the interface folder
*/
private function modulesList
    local tDefaultFolder
    local tFiles
    
    put the defaultfolder into tDefaultFolder
    set the defaultfolder to modulesLocation()
    put the files into tFiles
    set the defaultfolder to tDefaultFolder
    return tFiles
end modulesList

 /**
* given a module name
* return a list of its public handlers
*/
function widgetAvailableHandlersOfModule pModule
    local tFile
    local tContents
    
    put modulesLocation() & "com.livecode." & pModule & ".lci" into tFile
    put url ("file:" & tFile) into tContents
    filter tContents with "*handler*"
    return tContents
end widgetAvailableHandlersOfModule

 /**
* return the list of modules needed by this widget
* required modules are canvas, engine, widget
* others are defined by custom properties
*/
function initialImports
    local tImports
    local tProperty
    
    put Modules.Defaults() after tImports
    if not IsModule?() then
        repeat for each line tImport in field kModulesField
            if tImport is not among the items of kRequiredImports then
                put "uNeed" & tImport into tProperty
                if the tProperty of me then
                    put "use" && "com.livecode." & tImport & cr after tImports
                end if
            end if
        end repeat
    end if
    return tImports & cr
end initialImports

private function Modules.Defaults
    local tModules
    
    repeat for each item tModule in kRequiredImports
        put "use" && "com.livecode." & tModule & cr after tModules
    end repeat
    return tModules
end Modules.Defaults

command Modules.SetDefaults
   local tModules
   local tLineNumbers
   
   lock screen
   ModulePreferences.Clear
   put Modules.Defaults() after tModules
   repeat for each item tModule in kRequiredImports
      put lineoffset(tModule, field kModulesField) & comma after tLineNumbers
      ModulePreference.Set tModule, true
   end repeat
   set the hilitedlines of field kModulesField to tLineNumbers
   unlock screen
end Modules.SetDefaults

--> variables

-- function variableList
--     local tVariableArray

--     -- NOTE: a leading "m" will get added to the variable names
--     -- when they're assigned in the defaultBody function
--     set the itemdelimiter to tab
--     repeat for each line tVariable in field kVariablesField
--         put item 2 of tVariable into tVariableArray[item 1 of tVariable]["type"]
--     end repeat
--     -- mMouseIsDown is required by the mouse functions
--     put "Boolean" into tVariableArray["mMouseIsDown"]["type"]
--     return tVariableArray
-- end variableList

command AddVariable pName, pType
    lock screen
    if pName & tab is not in field kVariablesField then
        put pName & tab & pType & cr after field kVariablesField
    else
    end if
    unlock screen
 end AddVariable
 
private function variablesFrom pVariableArray
   local tVariablesBody
   local tVariables
   local tVariableType
   
   put the keys of pVariableArray into tVariables
   repeat for each line tVariable in tVariables
      put pVariableArray[tVariable]["type"] into tVariableType
      if char 1 of tVariable is "m" then
         delete char 1 of tVariable
      end if
      put "private variable m" & tVariable & space after tVariablesBody
      if tVariableType is not empty then
         put upper(char 1 of tVariableType) into char 1 of tVariableType
         put " as" && tVariableType after tVariablesBody
      end if
      put cr after tVariablesBody
   end repeat
   
   put cr after tVariablesBody
   return tVariablesBody
end variablesFrom

--> properties

-- function propertyList
--     local tPropertyArray

--     -- NOTE: a leading "m" will get added to the variable names
--     -- when they're assigned in the defaultBody function
--     set the itemdelimiter to tab
--     repeat for each line tProperty in field kPropertiesField
--         put item 2 of tProperty into tPropertyArray[item 1 of tProperty]["getter"]
--         put item 3 of tProperty into tPropertyArray[item 1 of tProperty]["setter"]
--         put item 1 of tProperty into tPropertyArray[item 1 of tProperty]["label"]
--         put "com.livecode.pi" into tPropertyArray[item 1 of tProperty]["editor"]
--         put "" into tPropertyArray[item 1 of tProperty]["default"]
--     end repeat
--     return tPropertyArray
-- end propertyList

-- command AddProperty pName, pGetter, pSetter
--     lock screen
--     if pName & tab & pGetter & pSetter is not in field kPropertiesField then
--         put pName & tab & pGetter & pSetter & cr after field kPropertiesField
--     end if
--     unlock screen
--  end AddProperty

private function propertiesFrom pPropertiesArray
   local tProperties
   local tBody
   local tGetterFunction, tSetterFunction
   
   put the keys of pPropertiesArray into tProperties
   repeat for each line tProperty in tProperties
      if tProperty & tab is not in field kVariablesField then
         put "private variable m" & tProperty & cr after tBody
      end if
      put "-- remove the 'set' parameter to make this property read-only" & cr after tBody
      put "property" && tProperty & space after tBody
      if pPropertiesArray[tProperty]["getter"] is not empty then
         -- create a getter function here
         put pPropertiesArray[tProperty]["getter"] into tGetterFunction
         put " get" && tGetterFunction & space after tBody
      else
         -- NOTE: the convention is for properties to start with an "m": mColor
         -- so we add a leading "m" here.
         put " get m" & tProperty & space after tBody
      end if
      if pPropertiesArray[tProperty]["setter"] is not empty then
         -- create a setter command here
         put pPropertiesArray[tProperty]["setter"] into tSetterFunction
         put " set" && tSetterFunction & cr after tBody
      else
         -- NOTE: the convention is for properties to start with an "m": mColor
         -- so we add a leading "m" here.
         put " set m" & tProperty & cr after tBody
      end if
      
      if pPropertiesArray[tProperty]["label"] is not empty then
         put "metadata" && tProperty & ".label is" && q(pPropertiesArray[tProperty]["label"]) & cr after tBody
      end if
      if pPropertiesArray[tProperty]["editor"] is not empty then
         put "metadata" && tProperty & ".editor is" && q(pPropertiesArray[tProperty]["editor"]) & cr after tBody
      end if
      if pPropertiesArray[tProperty]["default"] is not empty then
         put "metadata" && tProperty & ".default is" && q(pPropertiesArray[tProperty]["default"]) & cr after tBody
      end if
      
      if pPropertiesArray[tProperty]["getter"] is not empty then
         put getterFunctionFor(tProperty, tGetterFunction) after tBody
      end if
      if pPropertiesArray[tProperty]["setter"] is not empty then
         put setterFunctionFor(tProperty, tSetterFunction) after tBody
      end if
      put cr after tBody
   end repeat
   return tBody
end propertiesFrom

--> metadata

/**
* Get metadata from the metadata field,
* return it in an array for further processing
*/
-- function metadataList
--    local tMetadataArray

--    set the itemdelimiter to tab
--    repeat for each line tMetadataName in field kMetadataField
--       put item 2 of tMetadataName into tMetadataArray[item 1 of tMetadataName]["value"]
--    end repeat
--    return tMetadataArray
-- end metadataList

/**
* Add a metadata tuple (name, value) to the metadata field
*/
command AddMetadata pName, pValue
   lock screen
   if pName & tab & pValue is not in field kMetadataField then
      put pName & tab & pValue & cr after field kMetadataField
   end if
   unlock screen
end AddMetadata

private function metadataFrom pMetadataArray
   local tMetadataBody
   local tMetadataElements
   
   put the keys of pMetadataArray into tMetadataElements
   repeat for each line tMetadataName in tMetadataElements
      put "metadata" && tMetadataName after tMetadataBody
      put " is" && q(pMetadataArray[tMetadataName]["value"]) after tMetadataBody
      put cr after tMetadataBody
   end repeat
   
   put cr after tMetadataBody
   return tMetadataBody
end metadataFrom

--> types

-- function typesList
--    local tTypesArray

--    set the itemdelimiter to tab
--    repeat for each line tTypeName in field kTypesField
--       put item 2 of tTypeName into tTypesArray[item 1 of tTypeName]["value"]
--    end repeat
--    return tTypesArray
-- end typesList

command AddType pName, pType, pValue
   local tTypeString
   
   lock screen
   put pName & tab & pType & tab & pValue into tTypeString
   if tTypeString is not in field kTypesField then
      put tTypeString & cr after field kTypesField
   end if
   unlock screen
end AddType

private function typesFrom pTypesArray
   local tTypesBody
   local tTypeElements
   
   put the keys of pTypesArray into tTypeElements
   repeat for each line tTypeName in tTypeElements
      if pTypesArray[tTypeName]["type"] is "handler" then
         put "handler type" && tTypeName & pTypesArray[tTypeName]["value"] after tTypesBody
      else
         put "type" && tTypeName after tTypesBody
         put " is" && q(pTypesArray[tTypeName]["value"]) after tTypesBody
      end if
      put cr after tTypesBody
   end repeat
   
   put cr after tTypesBody
   return tTypesBody
end typesFrom

--> the widget

function defaultBody pVariableArray, pPropertyArray, pMetadataArray, pTypesArray
   local tBody
   local tVariables, tProperties
   local tGetterFunction, tSetterFunction
   local tVariableType
   
   put variablesFrom(pVariableArray) after tBody
   put propertiesFrom(pPropertyArray) after tBody
   put metadataFrom(pMetadataArray) after tBody
   put typesFrom(pTypesArray) after tBody
   
   return tBody
end defaultBody

private function getterFunctionFor pPropertyName, pSetterFunctionName
    local tFunction
    local tArguments, tContents
    
    put tab & "return m" & pPropertyName & cr after tContents
    put wrapSetter(pSetterFunctionName, tArguments, tContents) after tFunction
    return tFunction
end getterFunctionFor

private function setterFunctionFor pPropertyName, pSetterFunctionName
    local tFunction
    local tArguments, tContents
    
    if needToGenerateFunctionFor(pSetterFunctionName) then
        put "in pValue" into tArguments
        put tab & "put pValue into m" & pPropertyName & cr after tContents
        put wrapSetter(pSetterFunctionName, tArguments, tContents, "nothing") after tFunction
    end if
    return tFunction
end setterFunctionFor

/**
* Return a boolean saying whether we need to add the function or it already exists
* true: need to add
* false: already in the snippets array
*/
private function needToGenerateFunctionFor pFunction
    local tArray
    local tShouldGenerate
    
    put true into tShouldGenerate
    -- get the snippet array using the getter function
    dispatch function "SnippetArray" to field "fldSnippets"
    put the result into tArray
    -- see if it already exists in the array
    if pFunction is among the keys of tArray then
        put false into tShouldGenerate
    end if
    return tShouldGenerate
end needToGenerateFunctionFor

private function defaultHandlers
   local tHandlers
   
   -- the required default handlers
   put defaultCreateHandler() & cr after tHandlers
   put defaultSaveHandler() & cr after tHandlers
   put defaultLoadHandler() & cr after tHandlers
   put defaultPaintHandler() & cr after tHandlers
   
   -- snippets
   dispatch function "snippetHandlers" to field "fldSnippets"
   put the result & cr after tHandlers
   
   -- add the mouse handlers?
   if the hilite of button "btnMouse" then
      put defaultClickHandler() & cr after tHandlers
      put defaultMouseCancelHandler() & cr after tHandlers
      put defaultMouseUpHandler() & cr after tHandlers
      put defaultMouseDownHandler() & cr after tHandlers
      put defaultMouseMoveHandler() & cr after tHandlers
   end if
   
   return tHandlers
end defaultHandlers

private function documentation pArguments, pDescription
   local tDocumentation
   
   put "/**" & cr into tDocumentation
   put "Summary:" & cr after tDocumentation
   repeat for each item tArgument in pArguments
      put word 2 of tArgument & ":" & cr after tDocumentation
   end repeat
   put "Returns:" & cr after tDocumentation
   put "Description:" & cr & pDescription & cr after tDocumentation
   put "*/" & cr after tDocumentation
   return tDocumentation
end documentation

--> mouse handlers

private function defaultKeyPressHandler
   local tHandler
   local tContents
   local tArguments
   
   put tab & "post" && q("keyPress") && "to my script object" & cr after tContents
   put wrapHandler("KeyPress", tArguments, tContents) after tHandler
   return tHandler
end defaultKeyPressHandler

private function defaultClickHandler
   local tHandler
   local tContents
   local tArguments
   
   put tab & "if the current mouse position is within my bounds then" & cr after tContents
   put tab & tab & "post" && q("mouseUp") && "to my script object with [the click button]" & cr after tContents
   put tab & "end if" & cr after tContents
   put tab & "redraw all" & cr after tContents
   put wrapHandler("Click", tArguments, tContents) after tHandler
   return tHandler
end defaultClickHandler

private function defaultMouseUpHandler
    local tHandler
    local tContents
    local tArguments
    
    put tab & "put false into mMouseIsDown" & cr after tContents
    put tab & "if the click count is 2 then" & cr after tContents
    put tab & tab & "post" && q("mouseDoubleUp") && "with [the click button]" & cr after tContents
    put tab & "end if" & cr after tContents
    put tab & "redraw all" & cr after tContents
    put wrapHandler("MouseUp", tArguments, tContents, "nothing") after tHandler
    return tHandler
end defaultMouseUpHandler

private function defaultMouseDownHandler
    local tHandler
    local tContents
    local tArguments
    
    put tab & "variable tClick as Point" & cr & cr after tContents
    put tab & "put true into mMouseIsDown" & cr after tContents
    put tab & "put the click position into tClick" & cr after tContents
    put tab & "post" && q("mouseDown") && "to my script object with [the click button]" & cr after tContents
    put wrapHandler("MouseDown", tArguments, tContents, "nothing") after tHandler
    return tHandler
end defaultMouseDownHandler

private function defaultMouseCancelHandler
    local tHandler
    local tContents
    local tArguments
    
    put "-- if mouse is released outside of card" & cr after tContents
    put tab & "post" && q("mouseRelease") && "to my script object with [the click button]" & cr after tContents
    put wrapHandler("MouseCancel", tArguments, tContents) after tHandler
    return tHandler
end defaultMouseCancelHandler

private function defaultMouseMoveHandler
    local tHandler
    local tContents
    local tArguments
    
    put tab & "variable tMouseLoc" & cr & cr after tContents
    put tab & "put the mouse position into tMouseLoc" & cr after tContents
    put tab & "post" && q("mouseMove") && "to my script object with [the left of my rectangle + the x of tMouseLoc, the top of my rectangle + the y of tMouseLoc]" & cr after tContents
    put wrapHandler("MouseMove", tArguments, tContents) after tHandler
    return tHandler
end defaultMouseMoveHandler

--> required default handlers

private function defaultSaveHandler
   local tHandler
   local tContents
   local tArguments
   local tDescription
   
   put "out rProperties as Array" into tArguments
   put tab & "variable tValue" & cr after tContents
   put tab & "variable tIndex as Integer" & cr & cr after tContents
   put tab & "put tValue into rProperties[tIndex]" & cr after tContents
   put "-- this handler is called when the widget is saved" into tDescription
   put documentation(tArguments, tDescription) after tHandler
   put wrapHandler("Save", tArguments, tContents) after tHandler
   return tHandler
end defaultSaveHandler

private function defaultCreateHandler
   local tHandler
   local tContents
   local tArguments
   local tDescription
   
   put "-- this handler is called when the widget is created" into tDescription
   put documentation(tArguments, tDescription) after tHandler
   put wrapHandler("Create", tArguments, tContents, "nothing") after tHandler
   return tHandler
end defaultCreateHandler

private function defaultPaintHandler
   local tHandler
   local tContents
   local tArguments
   local tDescription
   
   put "-- this handler is called when the widget needs to be shown on the canvas" into tDescription
   put documentation(tArguments, tDescription) after tHandler
   put wrapHandler("Paint", tArguments, tContents, "nothing") after tHandler
   return tHandler
end defaultPaintHandler

private function defaultLoadHandler
   local tHandler
   local tContents
   local tArguments
   local tDescription
   
   put "in pProperties as Array" into tArguments
   put "-- this handler is called when the widget is loaded" into tDescription
   put documentation(tArguments, tDescription) after tHandler
   put tab & "variable tProperty" & cr after tContents
   put tab & "repeat for each element tProperty in pProperties" & cr after tContents
   put tab & tab & "-- do somethere here with tProperty" & cr after tContents
   put tab & "end repeat" & cr after tContents
   put wrapHandler("Load", tArguments, tContents) after tHandler
   return tHandler
end defaultLoadHandler

private function defaultGeometryChangedHandler
   local tHandler
   local tContents
   local tArguments
   local tDescription
   
   put "-- this handler is called when the widget is changed in size" into tDescription
   put documentation(tArguments, tDescription) after tHandler
   --    put tab & "variable tProperty" & cr after tContents
   --    put tab & "repeat for each element tProperty in pProperties" & cr after tContents
   --    put tab & tab & "-- do somethere here with tProperty" & cr after tContents
   --    put tab & "end repeat" & cr after tContents
   put wrapHandler("GeometryChanged", tArguments, tContents) after tHandler
   return tHandler
end defaultGeometryChangedHandler

/**
* Drag and drop handlers if needed
*/
private function dragHandlers
    constant kDefaultHandlers="DragStart,DragMove,DragDrop,DragEnter"
    
    local tContents
    local tHandlers
    
    if the hilite of button "btnDrag" then
        repeat for each item tHandler in kDefaultHandlers
            put tab & "post" && q(lower(tHandler)) && "to my script object" & cr into tContents
            put wrapHandler(tHandler, "", tContents) after tHandlers
        end repeat
    end if
    return tHandlers
end dragHandlers

--> handler formatting

private function wrapHandler pHandler, pArguments, pContents, pReturnType
    local tHandlerText
    
    put "public handler On" & pHandler & "(" & pArguments & ")" after tHandlerText
    if pReturnType is not empty then
        put " returns" && pReturnType after tHandlerText
    else
    end if
    put cr after tHandlerText
    put tab & "-- this logs a message when" && pHandler && "is invoked" & cr after tHandlerText
    put tab & "log" && q(pHandler) & cr after tHandlerText
    put pContents after tHandlerText
    put "end handler" & cr & cr after tHandlerText
    return tHandlerText
end wrapHandler

private function wrapSetter pHandler, pArguments, pContents, pReturnType
    local tHandlerText
    
    put "private handler" && pHandler & "(" & pArguments & ")" after tHandlerText
    if pReturnType is not empty then
        put "returns" && pReturnType after tHandlerText
    end if
    put cr after tHandlerText
    put pContents after tHandlerText
    put "end handler" & cr after tHandlerText
    return tHandlerText
end wrapSetter

--> Preferences

private function SetWidgetName
    local tWasAssigned
    
    put false into tWasAssigned
    answer "You haven't set a widget name.\nDo you want to assign one now?" with "No" and "Yes"
    if it is "Yes" then
        ask "Name the widget"
        if it is not empty then
            put it into sMetadataWidgetName
            put true into tWasAssigned
        end if
    end if
    return tWasAssigned
end SetWidgetName

command Preferences.Save
   local tPreferences
   local tProperty
   local tSavedDefaultFolder
   local tShouldSave
   
   put the defaultfolder into tSavedDefaultFolder
   if sMetadataWidgetName is empty then
      if SetWidgetName() is false then
         exit Preferences.Save
      end if
   end if
   if sWidgetFolder is empty then
      if createFolder() is empty then
         exit Preferences.Save
      end if
   end if
   set the defaultfolder to sWidgetFolder & "/" & sMetadataWidgetName
   --put sCommunity into tPreferences["sCommunity"]
   put sMetadataVersion into tPreferences["sMetadataVersion"]
   put field "fldCompany" into sIdentifier
   put sIdentifier into tPreferences["sIdentifier"]
   put field "fldAuthor" into sMetadataAuthor
   put sMetadataAuthor into tPreferences["sMetadataAuthor"]
   put field "fldAuthorEmail" into sMetadataEmail
   put sMetadataEmail into tPreferences["sMetadataEmail"]
   put sMetadataWidgetTitle into tPreferences["sMetadataWidgetTitle"]
   put sMetadataWidgetName into tPreferences["sMetadataWidgetName"]
   put sDescription into tPreferences["sDescription"]
   
   set the itemdelimiter to tab
   -- the variables
   repeat for each line tImport in field kVariablesField
      put item 2 of tImport into tPreferences["variables"][item 1 of tImport]
   end repeat
   
   -- the properties
   repeat for each line tImport in field kPropertiesField
      put true into tPreferences["properties"][item 1 of tImport]
      if item 2 of tImport is not empty then
         put item 2 of tImport into tPreferences["properties"][item 1 of tImport]["getter"]
      end if
      if item 3 of tImport is not empty then
         put item 3 of tImport into tPreferences["properties"][item 1 of tImport]["setter"]
      end if
   end repeat
   
   -- the imported modules
   repeat for each line tImport in field kModulesField
      put "uNeed" & tImport into tProperty
      if the tProperty of me then
         put the tProperty of me into tPreferences[tProperty]
      end if
   end repeat
   
   -- the snippets
   dispatch function "SnippetArray" to field "fldSnippets"
   put the result into tPreferences["snippets"]
   
   put false into tShouldSave
   if there is a file (sMetadataWidgetName & ".factory") then
      answer "you already have a file named" && sMetadataWidgetName & ".factory. Overwrite it?" with "No" and "Yes"
      if it is "Yes" then
         put true into tShouldSave
      end if
   else
      put true into tShouldSave
   end if
   if tShouldSave then
      put ArrayToJSON(tPreferences) into url ("file:" & sMetadataWidgetName & ".factory")
   end if
   set the defaultfolder to tSavedDefaultFolder
end Preferences.Save

 /**
* A factory file contains a json object
* find one, parse it, and load the contents
*/
command loadFactory
    answer file "locate a factory file to load" with type "factory|factory|factory"
    if it is not empty then
        Preferences.Load it
        ImportPreferences.Set
    end if
end loadFactory

 /*
* Given a file specification
* load the file, convert the json object to an array
* and process the array into the right places
*/
command Preferences.Load pFile
   local tPreferences
   local tProperty
   local tArray, tKeys
   
   if pFile is not empty then
      if there is a file pFile then
         put url ("file:" & pFile) into tPreferences
         put JSONToArray(tPreferences) into tPreferences
         
         --         put tPreferences["sCommunity"] into sCommunity
         --         switch sCommunity
         --            case "Comercial"
         --               set the hilite of button "btnCommercial" to true
         --               break
         --            case "Organization"
         --               set the hilite of button "btnOrganization" to true
         --               break
         --            default
         --               set the hilite of button "btnCommunity" to true
         --         end switch
         put tPreferences["sMetadataVersion"] into sMetadataVersion
         put sMetadataVersion into field "fldVersion"
         put tPreferences["sIdentifier"] into sIdentifier
         put sIdentifier into field "fldCompany"
         put tPreferences["sMetadataAuthor"] into sMetadataAuthor
         put sMetadataAuthor into field "fldAuthor"
         put tPreferences["sMetadataEmail"] into sMetadataEmail
         --put sMetadataEmail into field "fldAuthorEmail"
         put tPreferences["sMetadataWidgetTitle"] into sMetadataWidgetTitle
         put sMetadataWidgetTitle into field "fldTitle"
         put tPreferences["sMetadataWidgetName"] into sMetadataWidgetName
         put sMetadataWidgetName into field "fldProject"
         put tPreferences["sDescription"] into sDescription
         put sDescription into field "fldDescription"
         
         -- the imported modules
         ModulePreferences.Clear
         repeat for each line tImport in field kModulesField
            put "uNeed" & tImport into tProperty
            if tPreferences[tProperty] then
               set the tProperty of me to tPreferences[tProperty]
            end if
         end repeat
         
         -- the variables
         put empty into field kVariablesField
         put tPreferences["variables"] into tArray
         put the keys of tArray into tKeys
         repeat for each line tKey in tKeys
            put tKey & tab & tArray[tKey] & cr after field kVariablesField
         end repeat
         
         -- the properties
         put empty into field kPropertiesField
         put tPreferences["properties"] into tArray
         put the keys of tArray into tKeys
         repeat for each line tKey in tKeys
            put tKey & tab & tArray[tKey]["getter"] & tab & tArray[tKey]["setter"] & cr after field kPropertiesField
         end repeat
         
         -- the snippets
         put tPreferences["snippets"] into tArray
         put the keys of tArray into tKeys
         
      end if
   end if
end Preferences.Load

 /**
* set the highlighted lines of the modules field
*/
command ImportPreferences.Set
    local tProperty
    local tLineNumber
    local tLines
    
    lock screen
    put 1 into tLineNumber
    repeat for each line tImport in field kModulesField
        put "uNeed" & tImport into tProperty
        if the tProperty of me then
            put tLineNumber & comma after tLines
        end if
        add 1 to tLineNumber
    end repeat
    set the hilitedlines of field kModulesField to tLines
    unlock screen
end ImportPreferences.Set

 /**
* given a comma-delimited list of line numbers
* set the corresponding custom properties
* and the visual display
*/
command ImportPreferences.Change pLineNumbers
   local tImport
   
   lock screen
   ModulePreferences.Clear
   repeat for each item tLine in pLineNumbers
      put line tLine of field kModulesField into tImport
      ModulePreference.Set tImport, true
   end repeat
   set the hilitedlines of field kModulesField to pLineNumbers
   unlock screen
end ImportPreferences.Change
 
private command ModulePreference.Set pModule, pBoolean
   local tProperty
   
   put "uNeed" & pModule into tProperty
   set the tProperty of me to pBoolean
end ModulePreference.Set

 /**
* tabula rasa for the import modules
*/
private command ModulePreferences.Clear
   local tImport
   
   lock screen
   set the hilitedlines of field kModulesField to empty
   hide field "fldModuleHandlers"
   repeat for each line tImport in field kModulesField
      ModulePreference.Set tImport, false
   end repeat
   unlock screen
end ModulePreferences.Clear

private function q pText
    return quote & pText & quote
end q

on openCard
   lock screen
   Preferences.Load
   initialize
   unlock screen
end openCard

function rootURL
   return kRootURL
end rootURL
