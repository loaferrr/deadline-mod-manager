--!nocheck
set_require_domain("https://raw.githubusercontent.com/loaferrr/deadline-mod-manager/refs/heads/main/")

local repopath = "repotest/"
local modregistry = require("modregistry.luau")

local modrepo = {}

for _, mod in ipairs(modregistry) do
    table.insert(
        modrepo,
        require(`{repopath}/{mod}`)
    )
end

--// api i guess
on_client_event:Connect(function(player, args)
    print(player, args)
    if args[1] == "modrepo" then
        if args[2] == "no_modfile" then
            local v1 = table.clone(modrepo)
            for _, mod in ipairs(v1) do
                mod.modfile = nil
            end
            task.spawn(function()
                while v1[#v1].modfile do
                    task.wait(1/10)
                    if v1[#v1].modfile == nil then
                        players.get(player).fire_client(v1)
                    end
                end
            end)
        else
            players.get(player).fire_client(modrepo)
        end
    end
end)