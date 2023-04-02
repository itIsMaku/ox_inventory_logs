types = {}

function addTypeHook(name, from, to, callback)
    types[name] = {
        from = from,
        to = to,
        callback = callback
    }
end

AddEventHandler('onResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    if GetResourceState('ox_inventory') ~= 'started' then
        print('^1[logs] ^0ox_inventory is not started.')
        return
    end
    exports.ox_inventory:registerHook(
        'swapItems',
        function(payload)
            for name, data in pairs(types) do
                if payload.fromType == data.from and payload.toType == data.to then
                    --print('^3[logs] ^0' .. name .. ' type hook triggered.')
                    data.callback(payload)
                end
            end
            --print(json.encode(payload, { indent = true }))
        end,
        options
    )
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    if GetResourceState('ox_inventory') ~= 'started' then return end
    exports.ox_inventory:removeHooks()
end)
