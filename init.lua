--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

vim.o.winborder = 'rounded'
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

vim.o.confirm = true

vim.o.tabstop = 2

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<leader>e', '<CMD>Oil<CR>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('i', '<C-space>', '<C-x><C-o>', { desc = 'open completions' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.pack.add {
  { src = 'https://github.com/NMAC427/guess-indent.nvim' }, -- Detect tabstop and shiftwidth automatically
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
  {
    src = 'https://github.com/neovim/nvim-lspconfig',
  },
  { src = 'https://github.com/stevearc/conform.nvim' },
  {
    src = 'https://github.com/scottmckendry/cyberdream.nvim',
  },
  { -- Collection of various small independent plugins/modules
    src = 'https://github.com/echasnovski/mini.nvim',
  },
  {
    src = 'https://github.com/stevearc/oil.nvim',
  },
  {
    src = 'https://github.com/mason-org/mason.nvim',
  },
  {
    src = 'https://github.com/mason-org/mason-lspconfig.nvim',
  },
  { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },
  {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
  },
}

require('mini.completion').setup {}
require('mini.basics').setup {}
require('mini.extra').setup {}
require('mini.git').setup {}
require('mini.pick').setup {}

vim.keymap.set('n', '<leader>f', ':Pick files<CR>')
vim.keymap.set('n', '<leader>/', ':Pick grep_live<CR>')

require('cyberdream').setup {
  transparent = true,
}

require('mason').setup {}
require('mason-tool-installer').setup {
  ensure_installed = { 'gopls', 'eslint_d', 'typescript-language-server' },
}
require('mason-lspconfig').setup {}
vim.lsp.enable { 'stylua', 'lua_ls', 'gopls', 'eslint_d', 'typescript-language-server' }

require('nvim-treesitter.configs').setup {
  ensure_installed = { 'lua', 'javascript', 'typescript', 'go' },
  auto_install = true,
  highlight = {
    enable = true,
  },
}

vim.cmd.colorscheme 'cyberdream'

require('conform').setup {
  formatters_by_ft = {
    lua = { 'stylua' },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = 'fallback',
  },
}

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf, silent = true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    -- Set more keymaps or buffer-local options here
  end,
})

require('oil').setup()
vim.keymap.set('n', '<leader>e', ':Oil<CR>')
