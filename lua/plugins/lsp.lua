-- carica lsp-zero per una configurazione semplificata
local lsp_zero = require('lsp-zero')

-- Funzione per allegare i client LSP
lsp_zero.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    -- Mappature di comandi per LSP
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)  -- Hover con descrizione
    vim.keymap.set("n", "<leader>ws", function() vim.lsp.buf.workspace_symbol() end, opts)  -- Ricerca simboli nel workspace
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)  -- Mostra diagnostica LSP
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)  -- Vai al prossimo errore
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)  -- Vai all'errore precedente
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)  -- Azioni sul codice
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)  -- Riferimenti
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)  -- Rinomina simbolo
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)  -- Aiuto per la firma

    -- Comandi aggiuntivi per la navigazione tra le implementazioni
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 's', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
end)

-- Inizializza Mason e configura LSP con i server necessari
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "clangd", "cmake", "lua_ls" },
})

require("lspconfig").clangd.setup({
    on_attach = function(client, bufnr)
        lsp_zero.on_attach(client, bufnr)
        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            underline = true,
            update_in_insert = false,
        })
    end,
})

require("lspconfig").lua_ls.setup({
    on_attach = lsp_zero.on_attach,
    capabilities = lsp_zero.capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})

require("lspconfig").cmake.setup({
    on_attach = lsp_zero.on_attach,
    capabilities = lsp_zero.capabilities,
    init_options = {
        buildDirectory = "./build",
    },
})

-- Setup di nvim-cmp per autocompletamento
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'buffer', keyword_length = 3 },
        { name = 'luasnip', keyword_length = 2 },
    },
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = false }),  -- Conferma la selezione
        ['<C-Space>'] = cmp.mapping.complete(),  -- Completa automaticamente
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),  -- Avanza nello snippet
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),  -- Torna indietro nello snippet
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),  -- Scorri su la documentazione
        ['<C-d>'] = cmp.mapping.scroll_docs(4),  -- Scorri giù la documentazione
    }),
})

-- Abilita i suggerimenti per il completamento con LuaSnip
require('luasnip.loaders.from_vscode').lazy_load()