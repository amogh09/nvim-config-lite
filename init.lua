-- Settings
vim.opt.number = true
vim.opt.encoding = "utf-8"
vim.opt.tabstop=4
vim.opt.shiftwidth=4

-- Newline in normal mode
vim.keymap.set('n', '<Leader>o', 'o<Esc>')
vim.keymap.set('n', '<Leader>O', 'O<Esc>')

vim.keymap.set('n', '<leader>q', ':bp<bar>sp<bar>bn<bar>bd!<CR>') -- Wipe buffer without closing window

-- Move around windows
vim.keymap.set('n', '<M-l>', '<c-w>l')
vim.keymap.set('n', '<M-k>', '<c-w>k')
vim.keymap.set('n', '<M-j>', '<c-w>j')
vim.keymap.set('n', '<M-h>', '<c-w>h')

vim.keymap.set('n', '<C-p>', ':<C-u>FZF<CR>') -- CTRL-p to trigger fzf
vim.keymap.set('n', 'cq', ':cclose<cr>', { noremap = true }) -- Close quickfix list

vim.keymap.set('t', '<leader><c-r>', '<c-\\><c-n>pa') -- Paste in terminal mode

-- Move around windows in terminal mode
vim.keymap.set('t', '<M-l>', '<c-\\><c-n><c-w>l')
vim.keymap.set('t', '<M-k>', '<c-\\><c-n><c-w>k')
vim.keymap.set('t', '<M-j>', '<c-\\><c-n><c-w>j')
vim.keymap.set('t', '<M-h>', '<c-\\><c-n><c-w>h')

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>') -- Esc to get out of terminal mode

-- Mute search highlighting
vim.keymap.set('n', '<C-l>', ':<C-u>nohlsearch<CR><C-l>')

vim.cmd([[
" Set nvim as preferred editor for Git
if has('nvim') && executable('nvr')
	let $VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif

" Colorscheme
colorscheme PaperColor

" Prevent nesting of neovim instances
if has('nvim') && executable('nvr')
  let $VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif
]])

-- 'q' to quit quickfix
vim.api.nvim_create_autocmd(
	"FileType",
	{ pattern = { "qf" }, command = [[nnoremap <buffer><silent> q :close<CR>]] }
)

-- Check if file exists
function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- get all lines from a file, returns an empty
-- list/table if the file does not exist
function lines_from(file)
  if not file_exists(file) then return {} end
  local lines = {}
  for line in io.lines(file) do
    lines[#lines + 1] = line
  end
  return lines
end

-- Add Go header
function add_go_header (t)
	file = [[/home/amoghr/.config/nvim/headers/header.go]]
	local lines = lines_from(file)
	vim.api.nvim_buf_set_lines(t.buf, 0, 1, false, lines)
end

vim.api.nvim_create_autocmd("BufNewFile", {
	pattern = "*.go",
	callback = add_go_header,
})

-- Setup plugins
require('plugins') -- packer
require('lsp') -- Setup LSP
