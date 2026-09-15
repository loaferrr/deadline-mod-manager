--!nocheck
set_require_domain("https://raw.githubusercontent.com/loaferrr/deadline-mod-manager/refs/heads/main/")

local repopath = "repotest/"
local modregistry = require("modregistry.luau") --string array

local modrepo = {}

for id, modname in ipairs(modregistry) do
    local path = `{repopath}/{modname}`
    local mod = require(path)
    table.insert(
        modrepo,
        mod
    )
    mod.id = id
    print("added", mod.name, "to modrepo")
end

function loadmod(id)
    for _, mod in ipairs(modrepo) do
        if mod.id == id then
            load_modfile(mod.modfile)
        end
    end
end

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
    if args[1] == "loadmod" and player == sharedvars.vip_owner then
        for _, mod in ipairs(modrepo) do
            if mod.id == args[2] then
                loadmod(id)
            end
        end
    end
    if args[1] == "loadmap" and player == sharedvars.vip_owner then
        if typeof(args[2]) ~= "string" then
            print("son")
            return
        end
        map.set_map(args[2])
    end
end)

--// server console commands

--TODO: please turn these into separate functions for the api & this shi 
shared.modmanager = {
    loadmod = function(name)
        for _, mod in ipairs(modrepo) do
            if string.match(mod.name, name) then
                loadmod(mod.id)
            end
        end
    end;
    list = function()
        print("mod list:")
        for _, mod in modrepo do
            print(`  "{mod.name}" by "{mod.author}" id = {mod.id};`)
        end
    end;
}


--[[
--client test
fire_server("modrepo")

on_server_event:Connect(function(args)
    print(args[1])
end)
]]