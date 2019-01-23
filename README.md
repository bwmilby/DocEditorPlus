# DocEditorPlus
LiveCode Documentation Editor plus Widget Wizard

## DocEditor

This is a tool to assist in updating documentation for LiveCode.  LCDOC files can be imported and worked on within the stack and previewed in a browser.  LCB files may also be edited and parsed to have the documentation extracted for preview.  The internal document array structure is available as a way to troubleshoot the parsing if necessary.

- **Open**:  select a file (.lcdoc/.lcb/.livecodescript)
- **Reload**:  refresh text after editing in an external editor
- **Save**:  save the current file (edited in the first tab)
- **Process**:  process the current file into a document array (checks for errors)
- **Preview Doc**:  preview the documentation in the default system browser

For LCB files...
- **Package**:  generate a widget package
- **Uninstall**:  uninstall currently loaded widget file
- **Install**:  install currently loaded widget file
- **Stop Testing**:  stop testing currently loaded widget file
- **Test**:  test currently loaded widget file

## Widget Wizard

This is a tool to help create a new widget shell including some template code

Widget Wizard contributed by Mark Wieder
