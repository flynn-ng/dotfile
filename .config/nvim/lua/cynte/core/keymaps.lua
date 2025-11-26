vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlight" })

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<c-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sw", "<cmd>close<CR>", { desc = "Close current split" })

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tw", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tl", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>th", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>td", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

keymap.set("n", ";", ":", { desc = "CMD enter command mode" })

keymap.set("n", "Q", "<Esc>")
keymap.set("n", "J", "mzJ`z")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "<C-o>", "<C-o>zz")
keymap.set("n", "<C-t>", "<C-t>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")
keymap.set("n", "<leader>y", [["+y"]])
keymap.set("n", "<leader>Y", [["+Y"]])
keymap.set({ "n", "v" }, "<leader>d", [["_d"]])
-- keymap.set(
-- 	"n",
-- 	"<leader>s",
-- 	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
-- 	{ desc = "Search and replace on cursor word" }
-- )
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected up" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected down" })

keymap.set("x", "<leader>p", [["_dp"]])
