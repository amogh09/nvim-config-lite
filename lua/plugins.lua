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
end)
