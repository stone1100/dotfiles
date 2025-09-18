return {
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		enabled = false,
		opts = function()
			local logo = {
				[[]],
				[[]],
				[[]],
				[[]],
				[[]],
				[[]],
				[[             ,----------------,              ,---------,]],
				[[        ,-----------------------,          ,"        ,"|]],
				[[      ,"                      ,"|        ,"        ,"  |]],
				[[     +-----------------------+  |      ,"        ,"    |]],
				[[     |  .-----------------.  |  |     +---------+      |]],
				[[     |  |    I L O V E    |  |  |     | -==----'|      |]],
				[[     |  | T E R M I N A L |  |  |     |         |      |]],
				[[     |  |       &         |  |  |/----|`---=    |      |]],
				[[     |  |   L I N V I M   |  |  |   ,/|==== ooo |      ;]],
				[[     |  | ~:\>_           |  |  |  // |(((( [33]|    ," ]],
				[[     |  `-----------------'  |," .;'| |((((     |  ,"   ]],
				[[     +-----------------------+  ;;  | |         |,"     ]],
				[[        /_)______________(_/  //'   | +---------+       ]],
				[[   ___________________________/___  `,                  ]],
				[[  /  oooooooooooooooo  .o.  oooo /,   \,"-----------    ]],
				[[ / ==ooooooooooooooo==.o.  ooo= //   ,`\--{)B     ,"    ]],
				[[/_==__==========__==_ooo__ooo=_/'   /___________,"      ]],
				[[`-----------------------------'                         ]],
				[[]],
				[[]],
			}
			local opts = {
				theme = "doom", -- "hyper", "doom"
				config = {
					header = logo,
					hide = {
						statusline = true,
						tabline = true,
					},
					center = {
						{
							action = "Telescope find_files",
							desc = " Find File",
							icon = " ",
							key = "f",
						},
						{
							action = "ene | startinsert",
							desc = " New File",
							icon = " ",
							key = "n",
						},
						{
							action = "Telescope oldfiles",
							desc = " Recent Files",
							icon = " ",
							key = "r",
						},
						{
							action = "Telescope live_grep",
							desc = " Find Text",
							icon = " ",
							key = "g",
						},
						{
							action = [[lua require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })]],
							desc = " Config",
							icon = " ",
							key = "c",
						},
						{
							action = "Lazy",
							desc = " Plugins",
							icon = "󰒲 ",
							key = "l",
						},
						{
							action = "qa",
							desc = " Quit",
							icon = " ",
							key = "q",
						},
					},
					footer = function()
						local stats = require("lazy").stats()
						local icons = lin.options.icons
						local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
						local nvim_version = vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch
						local date_time = function()
							local thingy = io.popen('echo "$(date +%a) $(date +%d) $(date +%b)" | tr -d "\n"')
							if thingy == nil then
								return ""
							end
							local date = thingy:read("*a")
							thingy:close()

							local datetime = os.date(icons.time .. " %H:%M")
							return " " .. icons.calendar .. " " .. date .. " " .. datetime
						end

						return {
							icons.rocket .. " LinVim(" .. lin.version .. ")" .. date_time(),
							icons.hint
							.. "Neovim("
							.. nvim_version
							.. ") loaded "
							.. stats.loaded
							.. "/"
							.. stats.count
							.. " plugins in "
							.. ms
							.. "ms",
						}
					end,
				},
			}
			return opts
		end,
	},
}
