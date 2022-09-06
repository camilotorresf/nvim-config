local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local sn = ls.snippet_node

local M = {}

local function get_line_number(args, parent)
  local position = vim.api.nvim_win_get_cursor(0)
  return tostring(position[1])
end

local function get_function_name(args, parent)
  local file_path = vim.api.nvim_buf_get_name(0)
  local file_name = file_path:match("^.+/(.+).tsx?$")
  return file_name
end

M.snippets = {
  s(
    {
      trig = "clog",
      name = "ts-console-log",
      description = "TypeScript log trace for debugging",
    },
    {
      t("console.log('** "),
      f(get_function_name),
      t(":"),
      f(get_line_number),
      t("', "),
      c(1,
        {
          fmt("'{comment}'", { comment = i(1) }),
          fmt("typeof({variable_name_type}), {variable_name}",
            {
              variable_name_type = i(1),
              variable_name = rep(1),
            }
          )
        }
      ),
      t(") // TODO camilo: remove this"),
    }
  ),
  s(
    {
      trig = "ctd",
      name = "ts-todo",
      description = "Adds a TODO comment for Camilo",
    }, {
      t("// TODO camilo: "),
      i(0),
    }
  ),
}

return M
