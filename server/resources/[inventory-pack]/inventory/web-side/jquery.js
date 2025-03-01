var cssString = `
:root {

	--white-color: rgb(255, 255, 255);
	--purple-color: #5763D0;

}

* {
	
	overflow: hidden;
	box-sizing: border-box;
	user-select: none;

}

body {
	
	margin: 0;
	padding: 0;
	color: var(--white-color);
	font-family: "Inter", sans-serif;
	font-optical-sizing: auto;
	font-weight: normal;
	font-style: normal;

}

/* ------------------- SCROLL ------------------- */

*::-webkit-scrollbar { 
	width: 3px;
}

*::-webkit-scrollbar-track { 
	background: rgba(87, 99, 208, .1);
	border-radius: 100px;
}

*::-webkit-scrollbar-thumb { 
	background: rgb(87, 99, 208);
	border-radius: 100px;
}

input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button { -webkit-appearance: none; }

/* --------------------------------------------- */

/* ------------------- RESET ------------------- */

h1, h2, h3 {

	margin: 0;

}

/* --------------------------------------------- */

.inventory {
	
	width: 100vw;
	height: 100vh;
	display: none;
	position: fixed;
	align-items: center;
	justify-content: center;
	flex-direction: column;
	background-image: url(./images/bg.png);
	background-size: 100%;
	/* animation: opacity-in-out .3s ease-in; */

}

/* @keyframes opacity-in-out {
	0% {
		opacity: 0;
	}
	100% {
		opacity: 1;
	}
} */

.innerInventory {
	display: flex;
	flex-direction: column;
}

.sections {

	display: flex;
	height: 652px;
	max-height: 652px;

}

.invLeft, .invRight {

	display: grid;
	grid-template-columns: repeat(5, 1fr);
	gap: 4px;
	overflow-y: scroll;
	padding-right: 10px;
	
}

.item {
	
	width: 125px;
	height: 160px;
	display: flex;
	flex-direction: column;
	border-radius: 5px;
	background: rgba(16, 16, 21, .2);
	position: relative;
	cursor: pointer;

}

.populated {

	background-size: 86% !important;

}

.populated .nameItem {

	position: absolute;
	height: 0;
	left: 0;
	bottom: -60%;
	transition: all .45s ease-in-out;

}

.populated:hover .nameItem {

	height: 26px;
	bottom: 0;
	position: relative;

}

.hoverControl {

	background: rgba(16, 16, 21, .6)

}

.item .top {

	display: flex;
	justify-content: space-between;
	align-items: center;
	margin: 10px 10px 0 10px;
	font-size: .7rem;

}

.invLeft > .item:nth-child(n+1):nth-child(-n+5) .nameItem {

	position: relative;
	height: 26px;
	bottom: 0;

}

.invLeft > .item:nth-child(n+1):nth-child(-n+5) {

	background-color: rgba(255, 255, 255, .01);
	background-repeat: no-repeat;
	background-position: center;

}

.invLeft > .item:nth-child(n+1):nth-child(-n+5).populated, .invRight .item.populated:hover {

	background: rgba(16, 16, 21, 0.75);

}

.invLeft > .item:nth-child(n+1):nth-child(-n+5).populated .itemAmount {

	border: 1px solid #5763D0;
	background: rgba(87, 99, 208, .25);
	
}

.invLeft > .item:nth-child(1){
	background-image: url("./images/1.png");
}

.invLeft > .item:nth-child(2){
	background-image: url("./images/2.png");
}

.invLeft > .item:nth-child(3){
	background-image: url("./images/3.png");
}

.invLeft > .item:nth-child(4){
	background-image: url("./images/4.png");
}

.invLeft > .item:nth-child(5){
	background-image: url("./images/5.png");
}

.itemAmount, .invRight .item .itemWeight {

	display: grid;
	place-items: center;
	border-radius: 2.5px;
	height: 23px;
	padding: 0 6px;
	font-size: 9px;
	font-weight: 600;

}

.itemAmount {

	border: 1px solid rgba(87, 99, 208, .15);
	background: rgba(87, 99, 208, .05);
	backdrop-filter: blur(12.5px);
	transition: all .45s;

}

.invRight .item.populated:hover .itemAmount {

	border: 1px solid #5763D0;
	background: rgba(87, 99, 208, .25);

}

.itemWeight {
	
	font-size: 9px;
	font-weight: 600;
	text-align: right;

}

.item .nameItem {

	display: flex;
	align-items: center;
	justify-content: center;
	height: 0;
	width: 100%;
	font-size: 10px;
	font-weight: 900;
	white-space: nowrap;
	text-overflow: ellipsis;
	text-transform: uppercase;
	border-radius: 0 0 5px 5px;
	background: var(--purple-color);

}

.item .durability {

	width: 85%;
	height: 2px;
	border-radius: 5px;
	margin: auto auto 6px auto;
	background-color: transparent;

}

.item .durability .bar {

	height: 100%;
	border-radius: 5px;

}

.invMiddle {

	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
	gap: 15px;
	margin: 0 16px 5rem 16px;

}

input {
	border-radius: 3px;
	text-align: center;
}

.invMiddle div, .invMiddle input {

	display: flex;
	align-items: center;
	justify-content: center;
	width: 101px;
	border: 0;
	outline: none;
	text-align: center;
	border-radius: 5px;
	border: 1px solid rgba(255, 255, 255, 0.10);
	background: linear-gradient(180deg, rgba(255, 255, 255, 0.00) -81.88%, rgba(255, 255, 255, 0.05) 100%);
	backdrop-filter: blur(12.5px);

}

.invMiddle input {

	font-size: 15px;
	font-weight: 500;
	height: 60px;
	color: var(--white-color);

}

.invMiddle div {

	font-size: 14px;
	font-weight: 700;
	height: 55px;
	cursor: pointer;

}

.ui-helper-hidden-accessible {
	display: none;
}

.ui-tooltip {

	z-index: 9999;
	font-size: 11px;
	border-radius: 5px;
	position: absolute;
	letter-spacing: 1px;
	padding: 20px 20px 15px;
	background: rgba(16, 16, 21, .85);

}

.ui-tooltip:hover {
	display: none;
}

.ui-tooltip item {

	float: left;
	font-size: 14px;
	font-weight: 700;
	min-width: 200px;
	color: var(--purple-color);
	text-transform: uppercase;

}

.ui-tooltip legenda {
	float: left;
	min-width: 225px;
	margin-top: 10px;
	padding-top: 6px;
	line-height: 20px;
}

.ui-tooltip description {
	float: left;
	font-size: 11px;
	font-weight: 600;
	max-width: 225px;
	margin-top: 5px;
}

.ui-tooltip description green {
	color: #a0ceb6;
}

.ui-tooltip s {
	color: var(--purple-color);
	padding: 0 5px;
	text-decoration: none;
}

.ui-tooltip r {
	color: var(--purple-color);
}

/* -------------------- TOPO -------------------- */


.top_header {

	display: flex;
	justify-content: space-between;
	width: 100%;

}

.left_top, .right_top {
	
	width: 648px;
	max-width: 648px;
	padding-right: 6px;
	margin-bottom: 17px;
	position: relative;

}

.right_top {

	display: flex;
	align-items: end;

}

.left_top .title {

	margin-bottom: 10px;

}

.left_top .title h1 {

	font-size: 40px;
	font-weight: 800;
	letter-spacing: 2px;

}

.left_top .weight_player {

	display: flex;
	align-items: center;
	gap: 14px;
	width: 100%;

}

.left_top .weight_player .weight {

	flex: 1;

}

.left_top .weight_player .player_info {

	display: flex;
	align-items: center;
	width: min-content;
	gap: .63rem;

}

.weight_player .player_info .border {

	width: 3px;
	height: 22px;
	border-radius: 100px;
	background: rgb(87, 99, 208);

}

.weight_player .player_info span {

	font-size: 15px;
	font-weight: 600;
	white-space: nowrap;

}

.weight_player .player_info span > span {

	/* font-style: italic; */
	font-weight: 700;

}

.weight_player .weight .weightTextLeft {

	position: absolute;
	right: 12px;
	top: 22px;

}

.weight .weightTextLeft h2 {

	font-size: 12px;
	font-weight: 800;
	text-align: right;
	width: 100%;
	margin-bottom: 5px;

}

.weight .weightTextLeft span {

	font-size: 10px;
	font-weight: 500;
	text-align: right;

}

.weight_player .weight #weightBarLeft {

	width: 100%;
	height: 13px;
	background: rgba(87, 99, 208, .25);
	border: 5px solid rgba(16, 16, 21, .75);;
	border-radius: 100px;

}

.weight #weightBarLeft .weightBar {

	height: 100%;
	border-radius: 100px;
	background: rgb(87, 99, 208);
	transition: all .25s;

}

/* ---------- RESPONSIVO ---------- */
`
var styleElement = document.createElement('style');
styleElement.innerHTML = cssString;
document.head.appendChild(styleElement);

window.onload = () => {
	renderHTML();
};

$(document).ready(() => {
	window.addEventListener("message",function(event){
		switch(event["data"]["action"]){
			case "showMenu":
				updateMochila();
				setTimeout(() => {$(".inventory").css("display","flex");}, 120);
			break;
			case "hideMenu":
				closeInv();
			break;
			case "updateMochila":
				updateMochila();
			break;
		}
	});

	document.onkeyup = data => {
		if (data["key"] === "Escape"){
			$.post("http://inventory/invClose");
			closeInv();
		}
	};

	function closeInv() {
		$(".inventory").css("display","none");
		$(".ui-tooltip").hide();
	}
});

const updateDrag = () => {
	$(".populated").draggable({
		helper: "clone",
	});

	$(".empty").droppable({
		hoverClass: "hoverControl",
		drop: function(event,ui){
			if(ui.draggable.parent()[0] == undefined) return;

			const shiftPressed = event.shiftKey;
			const origin = ui.draggable.parent()[0].className;
			if (origin === undefined) return;
			const tInv = $(this).parent()[0].className;

			if(origin === "invRight" && tInv === "invRight") return;
			
			itemData = { key: ui.draggable.data("item-key"), slot: ui.draggable.data("slot") };
			const target = $(this).data("slot");

			if (itemData.key === undefined || target === undefined) return;

			let amount = 0;
			let itemAmount = parseInt(ui.draggable.data("amount"));

			if (shiftPressed)
				amount = itemAmount;
			else if($(".amount").val() == "" | parseInt($(".amount").val()) <= 0)
				amount = 1;
			else
				amount = parseInt($(".amount").val());

			if(amount > itemAmount)
				amount = itemAmount;

			$(".populated, .empty, .use, .send, .deliver").off("draggable droppable");

			let clone1 = ui.draggable.clone();
			let slot2 = $(this).data("slot"); 

			if(amount == itemAmount) {
				let clone2 = $(this).clone();
				let slot1 = ui.draggable.data("slot");

				$(this).replaceWith(clone1);
				ui.draggable.replaceWith(clone2);
				
				$(clone1).data("slot", slot2);
				$(clone2).data("slot", slot1);
			} else {
				let newAmountOldItem = itemAmount - amount;
				let weight = parseFloat(ui.draggable.data("peso"));
				let newWeightClone1 = (amount*weight).toFixed(2);
				let newWeightOldItem = (newAmountOldItem*weight).toFixed(2);

				ui.draggable.data("amount",newAmountOldItem);

				clone1.data("amount",amount);

				$(this).replaceWith(clone1);
				$(clone1).data("slot",slot2);

				ui.draggable.children(".top").children(".itemAmount").html(formatarNumero(ui.draggable.data("amount")) + "x");
				ui.draggable.children(".top").children(".itemWeight").html(newWeightOldItem);
				
				$(clone1).children(".top").children(".itemAmount").html(formatarNumero(clone1.data("amount")) + "x");
				$(clone1).children(".top").children(".itemWeight").html(newWeightClone1);
			}

			updateDrag();

			if (origin === "invLeft" && tInv === "invLeft"){
				$.post("http://inventory/updateSlot",JSON.stringify({
					item: itemData.key,
					slot: itemData.slot,
					target: target,
					amount: parseInt(amount)
				}));
			} else if (origin === "invRight" && tInv === "invLeft"){
				const id = ui.draggable.data("id");
				$.post("http://inventory/pickupItem",JSON.stringify({
					id: id,
					target: target,
					amount: parseInt(amount)
				}));
			} else if (origin === "invLeft" && tInv === "invRight"){
				$.post("http://inventory/dropItem",JSON.stringify({
					item: itemData.key,
					slot: itemData.slot,
					amount: parseInt(amount)
				}));
			}

			$(".amount").val("");
		}
	});

	$(".populated").droppable({
		hoverClass: "hoverControl",
		drop: function(event,ui){
			if(ui.draggable.parent()[0] == undefined) return;

			const shiftPressed = event.shiftKey;
			const origin = ui.draggable.parent()[0].className;
			if (origin === undefined) return;
			const tInv = $(this).parent()[0].className;

			if(origin === "invRight" && tInv === "invRight") return;

			itemData = { key: ui.draggable.data("item-key"), slot: ui.draggable.data("slot") };
			const target = $(this).data("slot");

			if (itemData.key === undefined || target === undefined) return;

			let amount = 0;
			let itemAmount = parseInt(ui.draggable.data("amount"));

			if (shiftPressed)
				amount = itemAmount;
			else if($(".amount").val() == "" | parseInt($(".amount").val()) <= 0)
				amount = 1;
			else
				amount = parseInt($(".amount").val());

			if(amount > itemAmount)
				amount = itemAmount;

			$(".populated, .empty, .use, .send, .deliver").off("draggable droppable");

			if(ui.draggable.data("item-key") == $(this).data("item-key")){
				let newSlotAmount = amount + parseInt($(this).data("amount"));
				let newSlotWeight = ui.draggable.data("peso") * newSlotAmount;

				$(this).data("amount",newSlotAmount);
				$(this).children(".top").children(".itemAmount").html(formatarNumero(newSlotAmount) + "x");
				$(this).children(".top").children(".itemWeight").html(newSlotWeight.toFixed(2));

				if(amount == itemAmount) {
					ui.draggable.replaceWith(`<div class="item empty" data-slot="${ui.draggable.data("slot")}"></div>`);
				} else {
					let newMovedAmount = itemAmount - amount;
					let newMovedWeight = parseFloat(ui.draggable.data("peso")) * newMovedAmount;

					ui.draggable.data("amount",newMovedAmount);
					ui.draggable.children(".top").children(".itemAmount").html(formatarNumero(newMovedAmount) + "x");
					ui.draggable.children(".top").children(".itemWeight").html(newMovedWeight.toFixed(2));
				}
			} else {
				if (origin === "invRight" && tInv === "invLeft") return;

				let clone1 = ui.draggable.clone();
				let clone2 = $(this).clone();

				let slot1 = ui.draggable.data("slot");
				let slot2 = $(this).data("slot");

				ui.draggable.replaceWith(clone2);
				$(this).replaceWith(clone1);

				$(clone1).data("slot",slot2);
				$(clone2).data("slot",slot1);
			}

			updateDrag();

			if (origin === "invLeft" && tInv === "invLeft") {
				$.post("http://inventory/updateSlot",JSON.stringify({
					item: itemData.key,
					slot: itemData.slot,
					target: target,
					amount: parseInt(amount)
				}));
			} else if (origin === "invRight" && tInv === "invLeft"){
				const id = ui.draggable.data("id");
				$.post("http://inventory/pickupItem",JSON.stringify({
					id: id,
					target: target,
					amount: parseInt(amount)
				}));
			} else if (origin === "invLeft" && tInv === "invRight"){
				$.post("http://inventory/dropItem",JSON.stringify({
					item: itemData.key,
					slot: itemData.slot,
					amount: parseInt(amount)
				}));
			}

			$(".amount").val("");
		}
	});

	$(".use").droppable({
		hoverClass: "hoverControl",
		drop: function(event,ui){
			if(ui.draggable.parent()[0] == undefined) return;

			const shiftPressed = event.shiftKey;
			const origin = ui.draggable.parent()[0].className;
			if (origin === undefined || origin === "invRight") return;
			itemData = { key: ui.draggable.data("item-key"), slot: ui.draggable.data("slot") };

			if (itemData.key === undefined) return;

			let amount = $(".amount").val();
			if (shiftPressed) amount = ui.draggable.data("amount");

			$.post("http://inventory/useItem",JSON.stringify({
				slot: itemData.slot,
				amount: parseInt(amount)
			}));

			$(".amount").val("");
		}
	});

	$(".send").droppable({
		hoverClass: "hoverControl",
		drop: function(event,ui){
			if(ui.draggable.parent()[0] == undefined) return;

			const shiftPressed = event.shiftKey;
			const origin = ui.draggable.parent()[0].className;
			if (origin === undefined || origin === "invRight") return;
			itemData = { key: ui.draggable.data("item-key"), slot: ui.draggable.data("slot") };

			if (itemData.key === undefined) return;

			let amount = $(".amount").val();
			if (shiftPressed) amount = ui.draggable.data("amount");

			$.post("http://inventory/sendItem",JSON.stringify({
				slot: itemData.slot,
				amount: parseInt(amount)
			}));

			$(".amount").val("");
		}
	});

	$(".deliver").droppable({
		hoverClass: "hoverControl",
		drop: function(event,ui){
			if(ui.draggable.parent()[0] == undefined) return;

			const shiftPressed = event.shiftKey;
			const origin = ui.draggable.parent()[0].className;
			if (origin === undefined || origin === "invRight") return;
			itemData = { key: ui.draggable.data("item-key"), slot: ui.draggable.data("slot") };

			if (itemData.key === undefined) return;

			let amount = $(".amount").val();
			if (shiftPressed) amount = ui.draggable.data("amount");

			$.post("http://inventory/Deliver",JSON.stringify({
				slot: itemData.slot,
				amount: parseInt(amount)
			}));

			$(".amount").val("");
		}
	});

	$(".populated").on("auxclick", e => {
		if (e["which"] === 3){
			const item = e["target"];
			const shiftPressed = event.shiftKey;
			const origin = $(item).parent()[0].className;
			if (origin === undefined || origin === "invRight") return;

			itemData = { key: $(item).data("item-key"), slot: $(item).data("slot") };

			if (itemData.key === undefined) return;

			let amount = $(".amount").val();
			if (shiftPressed) amount = $(item).data("amount");

			$.post("http://inventory/useItem",JSON.stringify({
				slot: itemData.slot,
				amount: parseInt(amount)
			}));
		}
	});

	$(".populated").tooltip({
		create: function(event,ui){
			var max = $(this).attr("data-max");
			var type = $(this).attr("data-type");
			var name = $(this).attr("data-name-key");
			var description = $(this).attr("data-description");
			var content = `<item>${name}</item>${description !== "undefined" ? "<br><description>"+description+"</description>":""}<br><legenda>Tipo: <r>${type}</r> <s>|</s> Máximo: <r>${max !== "undefined" ? max:"S/L"}</r></legenda>`

			if (name == "Passaporte" || name == "Distintivo"){
				var idName = $(this).attr("data-idName");
				var idPhone = $(this).attr("data-idPhone");
				var idBlood = $(this).attr("data-idBlood");
				var Passport = $(this).attr("data-Passport");

				content = `<item>${name} - ${Passport}</item><br><legenda>Nome: <r>${idName}</r><br>Tipo Sangüineo: <r>${idBlood}</r><br>Telefone: <r>${idPhone}</r></legenda>`
			}

			$(this).tooltip({
				content,
				position: { my: "center top+10", at: "center bottom", collision: "flipfit" },
				show: { duration: 10 },
				hide: { duration: 10 }
			});
		}
	});
}

const colorPicker = (percent) => {
	var colorPercent = "#5763D0";

	if (percent >= 100) {
		colorPercent = "transparent";
	}

	// if (percent >= 51 && percent <= 75)
	// 	colorPercent = "#fcc458";

	if (percent >= 26 && percent <= 50)
		colorPercent = "#fc8a58";

	if (percent <= 25)
		colorPercent = "#fc5858";

	return colorPercent;
}

const updateMochila = () => {
	$.post("http://inventory/requestInventory",JSON.stringify({}),(data) => {
		$("#weightText").html(`${(data["invPeso"]).toFixed(2)} / ${(data["invMaxpeso"]).toFixed(2) + "KG"}`);
		$("#backend_info").html(`
		${data["name"]} <span>#${data["id"]}</span>
		`)
		$("#weightBarLeft").html(`
			<div class="weightBar" style="width: ${data["invPeso"] / data["invMaxpeso"] * 100}%"></div>
		`);
		$(".invLeft").html("");
		$(".invRight").html("");

		if (data["invMaxpeso"] > 100)
			data["invMaxpeso"] = 100;

		const nameList2 = data["drop"].sort((a,b) => (a["name"] > b["name"]) ? 1:-1);

		for (let x = 1; x <= data["invMaxpeso"]; x++){
			const slot = x.toString();

			if (data["inventario"][slot] !== undefined){
				const v = data["inventario"][slot];
				const maxDurability = 86400 * v["days"];
				const newDurability = (maxDurability - v["durability"]) / maxDurability;
				var actualPercent = parseInt(newDurability * 100);

				if (actualPercent <= 1)
					actualPercent = 1;

				const item = `
					<div class="item populated" title="" data-max="${v["max"]}" data-type="${v["type"]}" data-description="${v["desc"]}" style="background-image: url('images/${v["index"]}.png'); background-position: center; background-repeat: no-repeat;" data-amount="${v["amount"]}" data-peso="${v["peso"]}" data-item-key="${v["key"]}" data-name-key="${v["name"]}" data-slot="${slot}" data-idName="${v["idName"]}" data-idBlood="${v["idBlood"]}" data-idVality="${v["idVality"]}" data-idRolepass="${v["idRolepass"]}" data-Suitcase="${v["Suitcase"]}" data-Vehkey="${v["Vehkey"]}" data-Passport="${v["Passport"]}" data-idPhone="${v["idPhone"]}">
						<div class="top">
							<div class="itemAmount">${formatarNumero(v["amount"])}x</div>
							<div class="itemWeight">${(v["peso"] * v["amount"]).toFixed(2) + "KG"}</div>
						</div>

						<div class="durability">
							<div class="bar" style="width: ${actualPercent == 1 ? "100":actualPercent}%; background: ${actualPercent == 1 ? "#5763D0":colorPicker(actualPercent)};"></div>
						</div>
						<div class="nameItem">${v["name"]}</div>
					</div>
				`;

				$(".invLeft").append(item);
			} else {
				const item = `<div class="item empty" data-slot="${slot}"></div>`;

				$(".invLeft").append(item);
			}
		}

		for (let x = 1; x <= 20; x++){
			const slot = x.toString();

			if (nameList2[x - 1] !== undefined){
				const v = nameList2[x - 1];
				const maxDurability = 86400 * v["days"];
				const newDurability = (maxDurability - v["durability"]) / maxDurability;
				var actualPercent = newDurability * 100;

				if (actualPercent <= 1)
					actualPercent = 1;

				const item = `<div class="item populated" style="background-image: url('nui://inventory/web-side/images/${v["index"]}.png'); background-position: center; background-repeat: no-repeat;" data-item-key="${v["key"]}" data-id="${v["id"]}" data-amount="${v["amount"]}" data-peso="${v["peso"]}" data-slot="${slot}">
					<div class="top">
					<div class="itemAmount">${formatarNumero(v["amount"])}x</div>
						<div class="itemWeight">${(v["peso"] * v["amount"]).toFixed(2) + "KG"}</div>
					</div>

					<div class="durability">
						<div class="bar" style="width: ${actualPercent == 1 ? "100":actualPercent}%; background: ${actualPercent == 1 ? "#5763D0":colorPicker(actualPercent)};"></div>
					</div>
					<div class="nameItem">${v["name"]}</div>
				</div>`;

				$(".invRight").append(item);
			} else {
				const item = `<div class="item empty" data-slot="${slot}"></div>`;

				$(".invRight").append(item);
			}
		}

		updateDrag();
	});
}
/* ----------CRAFT---------- */
$(document).on("click",".craft",function(e){
	$.post("http://inventory/Craft");
});
/* ----------FORMATARNUMERO---------- */
const formatarNumero = n => {
	var n = n.toString();
	var r = "";
	var x = 0;

	for (var i = n["length"]; i > 0; i--) {
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? "." : "");
		x = x == 2 ? 0 : x + 1;
	}

	return r.split("").reverse().join("");
}

function renderHTML() {
	$(".inventory").html(`
		<div class="innerInventory">
			<div class="top_header">
				<div class="left_top">	
					<div class="title">
						<h1>SEU INVENTÁRIO</h1>
					</div>
					<div class="weight_player">
						<div class="player_info">
							<div class="border"></div>
							<span id="backend_info">Felipe Gonçalves <span>#63</span></span>
						</div>
						<div class="weight">
							<div class="weightTextLeft">
								<h2>PESO</h2>
								<span id="weightText"></span>
							</div>
							<div id="weightBarLeft"></div>
						</div>
					</div>
				</div>
				<div class="right_top">	
					<div class="title">
						<h1>CHÃO</h1>
					</div>
				</div>
			</div>

			<div class="sections">
				<div class="invLeft"></div>
				<div class="invMiddle">
					<input class="amount" placeholder="QTD" type="number" onKeyPress="if(this.value.length==9) return false;" maxlength="9" />
					<div class="use">USAR</div>
					<div class="send">ENVIAR</div>
				</div>
				<div class="invRight"></div>
			</div>
		</div>
	`)
}