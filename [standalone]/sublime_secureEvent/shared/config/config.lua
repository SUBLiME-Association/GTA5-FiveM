Sublime = Sublime or {}
Sublime.Config = Sublime.Config or {}

Sublime.Config.Dev = false -- pas encore developper

-- la key c'est ce que vous utiliser pour identifier vos event
-- label = la description pas obliger d'etre remplit mais il neut faut pas que cela vaut nil donc laisser toujours label = ''
-- name = le nom des event utiliser par rapport a la key, vous pouvez mettre n'importe te quoi temps que cela est forme de 'string'

Sublime.Config.Event = {
    ['test1'] = {label = 'label1', name = 'n1'},
    ['test2'] = {label = 'label2', name = 'n'},
    ['test3'] = {label = 'label3', name = 'n2'},
    ['test4'] = {label = 'label4', name = 'b3'},
}