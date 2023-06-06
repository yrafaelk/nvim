require("formatter").setup {
	filetype = {
		python = {
			require("formatter.filetypes.python").isort,
			require("formatter.filetypes.python").black,
		},
        html = {
			require("formatter.filetypes.html").prettier,
        },
        javascript = {
			require("formatter.filetypes.javascript").prettier,
        },
        javascriptreact = {
			require("formatter.filetypes.javascriptreact").prettier,
        },
        typescript = {
			require("formatter.filetypes.typescript").prettier,
        },
        typescriptreact = {
			require("formatter.filetypes.typescriptreact").prettier,
        },
	}
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    vim.cmd('FormatWrite')
  end,
})
