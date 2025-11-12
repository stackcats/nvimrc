local colors = {
  bg = "#161617",
  fg = "#c9c7cd",
  yellow = "#ECBE7B",
  cyan = "#008080",
  darkblue = "#081633",
  green = "#98be65",
  orange = "#FF8800",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67",
  bg_dark = "#131314",
  white = "#c9c7cd",
  gray0 = "#18181a",
  gray1 = "#1b1b1c",
  gray2 = "#2a2a2c",
  tiffany_green = "#74F0B6",
}

local theme = {
  normal = {
    a = { fg = colors.bg_dark, bg = colors.blue },
    b = { fg = colors.blue, bg = colors.white },
    c = { fg = colors.white, bg = colors.bg_dark },
    z = { fg = colors.white, bg = colors.bg_dark },
  },
  insert = { a = { fg = colors.bg_dark, bg = colors.bg_dark } },
  visual = { a = { fg = colors.bg_dark, bg = colors.green } },
  replace = { a = { fg = colors.bg_dark, bg = colors.green } },
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local modes = {
  "mode",
  color = function()
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [""] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [""] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ["r?"] = colors.cyan,
      ["!"] = colors.red,
      t = colors.red,
    }
    return { bg = mode_color[vim.fn.mode()], fg = colors.bg_dark, gui = "bold" }
  end,
  separator = { left = "", right = "" },
}

local space = {
  function()
    return " "
  end,
  color = { bg = colors.bg_dark, fg = colors.blue },
}

local filename = {
  "filename",
  cond = conditions.buffer_not_empty,
  color = { bg = colors.blue, fg = colors.bg, gui = "bold" },
  separator = { left = "", right = "" },
}

local branch = {
  "branch",
  icon = "",
  color = { bg = colors.white, fg = colors.bg, gui = "bold" },
  separator = { left = "", right = "" },
}

local location = {
  "location",
  color = { bg = colors.bg, fg = colors.white, gui = "bold" },
}

local diff = {
  "diff",
  color = { bg = colors.bg_dark, fg = colors.bg, gui = "bold" },
  symbols = { added = " ", modified = " ", removed = " " },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.yellow },
    removed = { fg = colors.red },
  },
}

local dia = {
  "diagnostics",
  symbols = { error = " ", warn = " ", info = " ", hint = " " },
  diagnostics_color = {
    error = { fg = colors.red },
    warn = { fg = colors.yellow },
    info = { fg = colors.purple },
    hint = { fg = colors.cyan },
  },
  color = { bg = colors.bg_dark, fg = colors.bg, gui = "bold" },
}

local get_lsp_name = function()
  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  local clients = vim.lsp.get_clients()
  if next(clients) == nil then
    return "No Active Lsp"
  end
  local lst = {}
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if not filetypes or vim.fn.index(filetypes, buf_ft) ~= -1 then
      table.insert(lst, client.name)
    end
  end

  local lint_s, lint = pcall(require, "lint")
  if lint_s then
    for ft_k, ft_v in pairs(lint.linters_by_ft) do
      if type(ft_v) == "table" then
        for _, linter in ipairs(ft_v) do
          if buf_ft == ft_k then
            table.insert(lst, linter)
          end
        end
      elseif type(ft_v) == "string" then
        if buf_ft == ft_k then
          table.insert(lst, ft_v)
        end
      end
    end
  end

  local ok, conform = pcall(require, "conform")
  if ok then
    local formatters = table.concat(conform.list_formatters_for_buffer(), " ")
    for formatter in formatters:gmatch("%w+") do
      if formatter then
        table.insert(lst, formatter)
      end
    end
  end

  return "  " .. table.concat(lst, " ")
end

local lsp = {
  function()
    return get_lsp_name()
  end,
  separator = { left = "", right = "" },
  color = { bg = colors.tiffany_green, fg = colors.bg, gui = "italic,bold" },
}

local bar = {
  function()
    return "▊"
  end,
  color = { fg = colors.blue },
  padding = { left = 1, right = 0 },
}

local flutter = {
  function()
    local decorations = vim.g.flutter_tools_decorations or {}
    return decorations.app_version or ""
  end,
  cond = function()
    return vim.bo.filetype == "dart"
  end,
  color = { fg = colors.violet, gui = "bold" },
}

return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = theme,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          modes,
        },
        lualine_b = {
          space,
        },
        lualine_c = {
          filename,
          space,
          branch,
        },
        lualine_x = {
          diff,
        },
        lualine_y = { space },
        lualine_z = { dia, lsp, flutter },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    })
    vim.o.laststatus = vim.g.lualine_laststatus
  end,
}
