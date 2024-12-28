syn match todoComment   /^\s*..*$/
syn match todoTask      /^\s*-.*$/
syn match todoDone      /^\s*+.*$/
syn match todoCritical  /^\s*!.*$/
syn match todoQuestion  /^\s*?.*$/
syn match todoCancelled /^\s*\/.*$/

hi def link todoTask      Type
hi def link todoDone      String
hi def link todoCritical  Special
hi def link todoQuestion  Function
hi def link todoCancelled Comment
