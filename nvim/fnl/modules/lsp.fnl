(local saga_provider (require :lspsaga.provider))
(local saga_code_action (require :lspsaga.codeaction))
(local saga_action (require :lspsaga.action))
(local saga_rename (require :lspsaga.rename))
(local saga_signature_help (require :lspsaga.signaturehelp))
(local saga_hover (require :lspsaga.hover))
(local installer (require :nvim-lsp-installer))
(local cmp_nvim_lsp (require :cmp_nvim_lsp))
(local lsp (require :lspconfig))
(local saga (require :lspsaga))
(saga.init_lsp_saga {:error_sign "✗"
                     :warn_sign "⚠"
                     :code_action_prompt {:enable false}})

(fn on_attach [client buffnr]
  (local opts {:silent true :noremap true :buffer buffnr})
  (local mappings
         [[:n :gd "<Cmd>lua vim.lsp.buf.definition()<CR>" opts]
          [:n :gD #(saga_provider.preview_definition) opts]
          [:n :gr #(saga_rename.ranger_code_action) opts]
          [:n :gh #(saga_provider.lsp_finder) opts]
          [[:n :v] :<leader>ca #(saga_code_action.range_code_action) opts]
          [:n :<C-a> #(saga_action.smart_scroll_with_saga 1) opts]
          [:n :<C-b> #(saga_action.smart_scroll_with_saga -1) opts]
          [:n :gs #(saga_signature_help.signature_help) opts]
          [:n :<leader>Z #(saga_hover.render_hover_doc) opts]])
  (each [key val (pairs mappings)]
    (let [[first second third fourth] val]
      (vim.keymap.set first second third fourth)))
  (if client.resolved_capabilities.document_formatting
      (vim.keymap.set :n :<leader>F "<cmd>lua vim.lsp.buf.formatting()<CR>"
                      opts)
      client.resolved_capabilities.document_range_formatting
      (vim.keymap.set :n :<leader>F
                      "<cmd>lua vim.lsp.buf.ranger_formattng()<CR>" opts))
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

(fn make_config []
  (local capabilities (vim.lsp.protocol.make_client_capabilities))
  (tset capabilities.textDocument.completion.completionItem :snippetSupport
        true)
  (tset capabilities.textDocument.completion.completionItem :resolveSupport
        {:properties [:documentation :detail :additionalTextEdits]})
  (local new_capabilities (cmp_nvim_lsp.update_capabilities capabilities))
  {: on_attach
   :capabilities new_capabilities
   :settings {:Lua {:diagnostics {:globals [:vim]}}}
   :handlers {:textDocument/publishDiagnostics (vim.lsp.with vim.lsp.diagnostic.on_publish_diagnostics
                                                             {:virtual_text false})}})

(fn get_installed_servers []
  (local servers [])
  (each [_ server (pairs (installer.get_installed_servers))]
    (table.insert servers server.name))
  servers)

(fn install_servers []
  (local installed_servers (get_installed_servers))
  (local required_servers [:bashls
                           :cssls
                           :dockerls
                           :graphql
                           :html
                           :jsonls
                           :sumneko_lua
                           :eslint
                           :pylsp
                           :solargraph
                           :tsserver
                           :yamlls
                           :jdtls])
  (each [_ server (pairs required_servers)]
    (when (not (vim.tbl_contains installed_servers server))
      ((installer.install server)))))

(install_servers)
(installer.on_server_ready (fn [server]
                             (server:setup (make_config))
                             (vim.cmd "do User LspAttachBuffers")))
