local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local M = {}

M.snippets = {
  s({
    trig = "log",
    name = "ts-console-log",
    description = "TypeScript log trace for debugging",
  }, {
    t("console.log('"),
    i(1),
    t("') // TODO camilo: remove this"),
    i(0),
  })
}

return M
