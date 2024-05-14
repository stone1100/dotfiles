---@class lin.utils.common
local common = {}

function common.get_lsp_clients()
  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  local clients = vim.lsp.get_active_clients()
  if next(clients) == nil then
    return "No Active Lsp"
  end

  local lsps = {}
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      table.insert(lsps, client.name)
    end
  end
  local lsps_size = table.getn(lsps)
  if lsps_size > 1 then
    return "[" .. table.concat(lsps, ",") .. "]"
  elseif lsps_size == 1 then
    return table.concat(lsps, ",")
  else
    return "No Active Lsp"
  end
end

function common.get_vi_mode_color()
  local colors = {
    bg = "#202328",
    fg = "#bbc2cf",
    yellow = "#ECBE7B",
    cyan = "#008080",
    darkblue = "#081633",
    green = "#98be65",
    orange = "#FF8800",
    violet = "#a9a1e1",
    magenta = "#c678dd",
    blue = "#51afef",
    red = "#ec5f67",
  }
  -- auto change color according to neovims mode
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
  return { fg = mode_color[vim.fn.mode()] }
end

function common.snake_to_camel_case(str)
  return (str
    :gsub("_(%w)", function(letter)
      return letter:upper()
    end)
    :gsub("^%l", string.upper))
end

function common.camel_to_snake_case(str)
  return (str
    :gsub("(%u)", function(letter)
      return "_" .. letter:lower()
    end)
    :gsub("^_", ""))
end

return common
