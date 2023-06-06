local lsp = require('lsp-zero').preset({})

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    sources = {
        {name = 'nvim_lsp'},
        {name = 'luasnip'},
    },
    completion = { completeopt = 'menu,menuone,noinsert'},
    mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
            -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
            if cmp.visible() then
                local entry = cmp.get_selected_entry()
                if not entry then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    cmp.confirm()
                end
            else
                fallback()
            end
        end, {"i","s","c",}),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-f>'] = cmp_action.luasnip_jump_forward(),
        ['<C-b>'] = cmp_action.luasnip_jump_backward(),
    }
})

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
require('lspconfig').pyright.setup(lsp.nvim_lua_ls())
require('lspconfig').tsserver.setup(lsp.nvim_lua_ls())
require('lspconfig').eslint.setup(lsp.nvim_lua_ls())

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({buffer = bufnr})

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, {buffer = true})
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, {buffer = true})
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, {buffer = true})
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, {buffer = true})
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, {buffer = true})
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, {buffer = true})
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, {buffer = true})
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, {buffer = true})
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, {buffer = true})
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, {buffer = true})
end)

lsp.setup()
