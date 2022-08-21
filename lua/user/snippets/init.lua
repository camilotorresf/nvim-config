local typescript_snippets = require "user.snippets.typescript_snippets"

local ls = require("luasnip")

ls.add_snippets("typescript", typescript_snippets.snippets)
