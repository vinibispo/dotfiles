(local dap (require :dap))
(local dap_utils (require :dap.utils))
(fn set-configurations []
  (tset dap.configurations :ruby
        [{:type :ruby
          :request :launch
          :name :Rails
          :program :bundle
          :programArgs [:exec :rails :s]
          :useBundler true}])
  (tset dap.configurations :javascript
        [{:name :Launch
          :type :node2
          :request :launch
          :program "${file}"
          :cwd (vim.fn.getcwd)
          :sourceMaps true
          :protocol :inspector
          :console :integratedTerminal}
         {:name "Attach to process"
          :type :node2
          :request :attach
          :processId dap_utils.pick_process}]))

(fn set-adapters []
  (set dap.adapters.ruby
       {:type :executable :command :bundle :args [:exec :readapt :stdio]})
  (set dap.adapters.node2
       {:type :executable
        :command :node
        :args [(.. (os.getenv :HOME) :/vscode-node-debug2/out/src/nodeDebug.js)]}))

(fn set-mappings []
  (local opts {:noremap true})
  (local mappings [[:<A-c> #(dap.continue)]
                   [:<A-u> #(dap.step_out)]
                   [:<A-o> #(dap.step_over)]
                   [:<A-i> #(dap.step_into)]])
  (each [_ [key function] (pairs mappings)]
    (vim.keymap.set [:n :v :x :i] key function opts)))

(set-configurations)
(set-adapters)
(set-mappings)
