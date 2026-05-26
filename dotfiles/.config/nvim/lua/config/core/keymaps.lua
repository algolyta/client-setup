local keymap = vim.keymap.set

keymap("n", "<leader>w", ":w<CR>")
keymap("n", "<leader>q", ":q<CR>")

keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-l>", "<C-w>l")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")

keymap("n", "<leader>e", ":Neotree toggle<CR>")

keymap("n", "<leader>ff", ":FzfLua files<CR>")
keymap("n", "<leader>fg", ":FzfLua live_grep<CR>")
keymap("n", "<leader>fb", ":FzfLua buffers<CR>")
