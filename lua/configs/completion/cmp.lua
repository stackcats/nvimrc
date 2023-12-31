-- Require necessary modules
local cmp = require("cmp")
local nvim_autopairs = require("nvim-autopairs.completion.cmp")

-- Define helper functions
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

-- Setup the completion engine
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
                    return vim.api.nvim_list_bufs()
                end,
            },
        },
        { name = "nvim_lua" },
        { name = "codeium" },
        { name = "crates" },
    },
    mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
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

-- Register confirmation event for autopairs
cmp.event:on("confirm_done", nvim_autopairs.on_confirm_done())
