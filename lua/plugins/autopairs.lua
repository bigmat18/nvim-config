-- Carica il plugin nvim-autopairs
require('nvim-autopairs').setup({
    -- Configurazioni generali
    check_ts = true,  -- Verifica la sintassi Tree-sitter per una gestione più precisa delle coppie
    ts_config = {
        lua = {'string', 'source'},  -- Configurazione per Lua, ad esempio stringhe e sorgenti
        javascript = {'string', 'template_string'},  -- Configurazione per JavaScript
        java = false,  -- Disabilita l'autopairs per il linguaggio Java
    },
    fast_wrap = {
        map = '<M-e>',  -- Tasto di mappatura per il wrapping veloce delle parentesi
        chars = {'(', '[', '{', '"', "'", "`"},  -- Caratteri per i quali è possibile fare il wrapping
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),  -- Pattern di matching per i wrap
        end_key = '$',  -- Tasto finale per completare il wrapping
    },
    ignored_next_char = '[%w%.]',  -- Ignora caratteri specifici
})

-- Aggiunge la funzione di completamento automatico per le parentesi e i caratteri speciali
local npairs = require('nvim-autopairs')

-- Mappature aggiuntive (facoltative) per chiudere i caratteri aperti rapidamente
vim.api.nvim_set_keymap("i", "<C-l>", "pumvisible() ? coc#refresh() : '<C-l>'", { noremap = true, silent = true })