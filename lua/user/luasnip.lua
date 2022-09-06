local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end
local types = require("luasnip.util.types")

luasnip.config.set_config {
  -- to jump back to a snippet
  history = true,

  -- update dynamic snippets as you type
  updateevents = "TextChanged,TextChangedI",

  enable_autosnippets = true,
}

