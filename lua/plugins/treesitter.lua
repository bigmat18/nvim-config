-- Installazione e configurazione di nvim-treesitter
require('nvim-treesitter.configs').setup({
    -- Abilita l'autoinstallazione dei parser
    auto_install = true, -- Installa automaticamente i parser mancanti quando apri i file
    highlight = {
      enable = true,    -- Abilita l'evidenziazione della sintassi con Treesitter
      additional_vim_regex_highlighting = false, -- Disabilita l'evidenziazione di sintassi Vim per migliorare la velocità
    },
    indent = {
      enable = true,    -- Abilita l'indentazione automatica con Treesitter
    },
    rainbow = {
      enable = true,    -- Abilita il supporto per le parentesi arcobaleno
      extended_mode = true, -- Usa colori per le parentesi nidificate
      max_file_lines = 1000, -- Limita la colorazione a file con un numero massimo di righe
    },
    autotag = {
      enable = true,    -- Abilita il completamento automatico dei tag HTML/XML
    },
    context_commentstring = {
      enable = true,    -- Abilita il supporto per commenti contestuali in linguaggi come C, Python, ecc.
    },
    matchup = {
      enable = true,    -- Abilita il supporto per il matching delle parentesi
    },
  })
  
  -- Aggiornamento dei parser alla versione più recente
  require("nvim-treesitter.install").update({ with_sync = true })
  
  -- Configurazione dei parser per i linguaggi che vuoi abilitare
  require('nvim-treesitter.configs').setup({
    ensure_installed = {
      "c", "cpp", "lua", "python", "json", "yaml", "bash", "vim"
    }
})
  