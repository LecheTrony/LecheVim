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








-----------------------------------------------------------------------------------------------Modo Space
