require("core.options")
require("core.keymaps")
require("plugins")

-------------------------------------------------------
-- Filtro para silenciar advertencias deprecadas
local original_notify = vim.notify
vim.notify = function(msg, level, ...)
  if msg:match("deprecated") or level == vim.log.levels.WARN then
    return
  end
  return original_notify(msg, level, ...)
end


---------------------------------------------------------Python Plugins
--------Relacionado al plugin LPS
-- Mostrar diagnósticos en tiempo real
vim.diagnostic.config({
  virtual_text = true,  -- texto inline
  signs = true,         -- íconos en el margen
  underline = true,     -- subrayar errores
  update_in_insert = true, --Hacerlo en Tiempo real
})

--------------------------------------------

-- Opcional: ventana flotante al pasar el cursor
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})

---------------------------------------------

