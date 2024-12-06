-- all VIM options for my config

-- vim.opt.nocompatible = true
vim.opt.showmatch = true
vim.opt.ignorecase = true
-- vim.opt.mouse = "v"
-- vim.opt.mouse = "a"
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.number = true
vim.opt.wildmode="longest,list"
-- vim.opt.cc = 80
vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.ttyfast = true
vim.opt.encoding = 'UTF-8'

vim.filetype.add({
	extension = {
		nvim = 'nvim'
	}
})