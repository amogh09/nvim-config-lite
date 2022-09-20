return require('packer').startup(function(use)
  use 'tpope/vim-unimpaired'
  use 'junegunn/fzf'
  use 'tpope/vim-dispatch'
  use 'vim-airline/vim-airline'
  use 'NLKNguyen/papercolor-theme'
  use 'tpope/vim-eunuch'
  use 'preservim/nerdtree'
  use 'morhetz/gruvbox'
  use 'tomasr/molokai'
  use 'tpope/vim-commentary'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use 'tmsvg/pear-tree' -- Automatic pairing of brackets and quotes
  use { 'simrat39/symbols-outline.nvim', commit = '15ae99c27360ab42e931be127d130611375307d5' } -- Symbol tree
  use 'tpope/vim-fugitive' -- Git Plugin
  use 'airblade/vim-gitgutter' -- Git Plugin for showing diffs in buffer
  use 'tpope/vim-surround' -- Makes working with quotes, brackets etc, easier
  use 'folke/tokyonight.nvim' -- Color scheme
  use 'mfussenegger/nvim-jdtls' -- Some extensions for Java LSP

  -- treesitter for better syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }

  use 'ryanoasis/vim-devicons' -- Pretty icons for NERDTree etc.
  use 'editorconfig/editorconfig-vim' -- Editorconfig plugin
  use 'tpope/vim-obsession' -- Plugin to manage vim sessions
  use 'klen/nvim-test' -- For executing tests
end)
