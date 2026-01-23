; extends

(function_call 
  name: (dot_index_expression
    table: (identifier) @table-name
    field: (identifier) @field-name
    (#eq? @table-name "Echo")
    (#eq? @field-name "DBExec")
  )
  arguments: (arguments 
    [
      (binary_expression
        left: (string (string_content) @injection.content)
      )
      (string content: (string_content) @injection.content)
    ]
    (#set! injection.language "sql")
  ) @dbexec-args
) @dbexec-call

(function_call 
  name: (identifier) @function-name
  (#eq? @function-name "compile")
  arguments: (arguments 
    (string content: (string_content) @injection.content)
    (#set! injection.language "xml")
  )
)
