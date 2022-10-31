local typescript_snippets = require "user.snippets.typescript_snippets"
local json_snippets = require "user.snippets.json_snippets"

local ls = require("luasnip")

ls.add_snippets("typescript", typescript_snippets.snippets)
ls.add_snippets("json", json_snippets.snippets)
