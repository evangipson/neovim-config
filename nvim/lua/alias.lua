vim.api.nvim_create_user_command('EditInit',
	function()
		vim.cmd [[edit ~/AppData/Local/nvim/init.lua]]
	end
, {})
