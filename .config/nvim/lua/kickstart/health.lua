--[[
--
-- This file is not required for your own configuration,
-- but helps people determine if their system is setup correctly.
--
--]]

local check_version = function()
  local verstr = tostring(vime.version())
  if not vime.version.ge then
    vime.health.error(string.format("Neovim out of date: '%s'. Upgrade to latest stable or nightly", verstr))
    return
  end

  if vime.version.ge(vime.version(), '0.10-dev') then
    vime.health.ok(string.format("Neovim version is: '%s'", verstr))
  else
    vime.health.error(string.format("Neovim out of date: '%s'. Upgrade to latest stable or nightly", verstr))
  end
end

local check_external_reqs = function()
  -- Basic utils: `git`, `make`, `unzip`
  for _, exe in ipairs { 'git', 'make', 'unzip', 'rg' } do
    local is_executable = vime.fn.executable(exe) == 1
    if is_executable then
      vime.health.ok(string.format("Found executable: '%s'", exe))
    else
      vime.health.warn(string.format("Could not find executable: '%s'", exe))
    end
  end

  return true
end

return {
  check = function()
    vime.health.start 'kickstart.nvim'

    vime.health.info [[NOTE: Not every warning is a 'must-fix' in `:checkhealth`

  Fix only warnings for plugins and languages you intend to use.
    Mason will give warnings for languages that are not installed.
    You do not need to install, unless you want to use those languages!]]

    local uv = vime.uv or vime.loop
    vime.health.info('System Information: ' .. vime.inspect(uv.os_uname()))

    check_version()
    check_external_reqs()
  end,
}
