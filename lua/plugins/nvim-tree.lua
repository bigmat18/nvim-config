-- Configurazione di nvim-tree
require('nvim-tree').setup({
  -- Impostazioni generali
  disable_netrw = true,          -- Disabilita netrw in modo che nvim-tree gestisca i file
  hijack_netrw = true,           -- Evita che netrw apra la vista di file quando si apre una cartella
  open_on_tab = true,           -- Non aprire nvim-tree su ogni nuovo tab
  update_cwd = true,             -- Aggiorna la directory corrente quando si apre una cartella
  respect_buf_cwd = true,        -- Rispetta la directory corrente del buffer
  view = {
    width = 30,                  -- Larghezza della finestra di nvim-tree
    side = 'left',               -- Posiziona nvim-tree a sinistra
  },
  renderer = {
    highlight_git = true,         -- Evidenzia i file sotto il controllo git
    icons = {
      show = {
        file = true,               -- Mostra l'icona dei file
        folder = true,             -- Mostra l'icona delle cartelle
        folder_arrow = true,       -- Mostra la freccia per le cartelle
        git = true,                -- Mostra l'icona per i file git
      },
      glyphs = {
        default = '',            -- Icona predefinita per i file
        symlink = '',            -- Icona per i symlink
        git = {
          unstaged = '✗',         -- Icona per i file non ancora aggiunti al commit
          staged = '✓',            -- Icona per i file già aggiunti al commit
          unmerged = '',         -- Icona per i file non uniti
          renamed = '➜',           -- Icona per i file rinominati
          untracked = '★',         -- Icona per i file non tracciati
          deleted = '',           -- Icona per i file eliminati
          ignored = '◌',           -- Icona per i file ignorati
        },
      },
    },
  },
  update_focused_file = {
    enable = true,               -- Aggiorna il file focalizzato
    update_cwd = true,           -- Cambia la directory di lavoro quando viene selezionato un file
  },
  git = {
    enable = true,
    ignore = false, -- mostra anche file/folder ignorati da git
  },
})
