# deadline-mod-manager
mod repository & manager for deadline

# client gui for vip server owner will be added
https://raw.githubusercontent.com/loaferrr/deadline-mod-manager/refs/heads/main/readme/modpage.png

https://raw.githubusercontent.com/loaferrr/deadline-mod-manager/refs/heads/main/readme/modpage.png

# server luau console
copy this and run it in the server luau console
```lua
set_require_domain("https://raw.githubusercontent.com/loaferrr/deadline-mod-manager/refs/heads/main/") require("main.luau")
```

# mod example
```lua
return {
    id = nil; --value gets replaced. keep it as nil

    name = "example"; --obvious
    author = "author"; --also obvious

    --richtext support for description
    description = [[supports rich text. for example: <i><font color="#10d2d5">test</font></i>]];
    categories = {
        "map";
        "autorun";
        "client";
    } ;

    iconID = "rbxassetid://135527769310887"; --1:1 "rbxassetid://replaceid"
    gallery = { --16:9 "rbxassetid://replaceid";
        "rbxassetid://75628710390998";
    };

    modfile = 'string'; 
    --the packaged string 
    --you get from the deadline modding plugin
    --load_modfile('QWERTYUIOPASDFGHJKLZXCVBNM')
    --put the string (example: 'QWERTYUIO...') thats inside of load_modfile in modfile
}
```
if you want your mod in the repotest for some reason submit a pull request