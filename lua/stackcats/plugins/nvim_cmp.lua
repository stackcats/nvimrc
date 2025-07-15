return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    {
      "hrsh7th/cmp-vsnip",
      dependencies = {
        "hrsh7th/vim-vsnip",
        "rafamadriz/friendly-snippets",
      },
    },
  },
  config = function()
    local cmp = require("cmp")

    local function is_cursor_at_beginning_of_line()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local function feedkeys(key, mode)
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
    end

    -- Configure the completion window
    local cmp_window = cmp.config.window.bordered({
      border = "single",
      winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:IncSearch",
    })

    cmp.setup({
      snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
        end,
      },
      completion = {
        autocomplete = { cmp.TriggerEvent.TextChanged },
        keyword_length = 3,
      },
      window = {
        completion = cmp_window,
        documentation = cmp_window,
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "vsnip" },
        {
          name = "buffer",
          option = {
            get_bufnrs = function()
              local bufs = {}
              for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_get_option(bufnr, "buftype") ~= "terminal" then
                  table.insert(bufs, bufnr)
                end
              end
              return bufs
            end,
          },
        },
        { name = "nvim_lua" },
        { name = "codeium" },
        { name = "crates" },
      },
      mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<TAB>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif vim.fn["vsnip#available"](1) == 1 then
            feedkeys("<Plug>(vsnip-expand-or-jump)", "")
          elseif is_cursor_at_beginning_of_line() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-TAB>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.fn["vsnip#jumpable"](-1) == 1 then
            feedkeys("<Plug>(vsnip-jump-prev)", "")
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-g>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
      },
    })

    cmp.setup.filetype("oil", {
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "buffer" },
      }),
    })

    cmp.setup.filetype("toggleterm", {
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "buffer" },
      }),
    })
  end,
}
