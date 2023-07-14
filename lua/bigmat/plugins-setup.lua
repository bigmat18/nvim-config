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
    use("bluz71/vim-nightfly-guicolors")
    use({
        "rose-pine/neovim",
        as = "rose-pine"
    })
    use("joshdick/onedark.vim")

    -- lua functions that many plugins use
    use("nvim-lua/plenary.nvim")

    -- Popup API from vim in neovim
    use("nvim-lua/popup.nvim")
    use("nvim-telescope/telescope.nvim")

    -- use("xiyaowong/transparent.nvim")

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
    use("petertriho/nvim-scrollbar") -- implementation of vs-code scrollbar
    use("lukas-reineke/indent-blankline.nvim") -- indentation line and space dots

    -- statusline
    use("nvim-lualine/lualine.nvim")

    -- indentation line and space dots
    use("lukas-reineke/indent-blankline.nvim")

    use('VonHeikemen/lsp-zero.nvim')

    -- completion
    use('hrsh7th/nvim-cmp')
    use('hrsh7th/cmp-nvim-lsp')
    use('L3MON4D3/LuaSnip')
    use('saadparwaiz1/cmp_luasnip')
    use("rafamadriz/friendly-snippets")
    use("github/copilot.vim")
    use("williamboman/mason.nvim")
    use("neovim/nvim-lspconfig")
    use("williamboman/mason-lspconfig.nvim")
    use("glepnir/lspsaga.nvim")

    use("p00f/clangd_extensions.nvim")

    -- formatting & linting
    use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
    use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls


    if packer_bootstrap then
        require("packer").sync()
    end
end)
