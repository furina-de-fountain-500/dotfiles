print("advent of neovim,TJ DeVries")

require("config.lazy")

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.cmd([[
      hi Normal guibg=NONE ctermbg=NONE
      hi NormalNC guibg=NONE ctermbg=NONE
      hi NormalFloat guibg=NONE ctermbg=NONE
      hi FloatBorder guibg=NONE ctermbg=NONE
      hi Pmenu guibg=NONE
    ]])
  end,
})


---### key map for compile and run a program

vim.keymap.set("n", "<leader>r", function()
  local filename = vim.fn.expand("%:t")         -- just the filename (e.g. main.cpp)
  local filepath = vim.fn.expand("%:p")         -- full path to file
  local outname = filename:gsub("%.cpp$", ".out")
  local compile_cmd = string.format("g++ -g %s -o %s", filepath, outname)
  local run_cmd = string.format("./%s", outname)

  -- Construct final tmux command
  local tmux_cmd = string.format(
    [[tmux split-window -v 'echo -e "\033[1;34mCompiling: %s\033[0m" && %s && echo -e "\n\033[1;32mRunning: %s\033[0m" && %s; echo ""; read -n 1 -s -r -p "Press any key to close..."']],
    filepath, compile_cmd, run_cmd, run_cmd
  )

  -- Run the tmux command from Neovim
  vim.fn.system(tmux_cmd)
end, { desc = "Compile and run current C++ file in tmux split" })


--###
--vim.keymap.set("n", "<space>x", ":.lua<CR>")
--vim.keymap.set("v", "<space>x", ":lua<CR>")
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
--
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})


 

--enable line numbers
vim.opt.number = true

--enable relative line numbers
vim.opt.relativenumber = true


