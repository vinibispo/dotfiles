(local dap (require :dap))
(local dap_utils (require :dap.utils))
(set dap.adapters.ruby {:type :executable
                        :command :bundle
                        :args [:exec :readapt :stdio]})

(tset dap.configurations :ruby
      [{:type :ruby
        :request :launch
        :name :Rails
        :program :bundle
        :programArgs [:exec :rails :s]
        :useBundler true}])

(set dap.adapters.node2
     {:type :executable
      :command :node
      :args [(.. (os.getenv :HOME) :/vscode-node-debug2/out/src/nodeDebug.js)]})

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
        :processId dap_utils.pick_process}])
