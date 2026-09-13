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

task.delay(2, function()
    for _, mod in ipairs(modrepo) do
        print("loaded", mod.name)
    end
end)

--// api i guess
on_client_event:Connect(function(player, args)
    print(player, args)
    if args[1] == "modrepo" then
        if args[2] == "no_modfile" then
            -- i didnt know what to name this table, alright its 7am i woke at like 5pm yesterday, okay?
            local v1 = table.clone(modrepo)
            for _, mod in ipairs(v1) do
                mod.modfile = nil
            end
            task.spawn(function()
                while v1[#v1].modfile do
                    task.wait(1/10)
                    if v1[#v1].modfile == nil then
                        players.get(player).fire_client({v1})
                    end
                end
            end)
        else
            players.get(player).fire_client({modrepo})
        end
    end
    if args[1] == "loadmod" then --extremely unprotected
        for _, mod in ipairs(modrepo) do
            if mod.name == args[2] then
                load_modfile(mod.modfile)
            end
        end
    end
end)


--[[
--client test
fire_server("modrepo")

on_server_event:Connect(function(args)
    print(args[1])
end)
]]