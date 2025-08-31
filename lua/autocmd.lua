return {
    setup = function()
        -- Highlight when yanking (copying) text
        --  Try it with `yap` in normal mode
        --  See `:help vim.highlight.on_yank()`
        vim.api.nvim_create_autocmd('TextYankPost', {
            desc = 'Highlight when yanking (copying) text',
            group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
            callback = function()
                vim.highlight.on_yank()
            end,
        })

        vim.api.nvim_create_autocmd({ 'BufEnter', 'TermOpen' }, {
            -- pattern = { 'term://*' },
            pattern = { '*' },
            desc = 'Enter insert in terminal immediately',
            group = vim.api.nvim_create_augroup('personal-terminal', { clear = true }),
            callback = function()
                if vim.opt.buftype:get() == 'terminal' then
                    vim.cmd.startinsert()
                end
            end,
        })

        vim.api.nvim_create_autocmd('BufEnter', {
            pattern = { '*' }, -- after apprentice loads specifically
            callback = function()
                local bg_color = '#2e2e2e'

                local sign_past = vim.api.nvim_get_hl(0, { name = 'BufferDefaultCurrentSign' })
                sign_past.bg = bg_color
                vim.api.nvim_set_hl(0, 'BufferDefaultCurrentSign', sign_past)

                local current_past = vim.api.nvim_get_hl(0, { name = 'BufferDefaultCurrent' })
                current_past.bg = bg_color
                vim.api.nvim_set_hl(0, 'BufferDefaultCurrent', current_past)
            end
        })
    end
}
