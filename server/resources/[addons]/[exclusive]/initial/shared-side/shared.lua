ProviderDatabase = "vehicles"

-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------

-- Deixe com verdadeiro
NotifyConfig = true
-- Aqui voce pode notificar o player apos pegar seu carro inicial
NotifySuccess =
"Nossa equipe da administração está muito feliz em ter você conosco, trabalhamos incansavelmente para desenvolver o melhor ambiente para sua diversão, conte conosco e saiba que o nosso discord está aberto para <b>dúvidas</b>, <b>sugestões</b> e afins.<br><br>Tenha uma ótima estadia e um bom jogo.<br>Divirta-se!"
-- Aqui voce pode notificar o player apos não conseguir pegar o carro
NotifyFailed = "Você já resgatou o seu prêmio inicial!"


--- Maximo de veiculos
MaxVehicles = 4



---- Lista de veiculos  (OBS: A quantidade maxima de veiculos são 4 )

Vehicles = {
    {
        id = 1,
        name = "skyliner34",         -- Deixe o nome do carro como maiusculo quando salvar na base e poem o nome dele aqui
        subName = "SKYLINE R34", -- Nome de destaque do carro
        photo = "rr14",          -- foto que sera do carro
    },
    {
        id = 2,
        name = "a45",     -- Deixe o nome do carro como maiusculo quando salvar na base e poem o nome dele aqui
        subName = "A45",  -- Nome de destaque do carro
        photo = "a45amg", -- foto que sera do carro
    },
    {
        id = 3,
        name = "R1",             -- Deixe o nome do carro como maiusculo quando salvar na base e poem o nome dele aqui
        subName = "MOTOCICLETA", -- Nome de destaque do carro
        photo = "r1",            -- foto que sera do carro
    },
}
