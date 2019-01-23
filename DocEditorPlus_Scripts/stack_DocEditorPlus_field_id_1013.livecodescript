Script "stack_DocEditorPlus_field_id_1013"

/*
# Name: field "DocText" of card "DocEditor" of stack "DocEditorPlus"
# ID: field id 1013 of card id 1002 of stack "DocEditorPlus"
*/


constant kAPITypes = "command,function,property,message,constant,keyword,control structure,operator,statement,expression"
constant kGlossaryTypes = "library,glossary,object,widget"
constant kOS = "iOS,Android,Mac,Windows,Linux,RPi,html5"
constant kPlatform = "server,desktop,mobile"

local sErrors
private command appendToArray pValue, @xArray
   get the number of elements in xArray
   put pValue into xArray[it +1]
end appendToArray

private command addErrorIf pElementName, pTest, pDescription
   if pTest is not true then 
      appendToArray pDescription, sErrors[pElementName]["general"]
   end if
end addErrorIf

private command addSyntaxErrorIf pSyntaxIndex, pTest, pDescription
   if pTest is not true then 
      appendToArray pDescription, sErrors["Syntax"]["array"][pSyntaxIndex]
   end if
end addSyntaxErrorIf

private command addExampleErrorIf pSyntaxIndex, pTest, pDescription
   if pTest is not true then 
      appendToArray pDescription, sErrors["Example"]["array"][pSyntaxIndex]
   end if
end addExampleErrorIf

private command addParamErrorIf pParam, pTest, pDescription
   if pTest is not true then 
      appendToArray pDescription, sErrors["Parameters"]["array"][pParam]
   end if
end addParamErrorIf

on validateEntries
   local tLibraryA, tErrors
   put the arrayData of widget "DocTree" into tLibraryA
   
   repeat for each key tKey in tLibraryA["doc"]
      if tKey is 0 then
         next repeat
      end if
      validateEntry tLibraryA["doc"][tKey]
      put formatErrors(the result) into tErrors
      if tErrors is not empty then
         put tErrors into tLibraryA["errors"][tKey]
      end if
   end repeat
   
   set the arrayData of widget "DocTree" to tLibraryA
end validateEntries

on validateEntry pElement
   put empty into sErrors
   
   local tReferences
   put true into tReferences[pElement["type"]][pElement["display name"]]
   
   local tValue
   local tIndex
   
   local tTypes
   put (kAPITypes,kGlossaryTypes) into tTypes
   
   addErrorIf "Name", pElement["display name"] is not empty, "name is empty"
   
   if pElement["type"] is empty then
      addErrorIf "Type", false, "type is empty"
   else
      addErrorIf "Type", pElement["type"] is among the items of tTypes, "invalid type" && pElement["type"] & "(must be one of" && tTypes & ")"
   end if
   
   -- test syntaxes exist for API entries
   local tSyntaxParams
   if pElement["type"] is not among the items of kGlossaryTypes then
      addErrorIf "Syntax", pElement["syntax"] is an array, "syntax is empty"
      
      -- parse out params to validate against documented params
      repeat with x = 1 to the number of elements in pElement["syntax"]
         put pElement["syntax"][x] into tValue
         -- ensure matching brackets
         CheckBrackets tValue, x
         
         split tValue by "<"
         local tSplitIndex
         repeat with tSplitIndex = 2 to the number of elements of tValue
            split tValue[tSplitIndex] by ">"
            split tValue[tSplitIndex][1] by "|"
            put true into tSyntaxParams[tValue[tSplitIndex][1][1]]
         end repeat
      end repeat
      
      addErrorIf "Summary", pElement["summary"] is not empty, "summary is empty"
   end if
   
   -- !TODO test associations are valid
   
   -- test OS
   repeat for each element tValue in pElement["OS"]
      addErrorIf "os", tValue is among the items of kOS, "invalid os" && tValue & "(must be one of" && kOS & ")"
   end repeat
   
   -- test platform
   repeat for each element tValue in pElement["Platform"]
      addErrorIf "platform", tValue is among the items of kPlatform, "invalid os" && tValue & "(must be one of" && kPlatform & ")"
   end repeat
   
   -- test examples
   repeat with x = 1 to the number of elements in pElement["Example"]
      put pElement["example"][x] into tValue
      
      if word 1 of tValue is among the words of "end case" then
         next repeat
      end if
      
      --some scrips have ... to indicate user code
      replace "..." with empty in tValue
      
      --some html entities
      replace "&gt;" with ">" in tValue
      replace "&lt;" with "<" in tValue
      
      local tLine
      local tRequiresWrap
      put true into tRequiresWrap
      repeat for each line tLine in tValue
         if word 1 of tLine is among the words of "on private command function before after setprop getprop" then
            put false into tRequiresWrap
            exit repeat
         end if
      end repeat
      
      local tWrapWith
      put empty into tWrapWith
      if tRequiresWrap then
         get matchText(tValue, "exit (.+)", tWrapWith)
         if tWrapWith is empty or word 1 of tWrapWith is among the words of "repeat if switch to" then
            put "mouseUp" into tWrapWith
         end if
      end if
      
      local tTempValue
      if tRequiresWrap then
         put "on" && tWrapWith & return & tValue & return & "end" && tWrapWith into tTempValue
      else
         put tValue into tTempValue
      end if
      
      local tResult
      compileCheck tTempValue
      put the result into tResult
      
      --!TODO this should not be necessary if we fix all these docs but baby steps!!!
      -- check for lack of vairable declaration but only auto fix for 1 variable
      if tResult is not empty then
         -- require variable declaration
         if item 1 of line 1 of tResult is among the items of 14,78,209,423,507 and "(" is not in item 4 of line 1 of tResult then
            put "local" && item 4 of line 1 of tResult & return before tTempValue
            set the script of stack "Test" to tTempValue
            put the result into tResult
         else if the number of lines of tValue is 1 then
            --!TODO this should not be necessary if we fix all these docs but baby steps!!!
            -- check for half baked examples
            set the itemDelimiter to "("
            switch 
               case word 1 of tValue is not among the lines of the commandNames
               case item 1 of tValue is among the lines of the functionNames and the number of items of tValue > 1
                  put "put " before tValue
                  break
               case word 1 of tValue is "repeat"
                  put return & "end repeat" after tValue
                  break
               case word -1 of tValue is "then"
                  put return & "end if" after tValue
                  break
            end switch
            set the itemDelimiter to comma
            
            if tRequiresWrap then
               put "on" && tWrapWith & return & tValue & return & "end" && tWrapWith into tTempValue
            end if
            
            compileCheck tTempValue
            if the result is empty then
               put empty into tResult
            end if
         end if
      end if
      
      if tResult is not empty then
         local tError
         put "example does not compile" & return into tError
         put "Example:" & return & tValue  & return & "Script Parsing Error:" & return & \
               line (item 1 of line 1 of tResult) of the scriptParsingErrors && "-" && item 4 of line 1 of tResult after tError
         addExampleErrorIf x, false, tError
      end if
   end repeat
   
   -- test parameters
   local tDocumentedParams
   repeat for each element tValue in pElement["params"] 
      put true into tDocumentedParams[tValue["name"]]
   end repeat
   
   local tUnion
   put tDocumentedParams into tUnion
   union tUnion with tSyntaxParams
   
   -- widget parameter is implicit for LCB files
   delete variable tUnion["widget"]
   
   local tParam, tType
   repeat for each key tParam in tUnion
      
      -- determine if the param specified a type
      SplitParam tParam
      
      -- params in syntax section may be documented in glossary
      addParamErrorIf tParam[1], tDocumentedParams[tParam[1]], "param" && tParam[1] && "not in param section"
      
      -- params in param section should be in the syntax section otherwise what are they documenting
      addParamErrorIf tParam[1], tSyntaxParams[tParam[1]], "param" && tParam[1] && "not in syntax section"
      
   end repeat
   
   addErrorIf "Description", pElement["Description"] is not empty, "description is empty"
   
   -- !TODO parse all summaries and descriptions etc
   -- * test all links are listed in references
   -- * test for ambiguous links
   
   return sErrors
end validateEntry

command SplitParam @pParam
   -- find type
   split pParam by "("
   split pParam[2] by ")"
   
   -- trim
   put word 1 to -1 of pParam[1] into pParam[1]
   put word 1 to -1 of pParam[2][1] into pParam[2]
end SplitParam

command CheckBrackets pSyntax, pIndex
   local tCodepoint, tBrackets
   repeat for each codepoint tCodepoint in pSyntax
      switch tCodepoint
         case "{"
            SetState tBrackets, "{}", "open", pIndex
            break
         case "}"
            SetState tBrackets, "{}", "closed", pIndex
            break
         case "["
            SetState tBrackets, "[]", "open", pIndex
            break
         case "]"
            SetState tBrackets, "[]", "closed", pIndex
            break
         case "("
            SetState tBrackets, "()", "open", pIndex
            break
         case ")"
            SetState tBrackets, "()", "closed", pIndex
            break
         case "<"
            SetState tBrackets, "<>", "open", pIndex
            break
         case ">"
            SetState tBrackets, "<>", "closed", pIndex
            break
         case "|"
            if not pSyntax contains "port" then -- socket identifiers
               -- allow pipe for plural params
               addSyntaxErrorIf pIndex, GetState(tBrackets, "{}") is "open" and GetState(tBrackets, "<>") is "closed", pIndex &&  "variant not in curly brackets"
            end if
            break
      end switch
   end repeat
   
   addSyntaxErrorIf pIndex, tBrackets["{}"]["count"] is empty or tBrackets["{}"]["count"] is 0, "unmatched pairs of curly brackets"
   
   addSyntaxErrorIf pIndex, tBrackets["[]"]["count"] is empty or  tBrackets["[]"]["count"] is 0, "unmatched pairs of square brackets"
   
   addSyntaxErrorIf pIndex, tBrackets["()"]["count"] is empty or  tBrackets["()"]["count"] is 0, "unmatched parentheses"
   addSyntaxErrorIf pIndex, tBrackets["<>"]["count"] is empty or  tBrackets["<>"]["count"] is 0, "unmatched angle brackets"
end CheckBrackets

constant kBracketTypes = "{},[],(),<>"

command SetState @xBrackets, pType, pState, pIndex
   local tSize
   put the number of elements of xBrackets[pType] into tSize
   
   if pState is "open" then
      add 1 to tSize
   end if
   
   put pState into xBrackets[pType][tSize]["state"]
   
   local tType
   repeat for each item tType in kBracketTypes
      if tType is pType then
         next repeat
      end if
      
      local tOtherSize
      put the number of elements of xBrackets[tType] into tOtherSize
      
      if tOtherSize is 0 then
         next repeat
      end if
      
      if pState is "open" then
         if xBrackets[tType][tOtherSize]["state"] is "open" then
            put tOtherSize into xBrackets[pType][tSize][tType]
         else if xBrackets[pType][tSize][tType] is an integer and \
               xBrackets[tType][xBrackets[pType][tSize][tType]]["state"] is not "open" then
            -- check if any brackets open when we opened these are still open
            addSyntaxErrorIf pIndex, false, "brackets" && pType && tType && "nested incorrectly"
         end if
      end if
   end repeat
end SetState

function GetState pBrackets, pType
   local tSize
   repeat with tSize = the number of elements of pBrackets[pType] down to 1
      if pBrackets[pType] is "open" then return "open"
   end repeat
   
   return "closed"
end GetState

private command compileCheck pScript
   local tCompileTest, tCompileResult
   --checks to see if the message compiles
   lock messages
   create script only stack "ideCompilationTest"
   set the script of stack "ideCompilationTest" to pScript
   put the result into tCompileResult
   delete stack "ideCompilationTest"
   unlock messages
   repeat for each line tError in tCompileResult
      if item 2 of tError is not 0 then
         return tError
      end if
   end repeat
   
   return empty
end compileCheck

/*************************************************************************/

private command addErrorList @xOutput, pName, pValue
   put "<ul>" after xOutput
   repeat for each element tElement in pValue
      put "<li>" & tElement & "</li>" after xOutput
   end repeat
   put "</ul>" after xOutput
end addErrorList

private command addError @xOutput, pName, pValue
   if xOutput is empty then
      put "<ul>" into xOutput
   end if
   
   put "<li>" & pName after xOutput
   
   if pValue["general"] is not empty then 
      put "- " & pValue["general"][1] after xOutput
   end if
   
   if pValue["array"] is not empty then
      local tOutput
      repeat for each key tName in pValue["array"]
         addErrorList xOutput, tName, pValue["array"][tName]
      end repeat
   end if
   
   put "</li><br>" & return after xOutput
end addError

function formatErrors pArray
   local tOutput
   if pArray is empty then
      exit formatErrors
   end if
   repeat for each key tElName in pArray
      addError tOutput, tElName, pArray[tElName]
   end repeat
   return tOutput
end formatErrors
