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

M.snippets = {
  s(
    {
      trig = "awsvd",
      name = "aws-app-variable-dev",
      description = "AWS Dev Environment Variable",
    }, {
      t({
        ",",
        "{",
        '    "name": "',
      }),
      i(1, ""),
      t({
        '",',
        '    "valueFrom": "arn:aws:ssm:us-east-1:096790407971:parameter/',
      }),
      c(2, {t("dev"), t("staging"), t("prod")}),
      t("/"),
      rep(1),
      t({
        '"',
        '}'
      }),
    }
  ),
}

return M

