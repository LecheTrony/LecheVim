local map = vim.keymap.set
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Buscar archivos" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Buscar texto" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Buscar buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Buscar ayuda" })

------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------Modo Insertar
-- Copiar en modo inserción (Ctrl+C copia lo que selecciones con mouse/terminal)
vim.keymap.set("i", "<C-c>", '<Esc>"+yyi', { desc = "Copiar línea en inserción" }) ---Necesita ser solucionado
-- Pegar en modo inserción con Ctrl+V
vim.keymap.set("i", "<C-v>", '<C-r>+', { desc = "Pegar desde portapapeles en inserción" })
-- Deshacer en modo inserción
vim.keymap.set("i", "<C-z>", "<C-o>u", { desc = "Deshacer en inserción" })
-- Rehacer en modo inserción con Ctrl+Shift+Z
vim.keymap.set("i", "<C-S-z>", "<C-o><C-r>", { desc = "Rehacer en inserción" })

-----------------------------------------------------------------------------------------------Modo Visual








-----------------------------------------------------------------------------------------------Opciones leader(Espacio)
-- Define la tecla leader como espacio
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Ejecutar archivo actual con toggleterm
vim.keymap.set("n", "<leader>r", function()
  local file = vim.fn.expand("%")
  require("toggleterm").exec("python3 " .. file, 1, 12, "horizontal")
end, { desc = "Ejecutar archivo actual" })

