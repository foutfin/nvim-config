-- Make Sure Lazy Package Manager is installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-------------------------------------------------


-- Plugins Install 
require("lazy").setup({
    "nvim-tree/nvim-web-devicons", -- WebDev Icons
    {
        "bluz71/vim-moonfly-colors", -- ColorScheme
        config = function()
            vim.g.moonflyTransparent = true
            vim.cmd.colorscheme("moonfly")
        end
    },
    {
       "terrortylor/nvim-comment" ,
       config = function()
           require('nvim_comment').setup({
                comment_empty = false
           })
       end
    },
    {
        "stevearc/dressing.nvim", -- UI changes ,elements
        config = function()
            require("dressing").setup({
                input = {
                    enable = true
                }
            })
        end
    },
    {
        "hrsh7th/nvim-cmp"
    },
    {
        'b0o/incline.nvim', -- StatusLine 
        config = function()
            local helpers = require('incline.helpers')
            local devicons = require('nvim-web-devicons')
            require('incline').setup {
                window = {
                    padding = 0,
                    margin = { horizontal = 0 },
                },
                render = function(props)
                    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
                    if filename == '' then
                        filename = '[No Name]'
                    end
                    local ft_icon, ft_color = devicons.get_icon_color(filename)
                    local modified = vim.bo[props.buf].modified
                    return {
                        ft_icon and { ' ', ft_icon, ' ', guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or '',
                        ' ',
                        { filename, gui = modified and 'bold,italic' or 'bold' },
                        ' ',
                        guibg = '#fff',
                    }
                end,
            }
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",  -- Nvim-Tree 
        config = function()
            require("nvim-treesitter.install").prefer_git = true
            require('nvim-treesitter.configs').setup({
                ensure_installed = { "c","cpp", "css","go","html","java","javascript","json","json5","nix","python","rust","scss","sql","toml","yuck","tsx", "bash","lua", "vim", "vimdoc", "query" },
                highlight = {
                    enable = true
                }
            })
        end
    },
    {
       "neovim/nvim-lspconfig", -- Langauge Server Protocol(LSP)
       config = function()
           local lsp = require("lspconfig")

           lsp.clangd.setup({}) -- c,c++
           lsp.gopls.setup({}) -- golang
           lsp.jdtls.setup({}) -- java
           lsp.biome.setup({}) -- web 
           lsp.tsserver.setup({}) -- typescript , javascript
           lsp.pyright.setup({}) -- python
           lsp.rust_analyzer.setup({}) -- rust
           lsp.lua_ls.setup({}) -- lua

       end
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
            vim.keymap.set('n' , '<leader>ld' , builtin.diagnostics ,{})
        end
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        config = function()
            vim.keymap.set("n", "<leader>fb", ":Telescope file_browser<CR>")
        end
    }





})
--------------------------------------------------------------------------
