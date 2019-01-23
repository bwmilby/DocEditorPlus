Script "stack_DocEditorPlus_button_id_1018"

/*
# Name: button "Preview" of card "DocEditor" of stack "DocEditorPlus"
# ID: button id 1018 of card id 1002 of stack "DocEditorPlus"
*/


on mouseUp
   local tIsSingleDoc
   
   if the text of field "CodeText" is not empty then
      ParseData the text of field "CodeText"
      put false into tIsSingleDoc
   else
      ParseData the text of field "DocText"
      put true into tIsSingleDoc
   end if
   if the text of field "DocText" is empty then
      answer "Nothing to preview."
      exit to top
   end if
   
   local tLibraryA
   put the arrayData of widget "DocTree" into tLibraryA
   
   if tIsSingleDoc then
      previewSingle tLibraryA["doc"][1]
   else
      previewMultiple tLibraryA
   end if
end mouseUp

command previewMultiple pLibraryA
   local tData
   put revDocsFormatLibraryArrayAsJSON(pLibraryA) into tData
   
   put "var dictionary_data =" & return & "{" & return & \
         tab & quote & "docs" & quote & ":[" & \
         tData & return & tab & "]" & return & "}" \
         into tData
   
   previewDocInBrowser tData
end previewMultiple

command previewSingle pDoc
   local tDoc, tName
   put pDoc into tDoc
   put revDocsModifyForURL(pDoc["display name"]) into tName
   
   local tMatch
   put quote & "id" & quote & colon & quote & "(.+)" & quote & comma into tMatch
   
   local tDataPath, tData
   put revIDESpecialFolderPath("documentation cache") & slash & "built_api.js" into tDataPath
   put revIDEUTF8FileContents(tDataPath) into tData
   
   local tIDLineNumber, tNextIDLineNumber, tCheckName, tMatchedName, tID, tNextID, tCount
   put false into tCheckName
   put false into tMatchedName
   put 0 into tCount
   repeat for each line tLine in tData
      add 1 to tCount
      if tCheckName then
         if  word 1 to -1 of tLine is \
               quote & "name" & quote & colon & quote & tName & quote & comma then
            put tNextID into tID
            put tNextIDLineNumber into tIDLineNumber
            put true into tMatchedName
         end if
         put false into tCheckName
      end if
      if matchText(word 1 to -1 of tLine, tMatch, tNextID) then
         put tCount into tNextIDLineNumber
         if tMatchedName then
            exit repeat
         else
            put true into tCheckName
         end if
      end if
   end repeat
   
   local tAPI
   put revDocsFormatLibraryDataAsJSON(tID, pDoc) into tAPI
   
   put line 2 to -2 of tAPI into line tIDLineNumber to tNextIDLineNumber - 2 of tData
   
   previewDocInBrowser tData, "LiveCode Script", pDoc["display name"], pDoc["type"]
end previewSingle

command previewDocInBrowser pData, pLibraryName, pEntryName, pEntryType
   local tDataPath
   put revIDESpecialFolderPath("documentation cache") & slash & "preview_api.js" into tDataPath
   revIDESetUTF8FileContents tDataPath, pData   
   
   local tGeneratedHTMLFile
   put revIDESpecialFolderPath("documentation cache") & slash & "preview.html" into tGeneratedHTMLFile
   
   local tLibraryName, tEntryName, tEntryType
   put pLibraryName into tLibraryName
   put pEntryName into tEntryName
   put pEntryType into tEntryType
   
   local tDocsBase
   put revIDESpecialFolderPath("documentation") & slash & "html_viewer" into tDocsBase
   
   local tDocsCSSFolder, tDocsJSFolder
   put tDocsBase & slash & "css" into tDocsCSSFolder
   put tDocsBase & slash & "js" into tDocsJSFolder
   
   local tIDEGuidesFolder, tRepoGuidesFolder
   put revIDESpecialFolderPath("ide guides") into tIDEGuidesFolder
   put revIDESpecialFolderPath("repo guides") into tRepoGuidesFolder
   
   local tTemplate
   try
      put revIDEUTF8FileContents(revIDEGetDictionaryHTMLTemplate("api")) into tTemplate
   catch tError
      put url ("https://raw.githubusercontent.com/livecode/livecode-ide/develop/Documentation/html_viewer/api.html.template") into tTemplate
   end try
   put merge(tTemplate) into tTemplate
   revIDESetUTF8FIleContents tGeneratedHTMLFile, tTemplate
   local tUrl
   put "file://" & tGeneratedHTMLFile into tUrl
   launch url tUrl
end previewDocInBrowser
