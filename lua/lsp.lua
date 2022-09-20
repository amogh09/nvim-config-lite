-- LSP Setup
local on_attach = require("lsp.onattach")

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Load lspconfig plugin
local lspconfig = require('lspconfig')

-- Setup gopls
lspconfig.gopls.setup {
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		gopls = {
			buildFlags = {"-tags=unit,functional,linux"},
		}
	}
}

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	}),
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	},
}

-- simrat39/symbols-outline.nvim setup
vim.g.symbols_outline = {
	highlight_hovered_item = false,
	auto_preview = false,
	position = 'left',
	width = 10,
}
vim.keymap.set('n', '<space>x', ':SymbolsOutline<cr>', { noremap=true, silent=true, })

-- NERDTree toggle
vim.keymap.set('n', '<space>nt', ':NERDTreeToggle<CR>', { noremap=true, silent=true })
vim.keymap.set('n', '<space>nf', ':NERDTreeFind<CR>', { noremap=true, silent=true })
