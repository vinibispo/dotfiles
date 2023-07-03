return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "olimorris/neotest-rspec",
      "nvim-neotest/neotest-plenary",
      "jfpedroza/neotest-elixir",
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
    },
    keys = {
      {
        "<leader>tn",
        function()
          require("neotest").run.run()
        end,
        
        silent = true,
        desc = "Neo[T]est Run [N]earest",
      },
      {
        "<leader>tf",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        
        silent = true,
        desc = "Neo[T]est Run [F]ile ",
      },
      {
        "<leader>tst",
        function()
          require("neotest").summary.toggle()
        end,
        
        silent = true,
        desc = "Neo[T]est [S]ummary [T]oggle",
      },
    },
    config = function()
      local neotest = require("neotest")
      neotest.setup({
        adapters = {
          require("neotest-rspec"),
          require("neotest-plenary"),
          require("neotest-elixir"),
        },
        consumers = {
          always_open_output = function(client)
            local async = require("neotest.async")
            client.listeners.results = function(adapter_id, results)
              local file_path = async.fn.expand("%:p")
              local row = async.fn.getpos(".")[2] - 1
              local position = client:get_nearest(file_path, row, {})
              if not position then
                return
              end
              local pos_id = position:data().id
              if not results[pos_id] then
                return
              end
              neotest.output.open({ position_id = pos_id, adapter = adapter_id })
            end
          end,
        },
      })
    end,
  }, -- Testing inside neovim
}
