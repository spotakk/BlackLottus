config = {}

config.license = ""

--[[ Geral ]]
config.openCommand = "painel" --[[ Comando para abrir o painel ]]
config.contractTitles = { "Sub-Líder", "Gerente", "Membro" } --[[ cargos, que aparem para contratar (Membros) ]]

--[[ Permissões ]]
config.createOrgPerm = { "Admin" } --[[ Permissão para criar orgs. (Painel) ]]
config.editMessagePerm = { "Líder", "Sub-Líder", "Gerente" } --[[ Permissão para alterar mensagem da sua org (Membros) ]]
config.contractPerm = { "Líder", "Sub-Líder" } --[[ Permissão para contratar (Banco) ]]
config.withdrawPerm = { "Líder" } --[[ Permissão para sacar (Banco) e Abrir baú ]]
config.openChest = { "Líder" } --[[ Abrir baú líder ]]
config.inspectPerm = { "Líder" } --[[ Permissão para inspecionar membros (Membros) ]]

--[[ Config ]]
config.itemDollars = "dollars" --[[ Item que de dinheiro ]]

--[[ Detalhes ]]
-- 1. Toda permissão fora do painel será "cargo-org" EX: Líder-Roxo e permissão padrão "org" EX: Roxo
-- 2. Confira antes de colocar algum grupo/permissão sé ele existe, caso não poderá ocasionar em um error.
-- 3. A permissão "chefe" sempre será "Líder".