-- auto install packer if not installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
    return
end

return packer.startup(function(use)

    -- packer can manage itself
    use("wbthomason/packer.nvim")

    -- preferred colorscheme
    use("joshdick/onedark.vim")
    use("ellisonleao/gruvbox.nvim")
    use("xiyaowong/transparent.nvim")

    -- lua functions that many plugins use
    use("nvim-lua/plenary.nvim")

    -- Popup API from vim in neovim
    use("nvim-lua/popup.nvim")
    use("nvim-telescope/telescope.nvim")

    -- treesitter configuration
    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require("nvim-treesitter.install").update({
                with_sync = true
            })
            ts_update()
        end
    })
    use("petertriho/nvim-scrollbar") -- implementation of vs-code scrollbar with {, }
    use("lukas-reineke/indent-blankline.nvim") -- indentation line and space dots

    -- statusline
    use("nvim-lualine/lualine.nvim")

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    }

    -- completion
    use("glepnir/lspsaga.nvim")

    -- formatting & linting
    use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
    use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

    use("windwp/nvim-autopairs")
    
    use("theprimeagen/harpoon")

    use("mbbill/undotree")

    use("tpope/vim-fugitive")
    
    -- use('airblade/vim-gitgutter')

    use('mhinz/vim-signify')

    use("christoomey/vim-tmux-navigator")

    use("nvim-tree/nvim-tree.lua")

    use({"folke/todo-comments.nvim",
         dependencies = { "nvim-lua/plenary.nvim" },
         opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    })

    use("xiyaowong/transparent.nvim")
 
    -- vs-code like icons
    use("nvim-tree/nvim-web-devicons")
    if packer_bootstrap then
        require("packer").sync()
    end
end)
