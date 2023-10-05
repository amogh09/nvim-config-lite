-- LSP Setup
local on_attach = require("lsp.onattach")

require 'cmp'.setup {
    sources = {
        { name = 'nvim_lsp' }
    }
}

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Load lspconfig plugin
local lspconfig = require('lspconfig')

-- Setup gopls
lspconfig.gopls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        gopls = {
            buildFlags = { "-tags=unit,integration,functional,linux,e2e,e2e_test" },
        }
    }
}

-- Setup Lua LS
lspconfig.lua_ls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    on_init = function(client)
        local path = client.workspace_folders[1].name
        if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
            client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using
                        -- (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT'
                    },
                    -- Make the server aware of Neovim runtime files
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME
                            -- "${3rd}/luv/library"
                            -- "${3rd}/busted/library",
                        }
                        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                        -- library = vim.api.nvim_get_runtime_file("", true)
                    }
                }
            })

            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        end
        return true
    end
}

-- Setup ruby
require'lspconfig'.solargraph.setup{
	capabilities = capabilities,
	on_attach = on_attach,
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

-- JSON LSP setup
require'lspconfig'.jsonls.setup{
    capabilities = capabilities,
	on_attach = on_attach,
}

-- bash LSP setup
require'lspconfig'.bashls.setup{
    capabilities = capabilities,
	on_attach = on_attach,
}

-- simrat39/symbols-outline.nvim setup
vim.g.symbols_outline = {
    highlight_hovered_item = false,
    auto_preview = false,
    position = 'left',
    width = 10,
}
vim.keymap.set('n', '<space>x', ':SymbolsOutline<cr>', { noremap = true, silent = true, })

-- NERDTree toggle
vim.keymap.set('n', '<space>nt', ':NERDTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<space>nf', ':NERDTreeFind<CR>', { noremap = true, silent = true })
