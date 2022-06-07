# WORK IN PROGRESS, DON'T USE IT!!!!!!!!!!!


# sublime_secureEvent
C'est un script standalone pour sécurisé ses event sur FiveM

## Contact
- [Discord](https://discord.gg/hgHZPzRT)

## Installlation :
Penser à le start en amont de toute les ressource qui vont en dépendre! 

```cfg
ensure sublime_secureEvent

# puis tout vous resources qu'ils l'utilisent ensuite
```

Je conseil personnellement d'aller chercher tout les fichier besoins pour le moment dans vos `fxmanifest.lua` ainsi

```lua
shared_scripts {
    '@sublime_secureEvent/shared/config/config.lua',
    '@sublime_secureEvent/shared/shared.lua',
    ---
}

client_scripts {
    '@sublime_secureEvent/client/client.lua',
    ---
}
server_scripts {
    '@sublime_secureEvent/server/server.lua',
    ---
}
```

Plutot que ceci

```lua
shared_script '@sublime_secureEvent/imports.lua'
```

Qui pour le coups... fonctionne mais peut poser problème quand vous redemarrez une ressource il ce peut qu'a chaque restart de cette resource vous aurez une erreur `CitizenFX` qui ne porte aucune disfonctionnalité au script mais peut-être chiant à voir dans la console...

## Utilisation :

Dans le `config.lua` vous pouvez enregistrer vos event

- `['test1']` est une clé, ceci va vous permettre d'identifier vos event
- `label = 'label1'` est juste une description vous pouvez mettre ce que vous voulez mais cela n'a aucune importance, mais garder tout le format `''`, ne supprimez pas ou ne faite pas `label = nil`
- `name = 'n1'` ceci sera le vraie nom de vos event, alors vous pouvez mettre ce que vous voulez puis qu'ils seront selectionné à partir de la clé donc par exemple pour un event qui ajoute de l'argent vous pouvez mettre : 
`qsdjhqODjhqDjhQIDjqMDJqIMDSJqPISDJqPIJDPQJDSQSJDôQKDôQKD^QODKS` temps que qu'une clé et qu'un nom n'est pas identique il y aura aucune problème

```lua
Sublime.Config.Event = {
    ['test1'] = {label = 'label1', name = 'n1'},
    ['test2'] = {label = 'label2', name = 'n'},
    ['test3'] = {label = 'label3', name = 'n2'},
    ['test4'] = {label = 'label4', name = 'b3'},
}
```

Enregister/Ecouter et utilser un event côté serveur :
```lua
Sublime.event:server(
    boolean, -- un boolean donc true/false ou 0/1, ici c'est pour enregistrer l'event (RegisterServerEvent)
    boolean, -- un boolean donc true/false ou 0/1, ici c'est pour ecouter l'event enregistrer (AddEventHandler)
    string, -- un string donc une chaine de caractère, ici c'est la clé
    var -- une variable qui doit obligatoirement est une fonction car c'est la fonction de AddEventHandler
)
```

```lua
-- On enregistrer et écoute notre event
function test(a, b) -- la fonction de AddEventHandler
    return print(a, b)
end
Sublime.event:server(true, true, 'test1', test)
-- fin
Sublime.trigger:simple('test1', a, b) -- On utilise notre event côté serveur (TriggerEvent)
Sublime.trigger:server('test1', a, b) -- On utilise notre event côté client (TriggerServerEvent)
```

Enregister/Ecouter et utilser un event côté serveur :
```lua
Sublime.event:client(
    boolean, -- un boolean donc true/false ou 0/1, ici c'est pour enregistrer l'event (RegisterNetEvent)
    boolean, -- un boolean donc true/false ou 0/1, ici c'est pour ecouter l'event enregistrer (AddEventHandler)
    string, -- un string donc une chaine de caractère, ici c'est la clé
    var -- une variable qui doit obligatoirement est une fonction car c'est la fonction de AddEventHandler
)
```

```lua
-- On enregistrer et écoute notre event
function test(a, b, c) -- la fonction de AddEventHandler
    return print(a, b, c)
end
Sublime.event:client(true, true, 'test2', test)
-- fin
Sublime.trigger:simple('test2', a, b, c) -- On utilise notre event côté client (TriggerEvent)
Sublime.trigger:client('test2', a, b, c) -- On utilise notre event côté server (TriggerClientEvent)
```