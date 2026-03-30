; ;; select([...])
; (
;   (call_expression
;     function: (member_expression
;
;       property: (property_identifier) @fn
;     )
;     arguments: (arguments
;
;       (array
;
;         (string (string_fragment) @injection.content)
;       )
;     )
;   )
;   (#match? @fn "^(select)$")
;   (#set! injection.language "sql")
; )
;
; ;; addSelect("SQL", "alias")
; (
;   (call_expression
;     function: (member_expression
;       property: (property_identifier) @fn
;     )
;     arguments: (arguments
;       (string (string_fragment) @injection.content)
;       (_)?
;     )
;   )
;   (#match? @fn "^(addSelect|where|andWhere|orWhere|innerJoin|leftJoin|from)$")
;   (#set! injection.language "sql")
;
; )
;
; ;; template string SQL
; (
;   (template_string
;
;     (string_fragment) @injection.content
;   )
;   (#set! injection.language "sql")
; )
;
