local map = vim.keymap.set

map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>sh", "<C-w>h", { desc = "Split window horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
map("n", "<leader>sw", "<cmd>close<CR>", { desc = "Close current split" })

map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
map("n", "<leader>tw", "<cmd>tabclose<CR>", { desc = "Close current tab" })
map("n", "<leader>tl", "<cmd>tabn<CR>", { desc = "Go to next tab" })
map("n", "<leader>th", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
map("n", "<leader>td", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

map("n", "J", "mzJ`z", { desc = "Join lines" })
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })
map("n", "<C-o>", "<C-o>zz", { desc = "Jump back" })
map("n", "<C-i>", "<C-i>zz", { desc = "Jump forward" })
map("n", "<C-t>", "<C-t>zz", { desc = "Jump back tag" })
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "<leader>y", [["+y"]])
map("n", "<leader>Y", [["+Y"]])
map({ "n", "v" }, "<leader>d", [["_d"]])

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected up" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected down" })

map("x", "<leader>p", [["_dp"]])

map("n", "<leader>x", vim.diagnostic.open_float, { desc = "Open diagnostics" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
