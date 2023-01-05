local function config()
  local neotest = require("neotest")
  local function set_mappings()
    local opts = { noremap = true, silent = true }
    local mappings = {
      {
        "n",
        "<leader>tr",
        function()
          neotest.run.run()
        end,
        opts,
      }, -- call test for function in cursor
      {
        "n",
        "<leader>tt",
        function()
          neotest.run.run(vim.fn.expand("%"))
        end,
        opts,
      }, -- call test for current file
      {
        "n",
        "<leader>ts",
        function()
          neotest.summary.toggle()
        end,
        opts,
      },
    }

    for _, m in pairs(mappings) do
      vim.keymap.set(unpack(m))
    end
  end

  local function setup()
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
  end

  set_mappings()
  setup()
end
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "olimorris/neotest-rspec",
      "nvim-neotest/neotest-plenary",
      "jfpedroza/neotest-elixir",
    },
    config = config,
  }, -- Testing inside neovim
}
