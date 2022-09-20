require("nvim-test").setup{
  termOpts = {
	direction = "horizontal",   -- terminal's direction ("horizontal"|"vertical"|"float")
	height = 20,              -- terminal's height (for horizontal|float)
	go_back = false,          -- return focus to original window after executing
	stopinsert = "auto",      -- exit from insert mode (true|false|"auto")
	keep_one = true,          -- keep only one terminal for testing
  },
}

vim.keymap.set('n', '<space>tn', ':TestNearest<CR>')
