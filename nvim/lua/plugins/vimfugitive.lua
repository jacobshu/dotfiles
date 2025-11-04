return {
	"tpope/vim-fugitive",
	config = function()
		-- Custom commands for advanced Git operations
		vim.api.nvim_create_user_command("GitCheckout", function(opts)
			if opts.args == "" then
				-- Show branch picker
				local branches = vim.fn.systemlist("git branch --all --format='%(refname:short)'")
				vim.ui.select(branches, {
					prompt = "Select branch to checkout:",
				}, function(choice)
					if choice then
						vim.cmd("Git checkout " .. choice)
					end
				end)
			else
				vim.cmd("Git checkout " .. opts.args)
			end
		end, { nargs = "?", desc = "Checkout branch with picker" })
		
		vim.api.nvim_create_user_command("GitNewBranch", function(opts)
			local branch_name = opts.args
			if branch_name == "" then
				branch_name = vim.fn.input("New branch name: ")
			end
			if branch_name ~= "" then
				vim.cmd("Git checkout -b " .. branch_name)
			end
		end, { nargs = "?", desc = "Create and checkout new branch" })
		
		vim.api.nvim_create_user_command("GitDeleteBranch", function(opts)
			if opts.args == "" then
				local branches = vim.fn.systemlist("git branch --format='%(refname:short)'")
				-- Remove current branch from list
				local current_branch = vim.fn.systemlist("git branch --show-current")[1]
				branches = vim.tbl_filter(function(branch)
					return branch ~= current_branch
				end, branches)
				
				vim.ui.select(branches, {
					prompt = "Select branch to delete:",
				}, function(choice)
					if choice then
						local confirm = vim.fn.input("Delete branch '" .. choice .. "'? (y/N): ")
						if confirm:lower() == "y" then
							vim.cmd("Git branch -d " .. choice)
						end
					end
				end)
			else
				local confirm = vim.fn.input("Delete branch '" .. opts.args .. "'? (y/N): ")
				if confirm:lower() == "y" then
					vim.cmd("Git branch -d " .. opts.args)
				end
			end
		end, { nargs = "?", desc = "Delete branch with picker" })
	end,
}
