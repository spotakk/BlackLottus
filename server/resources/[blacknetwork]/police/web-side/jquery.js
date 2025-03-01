var selectPage = "Prender";
var reversePage = "Prender";
/* ---------------------------------------------------------------------------------------------------------------- */
$(document).ready(function() {
    functionPrender();

    $('body').append('<img id="water_mark" src="">');
    $("#water_mark").css('display', 'none');
    $("#water_mark").css('width', '70px');
    $("#water_mark").css('height', 'auto');
    $("#water_mark").css('opacity', '.5');
    $("#water_mark").css('position', 'absolute');
    $("#water_mark").css('bottom', '50px');
    $("#water_mark").css('left', '50px');
    $("#water_mark").css('z-index', '1000');
    $('#water_mark').attr("src", "https://cdn.discordapp.com/attachments/962825773398511626/983095582690275448/BlackNetwork2.png");

    window.addEventListener("message", function(event) {
        switch (event["data"]["action"]) {
            case "openSystem":
                $("#mainPage").css("display", "flex");
                setTimeout(function() {
                    $('#mainPage').css("transform", "scale(1)");
                    $('#mainPage').css("opacity", "1");
                }, 200);
                setTimeout(function() {
                    $("#water_mark").css('display', 'block');
                }, 300);
                break;

            case "closeSystem":
                setTimeout(function() {
                    $("#mainPage").css("display", "none");
                }, 200);
                $("#water_mark").css('display', 'none');
                $('#mainPage').css("transform", "scale(.4)");
                $('#mainPage').css("opacity", "0");

                break;

            case "reloadPrison":
                functionPrender();
                break;

            case "reloadFine":
                functionMultar();
                break;

            case "reloadSearch":
                functionSearch(event["data"]["data"]);
                break;
        };
    });

    document.onkeyup = function(data) {
        if (data["which"] == 27) {
            $.post("http://police/closeSystem");
        };
    };

});
/* ---------------------------------------------------------------------------------------------------------------- */
$(document).on("click", "#mainMenu li", function() {
    if (selectPage != reversePage) {
        let isActive = $(this).hasClass('active');
        $('#mainMenu li').removeClass('active');
        if (!isActive) {
            $(this).addClass('active');
            reversePage = selectPage;
        };
    };
});
/* ----------FUNCTIONSEARCH---------- */
const functionSearch = (passaporte) => {
        if (passaporte != "") {
            $.post("http://police/searchUser", JSON.stringify({ passaporte: parseInt(passaporte) }), (data) => {
                        if (data["result"][0] == true) {


                            $('#content').html(`
					<div id="titleContent">Resultado</div>
					<div class="feed">
						<div id="pageSearch">
							<div class="searchBox">
								<div class="searchInfo">
									<div class="nacionalidade">
									<h3><i class="fas fa-map-marker-alt"></i> ${data["result"][6]}</h3>
									</div>
									<div>
										<h2>${data["result"][1]} <span>#${formatarNumero(passaporte)}</span></h2>
									</div>
									<div>
										<h3><i class="fas fa-phone"></i> ${data["result"][2]}</h3>
									</div>
								</div>
								<div class="searchInfo">
									<div>
										<h4>Multas</h4>
										<p>${formatarNumero(data["result"][3])} $</p>
									</div>
								</div>
								<div class="searchInfo">
									<div>
										<h4>Policial</h4>
										<p>${data["result"][8] == true ? "Sim":"Não"}</p>
									</div>
									<div>
										<h4>Porte</h4>
										<p>${data["result"][5] == 0 ? "Não":"Sim"}</p>
									</div>
								</div>
							</div>	
							<div class="recordBox">
								<table style="width:100%">
									<tr>
										<th>Oficial</th>
										<th>Descrição</th>
										<th>Serviços</th>
										<th>Multas</th>
										<th>Data</th>
									</tr>			
								${data["result"][4].map((data) => (`
								<tr>
									<td>${data["police"]}</td>
									<td>${data["text"]}</td>
									<td>${formatarNumero(data["services"])}</td>
									<td>${formatarNumero(data["fines"])} $</td>
									<td>${data["date"]}</td>
								</tr>
								`)).join('')}
								</table>
							</div>
							<div id="pageFine">
								<div class="attention">
									<i class="fas fa-exclamation-triangle"></i>
								</div>
								<div class="obs">
									<h2>OBSERVAÇÕES</h2>
									<p><b>1 -</b> Todas as informações encontradas são de uso exclusivo policial, tudo que for encontrado na mesma são informações em tempo real.</p>
									<p><b>2 -</b> Nunca forneça qualquer informação dessa página para outra pessoa, apenas se a mesma for o proprietário ou o advogado do mesmo.</p>
								</div>
							</div>
						</div>
				`);
			} else {
				$('#content').html(`
					<div id="titleContent">RESULTADO</div>
					<div class="feed">
						<div class="fail">
                    		<div class="fof">
                      		  	<h4>Error 404</h4>
                    		    <p>Não foi encontrado informações sobre o passaporte procurado :(</p>
                   			</div>
               			 </div>
					</div>
				`);
			}
		});
	}
	}
/* ----------BUTTONSEARCH---------- */
$('#searchPassaporte').keypress(function(event){
	if(event.which == 13){
		const passaporte = $('#searchPassaporte').val();
		functionSearch(passaporte);
	}		
});

$(document).on("click",".buttonSearch",function(e){
	const passaporte = $('#searchPassaporte').val();
	functionSearch(passaporte);
});
/* ----------CLICKBUY---------- */
$(document).on("click","#portSearch",function(e){
	$.post("http://police/updatePort",JSON.stringify({ passaporte: e["target"]["dataset"]["id"] }));
});
/* ----------CLICKBUY---------- */
$(document).on("click","#penalSearch",function(e){
	$.post("http://police/updatePenal",JSON.stringify({ passaporte: e["target"]["dataset"]["id"] }));
});
/* ---------------------------------------------------------------------------------------------------------------- */
const functionPrender = () => {
	selectPage = "Prender";

	$('#content').html(`
		<div id="titleContent">PRENDER</div>
		<div class="feed">	
			<div id="pageSecure">
				<div class="prision">
					<input class="inputPrison" id="prenderPassaporte" type="number" onKeyPress="if(this.value.length==10) return false;" value="" placeholder="Passaporte"></input>
					<input class="inputPrison" id="prenderServices" type="number" onKeyPress="if(this.value.length==10) return false;" value="" placeholder="Serviços"></input>
					<input class="inputPrison" id="prenderMultas" type="number" onKeyPress="if(this.value.length==10) return false;" value="" placeholder="Valor da multa"></input>
				</div>
				<textarea class="textareaPrison" maxlength="500" id="prenderTexto" value="" placeholder="Todas as informações dos crimes."></textarea>
				<button class="buttonPrison"><div>Prender</div></button>
			</div>

			<div id="pageFine">
				<div class="attention">
					<i class="fas fa-exclamation-triangle"></i>
				</div>
				<div class="obs">
					<h2>OBSERVAÇÕES</h2>
					<p><b>1 -</b> Antes de enviar o formulário verifique corretamente se todas as informações estão de acordo com o crime efetuado, você é responsável por todas as informações enviadas e salvas no sistema.</p>
					<p><b>2 -</b> Ao preencher o campo de multas, verifique se o valor está correto, após enviar o formulário não será possível alterar ou remover a multa enviada.</p>
					<p><b>3 -</b> Todas as prisões são salvas no sistema após o envio, então lembre-se que cada formulário enviado, o valor das multas, serviços e afins são somados com a ultima prisão caso o mesmo ainda esteja preso.</p>
				</div>
			</div>
		</div>
	`);
};
/* ----------BUTTONPRISON---------- */
$(document).on("click",".buttonPrison",function(e){
	const passaporte = $('#prenderPassaporte').val()
	const servicos = $('#prenderServices').val()
	const multas = $('#prenderMultas').val()
	const texto = $('#prenderTexto').val()

	if (passaporte != "" && servicos != "" && multas != "" && texto != ""){
		$.post("http://police/initPrison",JSON.stringify({
			passaporte: parseInt(passaporte),
			servicos: parseInt(servicos),
			multas: parseInt(multas),
			texto: texto
		}));
	}
});
/* ---------------------------------------------------------------------------------------------------------------- */
const functionMultar = () => {
	selectPage = "Multar";

	$('#content').html(`
		<div id="titleContent">MULTAR</div>
		<div class="feed">
			<div id="pageSecure">
				<div class="prision">
					<input class="inputFine" id="multarPassaporte" type="number" onKeyPress="if(this.value.length==5) return false;" value="" placeholder="Passaporte"></input>
					<input class="inputFine" id="multarMultas" type="number" onKeyPress="if(this.value.length==7) return false;" value="" placeholder="Valor da multa"></input>
				</div>
				<textarea class="textareaFine" id="multarTexto" maxlength="500" value="" placeholder="Todas as informações da multa."></textarea>
				<button class="buttonFine"><div>Multar</div></button>
			</div>

			<div id="pageFine">
				<div class="attention">
					<i class="fas fa-exclamation-triangle"></i>
				</div>
				<div class="obs">
					<h2>OBSERVAÇÕES</h2>
					<p><b>1 -</b> Antes de enviar o formulário verifique corretamente se todas as informações estão de acordo com a multa, você é responsável por todas as informações enviadas e salvas no sistema.</p>
					<p><b>2 -</b> Ao preencher o campo de multas, verifique se o valor está correto, após enviar o formulário não será possível alterar ou remover a multa enviada.</p>
				</div>
			</div>
		</div>
	`);
	
};
/* ----------BUTTONFINE---------- */
$(document).on("click",".buttonFine",function(e){
	const passaporte = $('#multarPassaporte').val()
	const multas = $('#multarMultas').val()
	const texto = $('#multarTexto').val()

	if (passaporte != "" != "" && multas != "" && texto != ""){
		$.post("http://police/initFine",JSON.stringify({
			passaporte: parseInt(passaporte),
			multas: parseInt(multas),
			texto: texto
		}));
	}
});
/* ----------FORMATARNUMERO---------- */
const formatarNumero = (n) => {
	var n = n.toString();
	var r = '';
	var x = 0;

	for (var i = n.length; i > 0; i--) {
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? '.' : '');
		x = x == 2 ? 0 : x + 1;
	}

	return r.split('').reverse().join('');
}

var assinatura = 'AUTOR DO CÓDIGO: GABRIEL FELIPE DE ALBUQUERQUE ' +
    'GITHUB: https://github.com/GabrielAlbuquerque19 ' +
    'Todos os direitos reservados. Hype Shop Roleplay 2022';