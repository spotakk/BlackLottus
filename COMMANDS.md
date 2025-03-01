1. **Comando `/vgroups`:**
   - **Descrição:** Este comando é destinado a membros da equipe administrativa com o grupo 'Admin' para verificar os grupos de um jogador.
   - **Uso:** `/vgroups [ID do Jogador]`
   - **Ação:**
     - Coleta informações do jogador, como nome, ID, coordenadas e data/hora.
     - Envia uma mensagem para um webhook do Discord com as informações.
     - Obtém os grupos do jogador especificado usando a função `vRP.getDatatable`.
     - Exibe os grupos no jogo usando o comando `Notify`.

2. **Comando `/gem`:**
   - **Descrição:** Este comando é usado por membros da equipe administrativa com o grupo 'Admin' para enviar gemas a um jogador.
   - **Uso:** `/gem [ID do Jogador] [Quantidade]`
   - **Ação:**
     - Atualiza a quantidade de gemas na base de dados usando a função `vRP.execute`.
     - Registra a transação em um webhook do Discord.
     - Notifica o jogador sobre o envio bem-sucedido usando o comando `Notify`.

3. **Comando `/anunciar`:**
   - **Descrição:** Permite que membros da equipe administrativa com permissões 'Owner' ou 'Admin' façam anúncios da prefeitura.
   - **Uso:** `/anunciar [Mensagem]`
   - **Ação:**
     - Coleta a mensagem do administrador.
     - Envia uma mensagem para todos os jogadores usando o comando `Notify`.

4. **Comando `/h`:**
   - **Descrição:** Um comando específico para membros da equipe administrativa com o grupo 'Admin' para interagir com a função de carregar jogadores.
   - **Uso:** `/h`
   - **Ação:**
     - Ativa/desativa a capacidade de carregar outro jogador usando o comando `toggleCarry`.

5. **Comando `/tuning`:**
   - **Descrição:** Permite a membros da equipe administrativa com o grupo 'Admin' ajustar as opções de tuning de veículos.
   - **Uso:** `/tuning`
   - **Ação:**
     - Ativa a interface de ajuste de veículos para o administrador usando `admin:vehicleTuning`.

6. **Comando `/limparinv`:**
   - **Descrição:** Limpa o inventário de um jogador. Acesso restrito a membros da equipe administrativa com permissões específicas.
   - **Uso:** `/limparinv [ID do Jogador]`
   - **Ação:**
     - Limpa o inventário do jogador especificado usando `vRP.clearInventory`.
     - Notifica o administrador usando o comando `Notify`.

7. **Comando `/mec` e `/avisomed`:**
   - **Descrição:** Permitem que membros da equipe administrativa com permissões específicas enviem mensagens como Mecânico ou Médico.
   - **Uso:** `/mec` ou `/avisomed [Mensagem]`
   - **Ação:**
     - Coleta a mensagem do administrador.
     - Envia uma mensagem para todos os jogadores usando o comando `Notify`.

8. **Comando `/setdim` e `/getdim`:**
   - **Descrição:** Configura e recupera a dimensão (routing bucket) de um jogador. Acesso restrito a membros da equipe administrativa com permissões específicas.
   - **Uso:** `/setdim [Dimensão]` ou `/getdim`
   - **Ação:**
     - Define ou obtém a dimensão do jogador usando `SetPlayerRoutingBucket` ou `GetPlayerRoutingBucket`.

9. **Comando `/avisomed`:**
   - **Descrição:** Permite a membros da equipe administrativa com permissões específicas enviar mensagens como paramédicos.
   - **Uso:** `/avisomed [Mensagem]`
   - **Ação:**
     - Coleta a mensagem do administrador.
     - Envia uma mensagem para todos os jogadores usando o comando `Notify`.

10. **Comando `/pon`:**
    - **Descrição:** Exibe a lista de jogadores online e suas IDs. Acesso restrito a membros da equipe administrativa com permissões específicas.
    - **Uso:** `/pon`
    - **Ação:**
      - Obtém a lista de jogadores online.
      - Envia a lista para o administrador usando o comando `chatMessage`.

11. **Comando `/wl`:**
    - **Descrição:** Permite a membros da equipe administrativa com permissões específicas adicionar jogadores à lista branca.
    - **Uso:** `/wl [ID do Jogador]`
    - **Ação:**
      - Adiciona o jogador à lista branca usando `vRP.execute`.

12. **Comando `/blips`:**
    - **Descrição:** Ativa blips administrativos para membros da equipe administrativa com o grupo 'Admin'.
    - **Uso:** `/blips`
    - **Ação:**
      - Ativa os blips administrativos usando `blipsAdmin`.

13. **Comando `/god`:**
    - **Descrição:** Ativa/desativa o modo "God" para jogadores com permissões administrativas.
    - **Uso:** `/god [ID do Jogador]` ou `/god` (para si mesmo)
    - **Ação:**
      - Atualiza os status de saúde e estresse, revivendo o jogador, se necessário.
      - Registra a ação em um webhook do Discord.

14. **Comando `/item`:**
    - **Descrição:** Permite a membros da equipe administrativa com permissões específicas gerar itens para jogadores.
    - **Uso:** `/item [Nome do Item] [Quantidade]`
    - **Ação:**
      - Gera o item para o jogador usando `vRP.generateItem`.
      - Registra a ação em um webhook do Discord.

15. **Comando `/priority`:**
    - **Descrição:** Aumenta a prioridade de um jogador na fila.
    - **Uso:** `/priority [ID do Jogador]`
    - **Ação:**
      - Atualiza a prioridade do jogador usando `vRP.execute`.

16. **Comando `/delete`:**
    - **Descrição:** Deleta o personagem de um jogador.
    - **Uso:** `/delete [ID do Jogador]`
    - **Ação:**
      - Remove o personagem do jogador usando `vRP.execute`.

17. **Comando `/nc`:**
    - **Descrição:** Ativa/desativa o modo "NoClip" para membros da equipe administrativa com permissões específicas.
    - **Uso:** `/nc`
    - **Ação:**
      - Ativa/desativa o modo "NoClip" usando `admin:initSpectate` e `admin:stopSpectate`.

18. **Comando `/tpm` e `/tpt`:**
    - **Descrição:** Move o administrador para um marcador ou teleporta um jogador para outro.
    - **Uso:** `/tpm` ou `/tpt [ID do Jogador]`
    - **Ação:**
      - Move o administrador para o marcador usando `vRPclient.teleport`.
      - Teleporta o jogador para o marcador usando `vRPclient.teleport`.

19. **Comando `/carta`:**
    - **Descrição:** Envia uma carta para um jogador.
    - **Uso:** `/carta [ID do Jogador] [Mensagem]`
    - **Ação:**
      - Envia uma carta para o jogador usando `vRPclient.notify`.

20. **Comando `/ban` (continuação):**
   - **Descrição:** Bane um jogador do servidor e registra a ação em um webhook do Discord.
   - **Uso:** `/ban [ID do Jogador]`
   - **Ação:**
     - Obtém o ID do jogador alvo e suas informações usando `vRP.userIdentity`.
     - Bane o jogador usando `vRP.kick` e registra a ação na tabela de banidos usando `vRP.execute`.
     - Envia uma mensagem de notificação para o jogador usando `TriggerClientEvent`.
     - Registra a ação em um webhook do Discord.
21. **Comando `/unban` (continuação):**
   - **Descrição:** Desbane um jogador do servidor e registra a ação em um webhook do Discord.
   - **Uso:** `/unban [ID do Jogador]`
   - **Ação:**
     - Obtém o ID do jogador alvo e suas informações usando `vRP.userIdentity`.
     - Remove o jogador da lista de banidos usando `vRP.execute`.
     - Envia uma mensagem de notificação para o jogador usando `TriggerClientEvent`.
     - Registra a ação em um webhook do Discord.

22. **Comando `/tpcds` (continuação):**
   - **Descrição:** Teleporta um jogador para coordenadas específicas e registra a ação em um webhook do Discord.
   - **Uso:** `/tpcds`
   - **Ação:**
     - Coleta as coordenadas do administrador usando `vKEYBOARD.keyArea`.
     - Teleporta o administrador para as coordenadas usando `vRP.teleport`.
     - Registra a ação em um webhook do Discord.

23. **Comando `/cds` (continuação):**
   - **Descrição:** Copia as coordenadas do local atual do jogador e registra a ação em um webhook do Discord.
   - **Uso:** `/cds`
   - **Ação:**
     - Obtém as coordenadas do jogador usando `GetEntityCoords`.
     - Copia as coordenadas para a área de transferência do administrador usando `vKEYBOARD.keyCopy`.
     - Registra a ação em um webhook do Discord.

24. **Comando `/group` (continuação):**
   - **Descrição:** Adiciona um jogador a um grupo específico e registra a ação em um webhook do Discord.
   - **Uso:** `/group [ID do Jogador] [Nome do Grupo]`
   - **Ação:**
     - Adiciona o jogador ao grupo especificado usando `vRP.setPermission`.
     - Envia uma mensagem de notificação para o jogador usando `TriggerClientEvent`.
     - Registra a ação em um webhook do Discord.

25. **Comando `/ungroup` (continuação):**
   - **Descrição:** Remove um jogador de um grupo específico e registra a ação em um webhook do Discord.
   - **Uso:** `/ungroup [ID do Jogador] [Nome do Grupo]`
   - **Ação:**
     - Remove o jogador do grupo especificado usando `vRP.remPermission`.
     - Envia uma mensagem de notificação para o jogador usando `TriggerClientEvent`.
     - Registra a ação em um webhook do Discord.

26. **Comando `/tptome` (continuação):**
   - **Descrição:** Teleporta um jogador até o administrador e registra a ação em um webhook do Discord.
   - **Uso:** `/tptome [ID do Jogador]`
   - **Ação:**
     - Obtém as coordenadas do administrador usando `GetEntityCoords`.
     - Teleporta o jogador para essas coordenadas usando `vRP.teleport`.
     - Registra a ação em um webhook do Discord.

27. **Comando `/tpto` (continuação):**
   - **Descrição:** Teleporta o administrador até um jogador específico e registra a ação em um webhook do Discord.
   - **Uso:** `/tpto [ID do Jogador]`
   - **Ação:**
     - Obtém as coordenadas do jogador alvo usando `GetEntityCoords`.
     - Teleporta o administrador para essas coordenadas usando `vRP.teleport`.
     - Registra a ação em um webhook do Discord.

28. **Comando `/tpway` (continuação):**
   - **Descrição:** Teleporta o administrador para um marcador predefinido e registra a ação em um webhook do Discord.
   - **Uso:** `/tpway`
   - **Ação:**
     - Teleporta o administrador para o marcador usando `clientAPI.teleportWay`.
     - Registra a ação em um webhook do Discord.

29. **Comando `/limbo`:**
   - **Descrição:** Ativa quando um jogador usa o comando "/limbo".
   - **Ação:**
     - Se o jogador estiver em um status de bate-papo específico, tiver um ID de usuário válido e tiver baixa saúde, teleporta o jogador para uma localização "limbo".

30. **Comando `/hash`:**
   - **Descrição:** Ativa quando um jogador com o grupo admin usa o comando "/hash".
   - **Ação:**
     - Obtém o hash do veículo em que o jogador está e exibe.

31. **Comando `/fix`:**
   - **Descrição:** Ativa quando um jogador com o grupo admin usa o comando "/fix".
   - **Ação:**
     - Obtém informações sobre o veículo do jogador e o repara para todos os jogadores ativos.

32. **Comando `/limparea`:**
   - **Descrição:** Ativa quando um jogador com o grupo moderador usa o comando "/limparea".
   - **Ação:**
     - Obtém as coordenadas do jogador e envia um sinal para todos os jogadores ativos para sincronizar uma área ao redor do moderador.

33. **Comando `/players`:**
   - **Descrição:** Ativa quando um jogador com o grupo moderador usa o comando "/players".
   - **Ação:**
     - Exibe o número de jogadores conectados e envia uma mensagem de webhook do Discord com informações sobre o membro da equipe que usou o comando.

34. **Comando `/sugestao`:**
   - **Descrição:** Ativa quando um jogador usa o comando "/sugestao".
   - **Ação:**
     - Permite que o jogador insira uma sugestão e a envia para o Discord por meio de um webhook.

35. **Comando `/cds2`:**
   - **Descrição:** Ativa quando um jogador com o grupo moderador usa o comando "/cds2".
   - **Ação:**
     - Copia as coordenadas do jogador para a área de transferência e envia uma mensagem de webhook do Discord com informações sobre o membro da equipe que usou o comando.

36. **Comando `/announce`:**
   - **Descrição:** Ativa quando um jogador com o grupo admin usa o comando "/announce".
   - **Ação:**
     - Envia uma mensagem de chat em todo o servidor com um prefixo "ALERTA".

37. **Comando `/announce2`:**
   - **Descrição:** Ativa quando um jogador com permissões de admin ou owner usa o comando "/announce2".
   - **Ação:**
     - Permite que o membro da equipe envie uma notificação formatada para todos os jogadores.

38. **Comando `/anunciar`, `/avisopm`, `/console`, `/kickall`, `/itemp`, `/enviar`:**
   - **Descrição:** Vários comandos para funcionalidades diferentes, como enviar anúncios, chutar todos os jogadores e gerenciar itens.

39. **Comando `/admindebug`:**
   - **Descrição:** Ativa quando um jogador com permissões de admin usa o comando "/admindebug".
   - **Ação:**
     - Alterna um modo de depuração para o jogador.

40. **Comando `/addcar`:**
   - **Descrição:** Ativa quando um jogador com permissões de admin usa o comando "/addcar".
   - **Ação:**
     - Adiciona um veículo especificado à garagem de um jogador-alvo.

41. **Comando `/remcar`:**
   - **Descrição:** Ativa quando um jogador com permissões de admin usa o comando "/remcar".
   - **Ação:**
     - Remove um veículo especificado da garagem de um jogador-alvo.

42. **Evento `vRP:playerSpawn` (continuação):**
   - **Descrição:** Disparado quando um jogador aparece.
   - **Ação:**
     - Verifica o status VIP e remove permissões específicas se o status VIP expirar.

43. **Evento `vRP:playerDied` (continuação):**
   - **Descrição:** Disparado quando um jogador morre.
   - **Ação:**
     - Envia uma mensagem de webhook do Discord com informações sobre o jogador que morreu.

44. **Evento `vRP:playerJoin` (continuação):**
   - **Descrição:** Disparado quando um jogador entra no servidor.
   - **Ação:**
     - Envia uma mensagem de webhook do Discord com informações sobre o jogador que entrou.

45. **Evento `vRP:playerLeave` (continuação):**
   - **Descrição:** Disparado quando um jogador deixa o servidor.
   - **Ação:**
     - Envia uma mensagem de webhook do Discord com informações sobre o jogador que saiu.

46. **Evento `vRP:playerDeath` (continuação):**
   - **Descrição:** Disparado quando um jogador morre.
   - **Ação:**
     - Envia uma mensagem de webhook do Discord com informações sobre o jogador que morreu.