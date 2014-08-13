(require 'sql)

(sql-set-product-feature 'ms :list-all ".find")
(sql-set-product-feature 'ms :list-table ".explain %s")
(sql-set-product-feature 'ms :prompt-regexp "^\\w*> ")
(sql-set-product-feature 'ms :completion-object 'jdh-sql-ms-completion-object)
(sql-set-product-feature 'ms :completion-column 'jdh-sql-ms-completion-object)

(defun jdh-sql-ms-completion-object (sqlbuf schema)
  (sql-redirect-value
   (sql-find-sqli-buffer)
   (concat
    "select s.name + '.' +	o.name"
    "	from sys.objects o"
    "	inner join sys.schemas s on o.schema_id = s.schema_id"
    "	where"
    "		type in ('P', 'V', 'U', 'TF', 'IF', 'FN' )"
    "		and  is_ms_shipped = 0"
    "\ngo")
   "^| \\([a-zA-Z0-9_\.]+\\).*|$" 1))

(defun sql-try-completion (string collection &optional predicate)
  (when sql-completion-sqlbuf
      (with-current-buffer sql-completion-sqlbuf
        (let ((schema (and (string-match "\\`\\(\\sw\\(:?\\sw\\|\\s_\\)*\\)[.]" string)
                           (downcase (match-string 1 string)))))

          ;; If we haven't loaded any object name yet, load local schema
          (unless sql-completion-object
            (sql-build-completions nil))

          ;; If they want another schema, load it if we haven't yet
          (when schema
            (let ((schema-dot (concat schema "."))
                  (schema-len (1+ (length schema)))
                  (names sql-completion-object)
                  has-schema)

              (while (and (not has-schema) names)
                (setq has-schema (and
                                  (>= (length (car names)) schema-len)
                                  (string= schema-dot
                                           (downcase (substring (car names)
                                                                0 schema-len))))
                      names (cdr names)))
              (unless has-schema
                (sql-build-completions schema)))))

        (cond
         ((not predicate)
          (try-completion string sql-completion-object))         
         ((eq predicate t)
          (all-completions string sql-completion-object))
         ((eq predicate 'lambda)
          (test-completion string sql-completion-object))
         ;;ianic added this condition
         ((eq predicate 'metadata)
          (test-completion string sql-completion-object))
         ((eq (car predicate) 'boundaries)
          (completion-boundaries string sql-completion-object nil (cdr predicate)))))))
