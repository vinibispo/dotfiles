(local (ok saga_provider) (pcall require :lspsaga.provider))
(when (not ok)
  (lua "return true"))

(local (ok saga_action) (pcall require :lspsaga.action))
(when (not ok)
  (lua "return true"))

(local (ok saga_signature_help) (pcall require :lspsaga.signaturehelp))

(when (not ok)
  (lua "return true"))

(local (ok saga_hover) (pcall require :lspsaga.hover))
(when (not ok)
  (lua "return true"))

(local (ok installer) (pcall require :nvim-lsp-installer))
(when (not ok)
  (lua "return true"))

(local (ok lsp_servers) (pcall require :nvim-lsp-installer.servers))
(when (not ok)
  (lua "return true"))

(local required_servers [:bashls
                         :cssls
                         :dockerls
                         :graphql
                         :html
                         :jsonls
                         :sumneko_lua
                         :pylsp
                         :solargraph
                         :tsserver
                         :yamlls
                         :jdtls])

(installer.setup {:ensure_installed required_servers})

(local (ok cmp_nvim_lsp) (pcall require :cmp_nvim_lsp))
(when (not ok)
  (lua "return true"))

(local (ok lspconfig) (pcall require :lspconfig))
(when (not ok)
  (lua "return true"))

(local (ok saga) (pcall require :lspsaga))
(when (not ok)
  (lua "return true"))

(local (ok null_ls) (pcall require :null-ls))
(when (not ok)
  (lua "return true"))

(saga.init_lsp_saga {:error_sign "✗"
                     :warn_sign "⚠"
                     :code_action_prompt {:enable false}})

(fn on_attach [client buffnr]
  (local opts {:silent true :noremap true :buffer buffnr})
  (local mappings
         [[:n :gd #(vim.lsp.buf.definition) opts]
          [:n :gD #(saga_provider.preview_definition) opts]
          [:n :gr #(vim.lsp.buf.rename) opts]
          [:n :gh #(saga_provider.lsp_finder) opts]
          [:n :<leader>ca #(vim.lsp.buf.code_action) opts]
          [:n :<leader>ca #(vim.lsp.buf.range_code_action) opts]
          [:n :<C-a> #(saga_action.smart_scroll_with_saga 1) opts]
          [:n :<C-b> #(saga_action.smart_scroll_with_saga -1) opts]
          [:n :gs #(saga_signature_help.signature_help) opts]
          [:n :<leader>Z #(saga_hover.render_hover_doc) opts]
          [:n "[g" #(vim.diagnostic.goto_next) opts]
          [:n "]g" #(vim.diagnostic.goto_prev) opts]])
  (each [key val (pairs mappings)]
    (let [[first second third fourth] val]
      (vim.keymap.set first second third fourth)))
  (if (and client.resolved_capabilities.document_formatting
           (not= client.name :tsserver))
      (let [lsp_formatting (vim.api.nvim_create_augroup :lsp_formatting
                                                        {:clear true})]
        (vim.keymap.set :n :<leader>F #(vim.lsp.buf.formatting) opts)
        (vim.api.nvim_create_autocmd :BufWritePre
                                     {:pattern :<buffer>
                                      :group lsp_formatting
                                      :callback #(vim.lsp.buf.formatting_sync)}))
      client.resolved_capabilities.document_range_formatting
      (vim.keymap.set :n :<leader>F #(vim.lsp.buf.range_formatting) opts))
  (when client.resolved_capabilities.document_highlight
    (local lsp_document_highlight_augroup
           (vim.api.nvim_create_augroup :lsp_document_highlight {:clear false}))
    (vim.api.nvim_create_autocmd :CursorHold
                                 {:pattern :<buffer>
                                  :group lsp_document_highlight_augroup
                                  :callback #(vim.lsp.buf.document_highlight)})
    (vim.api.nvim_create_autocmd :CursorMoved
                                 {:pattern :<buffer>
                                  :group lsp_document_highlight_augroup
                                  :callback #(vim.lsp.buf.clear_references)})))

(fn make-config [client-name]
  (local capabilities (vim.lsp.protocol.make_client_capabilities))
  (tset capabilities.textDocument.completion.completionItem :snippetSupport
        true)
  (tset capabilities.textDocument.completion.completionItem :resolveSupport
        {:properties [:documentation :detail :additionalTextEdits]})
  (local new_capabilities (cmp_nvim_lsp.update_capabilities capabilities))
  (local opts
         {: on_attach
          :capabilities new_capabilities
          :handlers {:textDocument/publishDiagnostics (vim.lsp.with vim.lsp.diagnostic.on_publish_diagnostics
                                                                    {:virtual_text false})}})
  (when (= client-name :sumneko_lua)
    (tset opts :settings {:Lua {:diagnostics {:globals [:vim]}}}))
  opts)

(null_ls.setup {: on_attach
                :save_after_format false
                :sources [null_ls.builtins.formatting.fnlfmt
                          null_ls.builtins.diagnostics.rubocop
                          null_ls.builtins.formatting.rubocop
                          null_ls.builtins.formatting.erb_lint
                          null_ls.builtins.diagnostics.erb_lint]})

(each [_ lsp (ipairs (lsp_servers.get_installed_server_names))]
  (let [lsp-server (. lspconfig lsp)]
    (lsp-server.setup (make-config lsp))))
