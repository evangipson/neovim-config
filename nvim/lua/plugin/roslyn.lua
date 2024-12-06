local autocmd = vim.api.nvim_create_autocmd
local RoslynGroup = vim.api.nvim_create_augroup('Roslyn', {})

autocmd('VimEnter', {
    group = 'Roslyn',
    pattern = '*',
    callback = function()
        require('roslyn').setup()
    end
})

autocmd('BufEnter', {
    group = 'Roslyn',
    pattern = '<buffer>',
    callback = function()
        vim.lsp.codelens.refresh({ bufnr = 0 })
    end
})

autocmd('CursorHold', {
    group = 'Roslyn',
    pattern = '<buffer>',
    callback = function()
        vim.lsp.codelens.refresh({ bufnr = 0 })
    end
})

autocmd('InsertLeave', {
    group = 'Roslyn',
    pattern = '<buffer>',
    callback = function()
        vim.lsp.codelens.refresh({ bufnr = 0 })
    end
})
