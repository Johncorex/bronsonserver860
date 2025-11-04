local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)			npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)			npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()					npcHandler:onThink()					end

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end

	local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid



-- CONFIG --	
local player = Player(cid)
	if msgcontains(msg, 'lugares de caça') then
			selfSay('Voce pode utilzar o comando /ir, para explorar os lugares de caça do seu level ou se prefir as cidades iniciais estão repletas de respawns para levels baixos, basta explorar em volta da cidade que Voce achará os respawns sem maiores problemas.', cid)
			return end
			if msgcontains(msg, 'comandos') then
			selfSay('Voce pode utilizar o comando !commands para ver a lista de comandos disponveis.', cid)
			return end
			if msgcontains(msg, 'npcs') then
			selfSay('Npc de venda e compra de itens pode ser encontrado em dunedain, edoras, e minas, npc de food proximo a saida de edoras ao oeste, npc de blank rune em forod enfrente ao depot e npcs de addons estão espalhados pelo mapa.', cid)
			return end
			if msgcontains(msg, 'sistemas') then
			selfSay('Nosso servidor conta com diversos sistemas exclusivos, para mais informações acesse: www.bronsonproject.com', cid)
			return end
			if msgcontains(msg, 'frags') then
			selfSay('Voce tem direito a matar injustamente 7 jogadores por dia, voce pode usar o comando !kills.', cid)
			return end
			if msgcontains(msg, 'bless') then
			selfSay('Voce pode comprar sua bless em Eriador, para ir ate lá fale /ir Eriador e vá ate o npc Blesser na igreja dos novice of the cult', cid)
			return end
			if msgcontains(msg, 'aol') then
			selfSay('Voce pode comprar seu aol em edoras no depot inferior, ou em minas na parte superior ao oeste da cidade.', cid)
			return end
			if msgcontains(msg, 'montaria') then
			selfSay('Ainda nao contamos com esse sistema em nosso servidor.', cid)
			return end
			if msgcontains(msg, 'magias') then
			selfSay('Para saber suas magias acesse: www.bronsonproject.com/spells', cid)
			return end
			if msgcontains(msg, 'promotions') then
			selfSay('Para saber sobre as promotions acesse: www.bronsonproject.com/vocacoes', cid)
			return end
			if msgcontains(msg, 'itens') then
			selfSay('Para saber sobre os itens acesse: www.bronsonproject.com/items', cid)
			return end
			if msgcontains(msg, 'criaturas') then
			selfSay('Para saber sobe as criaturas acesse: www.bronsonproject.com/monsters', cid)
			return end
			if msgcontains(msg, 'stamina') then
			selfSay('A stamina sobe enquanto voce esta offline ou nos treiners, P.A sobe 2 de stamina por minuto, e Free account sobe 1 de stamina a cada 2 minutos.', cid)
			return end
			if msgcontains(msg, 'trainer') then
			selfSay('Os treinadores ficam localizados na ciade de dunedain e minas.', cid)
			return end
			
	end


npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())