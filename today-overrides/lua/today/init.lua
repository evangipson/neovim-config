local M = {}

local config = {
  local_root = nil,
  template = "jrnl.md"
}

local function ensure_default_setup()
  if not config.local_root then
    local home = os.getenv("UserProfile")
    config.local_root = home .. "/.today"

    -- Create default directory if it doesn't exist
    if vim.fn.isdirectory(config.local_root) == 0 then
      vim.fn.mkdir(config.local_root, "p")

      -- Copy default template
      local plugin_dir = debug.getinfo(1, "S").source:sub(2):match("(.*/)")
      local default_template = plugin_dir .. "jrnl.md"
      local target_template = config.local_root .. "/jrnl.md"

      if vim.fn.filereadable(target_template) == 0 then
        local template_file = io.open(default_template, "r")
        local template_file_content = template_file:read("*a")

        template_file:close()
        local f = io.open(target_template, "w")
        f:write(template_file_content)
        f:close()

        vim.fn.system(string.format("cp %s %s", default_template, target_template))
		--vim.fn.filecopy(default_template, target_template)
      end
    end
  end
end

function M.today(offset)
  ensure_default_setup()
  
  offset_arg = offset
  if(offset.args == '') then
	offset_arg = 0
  end

  -- Get target date
  local current_time = os.time()
  local target_time = os.time({
    year = os.date('%Y', current_time),
    month = os.date('%m', current_time),
    day = os.date('%d', current_time)
  }) - (offset_arg * 24 * 60 * 60)
  local target_date = os.date("%Y-%m-%d", target_time)

  -- Extract year, month, day
  local year, month, day = target_date:match("(%d+)-(%d+)-(%d+)")

  -- Create directory if it doesn't exist
  local dir = string.format("%s/daily/%s/%s", config.local_root, year, month)
  vim.fn.mkdir(dir, "p")
  -- os.execute(string.format("mkdir -p %s", dir))

  -- Create file path
  local file = string.format("%s/%s.md", dir, target_date)

  -- Check if file exists, if not, copy template
  -- local f = io.open(file, "r")
  if vim.fn.filereadable(file) == 0 then
	local template_path = config.local_root .. "/" .. config.template
	local template_file = io.open(template_path, "r")
	local template_file_content = template_file:read("*a")
	template_file:close()
	local f = io.open(file, "w")
	f:write(template_file_content)
	f:close()
    -- local template_path = config.local_root .. "/" .. config.template
    -- vim.cmd [[filecopy(template_path, file)]]
	-- vim.fn.system(string.format("cp %s %s", template_path, file))
    -- os.execute(string.format("cp %s %s", template_path, file))
    -- else
    -- f:close()
  end

  -- Open file in Neovim
  vim.cmd(string.format("edit %s", file))
end

function M.setup(opts)
  -- Merge user options with default config
  config = vim.tbl_deep_extend("force", config, opts or {})

  vim.api.nvim_create_user_command("Today", function(args)
    local count = args.count ~= 0 and args.count or nil
    local offset = count or tonumber(args.args) or 0
    today(offset)
  end, { nargs = "?", count = true })
end

return M

-- function M.setup(opts)
--   vim.api.nvim_create_user_command("MyPluginHello", function()
--     print("Hello from MyPlugin!")
--   end, {})
-- end
--
-- return M
