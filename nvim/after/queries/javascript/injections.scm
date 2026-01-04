; extends 

(call_expression
  (member_expression 
    (identifier) @vue-class
    (property_identifier) @component-function
    (#eq? @vue-class "Vue")
    (#eq? @component-function "component")
  ) @component-initializer
  (arguments 
    (string (string_fragment) @component-name)
    (object 
      [
        (pair 
          key: (property_identifier) @component-object-property
          value: 
            [
              (expression)
              (template_string (string_fragment) @injection.content)
              (#set! injection.language "vue")
              (object)
            ] @component-object-value
        )
        (method_definition
          name: (property_identifier) @method-name
        ) @component-method
      ]
    )
  )
)
