for name, data in pairs(hooks) do
    addTypeHook(name, data.from, data.to, data.callback)
end

function sendWebhook(webhook, data)
    if webhooks[webhook] == nil then
        print('^1[logs] ^0Webhook ' .. webhook .. ' does not exist.')
        return
    end

    PerformHttpRequest(
        webhooks[webhook],
        function(err, text, headers)
        end,
        'POST',
        json.encode({ embeds = data }),
        { ['Content-Type'] = 'application/json' }
    )
end
