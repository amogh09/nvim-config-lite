-- Settings
vim.opt.number = true
vim.opt.encoding = "utf-8"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.colorcolumn = "100"                -- Marker at 100 col width
vim.opt.updatetime = 200                   -- Decrease update time to make vim gutter update faster
vim.opt.foldenable = false                 -- Don't fold by default

vim.opt.spell = false                      -- Enable built-in spell-checker
vim.cmd [[au TermOpen * setlocal nospell]] -- Disable spell-checker in terminal mode

-- Newline in normal mode
vim.keymap.set('n', '<leader>o', 'o<Esc>')
vim.keymap.set('n', '<leader>O', 'O<Esc>')

vim.keymap.set('n', '<leader>q', ':bp<bar>sp<bar>bn<bar>bd!<CR>') -- Wipe buffer without closing window

-- Move around windows
vim.keymap.set('n', '<M-l>', '<c-w>l')
vim.keymap.set('n', '<M-k>', '<c-w>k')
vim.keymap.set('n', '<M-j>', '<c-w>j')
vim.keymap.set('n', '<M-h>', '<c-w>h')

-- Telescope setup
local success, telescope = pcall(require, "telescope.builtin")
if success then
  vim.keymap.set('n', '<space>p', telescope.find_files, {})
  vim.keymap.set('n', '<space>g', telescope.live_grep, {})
  vim.keymap.set('n', '<space>b', telescope.buffers, {})
  vim.keymap.set('n', '<space>h', telescope.help_tags, {})
  vim.keymap.set('n', '<space>s', telescope.lsp_dynamic_workspace_symbols, {})
  vim.keymap.set('n', '<space>y', telescope.lsp_document_symbols, {})
  vim.keymap.set('n', '<space>ic', telescope.lsp_incoming_calls, {})
  vim.keymap.set('n', '<space>oc', telescope.lsp_outgoing_calls, {})

  require('telescope').setup {
    defaults = {
      mappings = {
        n = {
          ["<C-b>"] = "delete_buffer"
        }
      },
    },
  }
end

vim.keymap.set('n', 'cq', ':cclose<cr>', { noremap = true }) -- Close quickfix list

vim.keymap.set('t', '<c-\\><c-r>', '<c-\\><c-n>pa')          -- Paste in terminal mode

-- Move around windows in terminal mode
vim.keymap.set('t', '<M-l>', '<c-\\><c-n><c-w>l')
vim.keymap.set('t', '<M-k>', '<c-\\><c-n><c-w>k')
vim.keymap.set('t', '<M-j>', '<c-\\><c-n><c-w>j')
vim.keymap.set('t', '<M-h>', '<c-\\><c-n><c-w>h')

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>') -- Esc to get out of terminal mode

-- Working with tabs
vim.keymap.set('n', '<M-]>', ':tabnext<CR>')
vim.keymap.set('n', '<M-[>', ':tabprevious<CR>')
vim.keymap.set('t', '<M-]>', '<c-\\><c-n>:tabnext<CR>')
vim.keymap.set('t', '<M-[>', '<c-\\><c-n>:tabprevious<CR>')

-- Mute search highlighting
vim.keymap.set('n', '<C-l>', ':<C-u>nohlsearch<CR><C-l>')

vim.cmd([[
" Set nvim as preferred editor for Git
if has('nvim') && executable('nvr')
	let $VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif

" Colorscheme
silent! colorscheme tokyonight

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

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.py", "*.lua", "*.zshrc" },
  command = [[ :%s/\s\+$//e ]],
})

-- Check if file exists
local function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- get all lines from a file, returns an empty
-- list/table if the file does not exist
local function lines_from(file)
  if not file_exists(file) then return {} end
  local lines = {}
  for line in io.lines(file) do
    lines[#lines + 1] = line
  end
  return lines
end

-- Add Go header
local function add_go_header(t)
  local home = os.getenv("HOME")
  local file = home .. "/.config/nvim/headers/header.go"
  local lines = lines_from(file)
  vim.api.nvim_buf_set_lines(t.buf, 0, 1, false, lines)
end

vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.go",
  callback = add_go_header,
})

-- Setup plugins
require('plugins') -- packer
require('lsp')     -- Setup LSP

-- Treesitter
require 'nvim-treesitter.configs'.setup {
  ensure_installed = { "go", "lua", "json" },
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- Taboo
vim.cmd([[set sessionoptions+=tabpages,globals]])

-- vim-test
vim.cmd([[let test#strategy = "neovim"]])
vim.keymap.set('n', '<space>t', ':TestNearest<CR>')
vim.keymap.set('n', '<space>T', ':TestFile<CR>')
vim.keymap.set('n', '<space>l', ':TestLast<CR>')

-- Use treesitter for folding
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.wo.foldenable = false

-- nvim-test plugin
require('setup_nvim_test')
