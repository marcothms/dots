if vim.api.nvim_eval("executable('pyls')") then
	require'lspconfig'.pyls.setup{}
end

if vim.api.nvim_eval("executable('rust-analyzer')") then
	require'lspconfig'.rust_analyzer.setup{}
end

if vim.api.nvim_eval("executable('texlab')") then
	require'lspconfig'.texlab.setup{
		settings = {
			latex = {
				build = {
					onSave = true;
				};
				forwardSearch = {
					executable = "zathura";
					args = {"--synctex-forward", "%l:1:%f", "%p"};
				}
			};
		};
		commands = {
			ZathuraShow = {
				function()
					vim.lsp.buf_request(0, "textDocument/forwardSearch", vim.lsp.util.make_position_params(),
						function(err, _, _, _)
							if err then error(tostring(err)) end
						end
						)
				end;
				description = "Show the current position in zathura";
			}
		}

	}
	vim.api.nvim_set_keymap("n", "gz", "<cmd>ZathuraShow<CR>", { noremap = true, silent = true })
end

-- g(o) d(efinition)
vim.api.nvim_set_keymap("n", "gd" , "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
-- g(o) r(eference)
vim.api.nvim_set_keymap("n", "gr" , "<cmd>lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true })
-- K for hover information
vim.api.nvim_set_keymap("n", "K" , "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })
-- s(how) d(iagnostics)
vim.api.nvim_set_keymap("n", "<leader>sd", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", { noremap = true})
