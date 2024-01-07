;; extends

(
 (const_spec
   name: (identifier) @_id
   value: (expression_list (interpreted_string_literal) @sql))

 (#contains? @_id "Query")
 )

(call_expression
  (selector_expression
    field: (field_identifier) @property (#match? @property "Query|Exec"))
  (argument_list
    (interpreted_string_literal) @sql
  )
)
