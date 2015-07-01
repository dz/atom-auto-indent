module.exports =
    activate: ->
        atom.commands.add "atom-text-editor", "auto-indent:apply", => @apply()
        atom.commands.add "atom-text-editor", "auto-indent:applyCurrentLine", => @applyCurrentLine()

    apply: ->
        @autoindent(@selectAll)

    applyCurrentLine: ->
        @autoindent(@selectCurrentLine)

    autoindent: (selection_method) ->
        editor = atom.workspace.getActivePaneItem()
        # We get the cursor and save is position
        cursor = editor.getLastCursor()
        savedPosition = cursor.getScreenPosition()
        # If no text is selected, we select all the lines and auto-indent them according to the grammar
        if editor.getSelectedText().length == 0
            selection_method()
        editor.autoIndentSelectedRows()
        # And finally we put the cursor where it was
        cursor = editor.getLastCursor()
        cursor.setScreenPosition(savedPosition)

    selectAll: (editor) ->
      editor.selectAll()

    selectCurrentLine: (editor) ->
      editor.selectLinesContainingCursors()
