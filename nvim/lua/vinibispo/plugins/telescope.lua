return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-lua/popup.nvim",
      "nvim-telescope/telescope-dap.nvim",
    },
    priority = 900,
    opts = {

      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        prompt_prefix = "> ",
        selection_caret = "> ",
        entry_prefix = " ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        layout_config = { horizontal = { mirror = false }, vertical = { mirror = false } },
        file_ignore_patterns = {},
        winblend = 0,
        border = {},
        color_devicons = true,
        use_less = true,
        path_display = {},
        preview = {
          mime_hook = function(filepath, bufnr, opts)
            local is_image = function(fpath)
              local image_extensions = { "png", "jpg" } -- Supported image formats
              local split_path = vim.split(fpath:lower(), ".", { plain = true })
              local extension = split_path[#split_path]
              return vim.tbl_contains(image_extensions, extension)
            end
            if is_image(filepath) then
              local term = vim.api.nvim_open_term(bufnr, {})
              local function send_output(_, data, _)
                for _, d in ipairs(data) do
                  vim.api.nvim_chan_send(term, d .. "\r\n")
                end
              end

              vim.fn.jobstart({
                "catimg",
                filepath, -- Terminal image viewer command
              }, { on_stdout = send_output, stdout_buffered = true })
            else
              require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid, "Binary cannot be previewed")
            end
          end,
        },
      },
    },
    keys = {
      {
        "<leader>lg",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Telescope [L]ive [G]rep",
      },
      {
        "<leader>gf",
        function()
          require("telescope.builtin").git_files()
        end,
        desc = "Telescope [G]it [F]iles",
      },
      {
        "<leader>pf",
        function()
          local helpers = require("vinibispo.modules.helpers")
          local builtin = require("telescope.builtin")
          if helpers.is_work() then
            builtin.find_files({})
            return
          end
          local ok = pcall(builtin.git_files, { show_untracked = true })
          if not ok then
            builtin.find_files({})
          end
        end,
        desc = "Telescope [P]roject [F]iles",
      },
      {
        "<leader>G",
        function()
          require("telescope.builtin").git_status()
        end,
        desc = "Telescope [G]it Status",
      },
      {
        "<leader>b",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Telescope [B]uffers",
      },
      {
        "<leader>gb",
        function()
          require("telescope.builtin").git_branches()
        end,
        desc = "Telescope [G]it [B]ranches",
      },
    },
    cmd = "Telescope",
  }, -- Fuzzy Finder
}
