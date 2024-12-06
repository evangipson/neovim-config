-- auto-run NERDtree
local autocmd = vim.api.nvim_create_autocmd
local NERDtreeGroup = vim.api.nvim_create_augroup("NERDtree", {})

autocmd('StdinReadPre', {
    group = 'NERDtree',
    pattern = '*',
	desc = 'if a file is specified, move the cursor to it\'s window.',
    callback = function()
        vim.s.std_in = 1
    end
})

autocmd('VimEnter', {
    group = 'NERDtree',
    pattern = '*',
	desc = 'Start NERDTree whenever neovim starts.',
	callback = function()
		vim.cmd('NERDTree')
		if vim.fn.argc() > 0 or vim.fn.exists('s:std_in') then
			vim.cmd('wincmd p')
		end
	end
})

autocmd('QuitPre', {
	group = 'NERDtree',
	pattern = '*',
	desc = 'Closes vim if NERDTree is the only window remaining.',
	callback = function()
		if vim.fn.winnr('$') == 2 then
			vim.cmd('quitall!')
		end
	end
})

-- configure NERDtree options
vim.g.NERDTreeGitStatusWithFlags = 1
vim.g.NERDTreeGitStatusWithFlags = 1
vim.g.WebDevIconsUnicodeDecorateFolderNodes = 1
vim.g.NERDTreeGitStatusNodeColorization = 1
vim.g.NERDTreeColorMapCustom = {
	Staged = '#0ee375',
	Modified = '#d9bf91',
	Renamed = '#51C9FC',
	Untracked = '#FCE77C',
	Unmerged = '#FC51E6',
	Dirty = '#FFBD61',
	Clean = '#87939A',
	Ignored = '#808080'
}
-- vim.g.NERDTreeIgnore = '^node_modules$'
