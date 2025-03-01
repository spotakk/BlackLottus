var styleElement = document.createElement("style");
styleElement.innerHTML = "\n:root {\n\n\t--white-color: rgb(255, 255, 255);\n\t--purple-color: #5763D0;\n\n}\n\n* {\n\t\n\toverflow: hidden;\n\tbox-sizing: border-box;\n\tuser-select: none;\n\n}\n\nbody {\n\t\n\tmargin: 0;\n\tpadding: 0;\n\tcolor: var(--white-color);\n\tfont-family: \"Inter\", sans-serif;\n\tfont-optical-sizing: auto;\n\tfont-weight: normal;\n\tfont-style: normal;\n\n}\n\n/* ------------------- SCROLL ------------------- */\n\n*::-webkit-scrollbar { \n\twidth: 3px;\n}\n\n*::-webkit-scrollbar-track { \n\tbackground: rgba(87, 99, 208, .1);\n\tborder-radius: 100px;\n}\n\n*::-webkit-scrollbar-thumb { \n\tbackground: rgb(87, 99, 208);\n\tborder-radius: 100px;\n}\n\ninput::-webkit-outer-spin-button,\ninput::-webkit-inner-spin-button { -webkit-appearance: none; }\n\n/* --------------------------------------------- */\n\n/* ------------------- RESET ------------------- */\n\nh1, h2, h3 {\n\n\tmargin: 0;\n\n}\n\n/* --------------------------------------------- */\n\n.inventory {\n\t\n\twidth: 100vw;\n\theight: 100vh;\n\tdisplay: none;\n\tposition: fixed;\n\talign-items: center;\n\tjustify-content: center;\n\tflex-direction: column;\n\tbackground-image: url('nui://inventory/web-side/images/bg.png');\n\tbackground-size: 100%;\n\n}\n\n.innerInventory {\n\tdisplay: flex;\n\tflex-direction: column;\n}\n\n.sections {\n\n\tdisplay: flex;\n\theight: 652px;\n\tmax-height: 652px;\n\n}\n\n.invLeft, .invRight {\n\n\tdisplay: grid;\n\tgrid-template-columns: repeat(5, 1fr);\n\tgap: 4px;\n\toverflow-y: scroll;\n\tpadding-right: 10px;\n\t\n}\n\n.item {\n\t\n\twidth: 125px;\n\theight: 160px;\n\tdisplay: flex;\n\tflex-direction: column;\n\tborder-radius: 5px;\n\tbackground: rgba(16, 16, 21, .2);\n\tposition: relative;\n\tcursor: pointer;\n\n}\n\n.populated {\n\n\tbackground-size: 86% !important;\n\n}\n\n.populated .nameItem {\n\n\tposition: absolute;\n\theight: 0;\n\tleft: 0;\n\tbottom: -60%;\n\ttransition: all .45s ease-in-out;\n\n}\n\n.populated:hover .nameItem {\n\n\theight: 26px;\n\tbottom: 0;\n\tposition: relative;\n\n}\n\n.hoverControl {\n\n\tbackground: rgba(16, 16, 21, .6)\n\n}\n\n.item .top {\n\n\tdisplay: flex;\n\tjustify-content: space-between;\n\talign-items: center;\n\tmargin: 10px 10px 0 10px;\n\tfont-size: .7rem;\n\n}\n\n.invLeft > .item:nth-child(n+1):nth-child(-n+5) .nameItem, .invRight .item .nameItem {\n\n\tposition: relative;\n\theight: 26px;\n\tbottom: 0;\n\n}\n\n.invLeft > .item:nth-child(n+1):nth-child(-n+5) {\n\n\tbackground-color: rgba(255, 255, 255, .01);\n\tbackground-repeat: no-repeat;\n\tbackground-position: center;\n\n}\n\n.invLeft > .item:nth-child(n+1):nth-child(-n+5).populated, .invRight .populated {\n\n\tbackground: rgba(16, 16, 21, 0.75);\n\n}\n\n.invLeft > .item:nth-child(n+1):nth-child(-n+5).populated .itemAmount {\n\n\tborder: 1px solid #5763D0;\n\tbackground: rgba(87, 99, 208, .25);\n\t\n}\n\n.invLeft > .item:nth-child(1){\n\tbackground-image: url('nui://inventory/web-side/images/1.png');\n}\n\n.invLeft > .item:nth-child(2){\n\tbackground-image: url('nui://inventory/web-side/images/2.png');;\n}\n\n.invLeft > .item:nth-child(3){\n\tbackground-image: url('nui://inventory/web-side/images/3.png');;\n}\n\n.invLeft > .item:nth-child(4){\n\tbackground-image: url('nui://inventory/web-side/images/4.png');;\n}\n\n.invLeft > .item:nth-child(5){\n\tbackground-image: url('nui://inventory/web-side/images/5.png');;\n}\n\n.itemAmount, .invRight .item .itemWeight {\n\n\tdisplay: grid;\n\tplace-items: center;\n\tborder-radius: 2.5px;\n\theight: 23px;\n\tpadding: 0 6px;\n\tfont-size: 9px;\n\tfont-weight: 600;\n\n}\n\n.itemAmount {\n\n\tborder: 1px solid rgba(87, 99, 208, .15);\n\tbackground: rgba(87, 99, 208, 0.05);\n\tbackdrop-filter: blur(12.5px);\n\n}\n\n.invRight .item .itemWeight {\n\n\tborder: 1px solid #5763D0;\n\tbackground: rgba(87, 99, 208, 0.25);\n\tbackdrop-filter: blur(12.5px);\n\n}\n\n.itemWeight, .invRight .item .itemPrice {\n\t\n\tfont-size: 9px;\n\tfont-weight: 600;\n\ttext-align: right;\n\n}\n\n.item .nameItem {\n\n\tdisplay: flex;\n\talign-items: center;\n\tjustify-content: center;\n\theight: 0;\n\twidth: 100%;\n\tfont-size: 10px;\n\tfont-weight: 900;\n\twhite-space: nowrap;\n\ttext-overflow: ellipsis;\n\ttext-transform: uppercase;\n\tborder-radius: 0 0 5px 5px;\n\tbackground: var(--purple-color);\n\n}\n\n.item .durability {\n\n\twidth: 85%;\n\theight: 2px;\n\tborder-radius: 5px;\n\tmargin: auto auto 6px auto;\n\tbackground-color: transparent;\n\n}\n\n.item .durability .bar {\n\n\theight: 100%;\n\tborder-radius: 5px;\n\n}\n\n.invMiddle {\n\n\tdisplay: flex;\n\talign-items: center;\n\tjustify-content: center;\n\tflex-direction: column;\n\tgap: 15px;\n\tmargin: 0 16px 5rem 16px;\n\n}\n\ninput {\n\tborder-radius: 3px;\n\ttext-align: center;\n}\n\n.invMiddle div, .invMiddle input {\n\n\tdisplay: flex;\n\talign-items: center;\n\tjustify-content: center;\n\twidth: 101px;\n\tborder: 0;\n\toutline: none;\n\ttext-align: center;\n\tborder-radius: 5px;\n\tborder: 1px solid rgba(255, 255, 255, 0.10);\n\tbackground: linear-gradient(180deg, rgba(255, 255, 255, 0.00) -81.88%, rgba(255, 255, 255, 0.05) 100%);\n\tbackdrop-filter: blur(12.5px);\n\n}\n\n.invMiddle input {\n\n\tfont-size: 15px;\n\tfont-weight: 500;\n\theight: 60px;\n\tcolor: var(--white-color);\n\n}\n\n.invMiddle div {\n\n\tfont-size: 14px;\n\tfont-weight: 700;\n\theight: 55px;\n\tcursor: pointer;\n\n}\n\n.ui-helper-hidden-accessible {\n\tdisplay: none;\n}\n\n.ui-tooltip {\n\n\tz-index: 9999;\n\tfont-size: 11px;\n\tborder-radius: 5px;\n\tposition: absolute;\n\tletter-spacing: 1px;\n\tpadding: 20px 20px 15px;\n\tbackground: rgba(16, 16, 21, .85);\n\n}\n\n.ui-tooltip:hover {\n\tdisplay: none;\n}\n\n.ui-tooltip item {\n\n\tfloat: left;\n\tfont-size: 14px;\n\tfont-weight: 700;\n\tmin-width: 200px;\n\tcolor: var(--purple-color);\n\ttext-transform: uppercase;\n\n}\n\n.ui-tooltip legenda {\n\tfloat: left;\n\tmin-width: 225px;\n\tmargin-top: 10px;\n\tpadding-top: 6px;\n\tline-height: 20px;\n}\n\n.ui-tooltip description {\n\tfloat: left;\n\tfont-size: 11px;\n\tfont-weight: 600;\n\tmax-width: 225px;\n\tmargin-top: 5px;\n}\n\n.ui-tooltip description green {\n\tcolor: #a0ceb6;\n}\n\n.ui-tooltip s {\n\tcolor: var(--purple-color);\n\tpadding: 0 5px;\n\ttext-decoration: none;\n}\n\n.ui-tooltip r {\n\tcolor: var(--purple-color);\n}\n\n/* -------------------- TOPO -------------------- */\n\n.top_header {\n\n\tdisplay: flex;\n\tjustify-content: space-between;\n\twidth: 100%;\n\n}\n\n.left_top, .right_top {\n\t\n\twidth: 648px;\n\tmax-width: 648px;\n\tpadding-right: 6px;\n\tmargin-bottom: 17px;\n\tposition: relative;\n\n}\n\n.right_top {\n\n\tdisplay: flex;\n\talign-items: end;\n\n}\n\n.left_top .title {\n\n\tmargin-bottom: 10px;\n\n}\n\n.left_top .title h1 {\n\n\tfont-size: 40px;\n\tfont-weight: 800;\n\tletter-spacing: 2px;\n\n}\n\n.left_top .weight_player {\n\n\tdisplay: flex;\n\talign-items: center;\n\tgap: 14px;\n\twidth: 100%;\n\n}\n\n.left_top .weight_player .weight {\n\n\tflex: 1;\n\n}\n\n.left_top .weight_player .player_info {\n\n\tdisplay: flex;\n\talign-items: center;\n\twidth: min-content;\n\tgap: .63rem;\n\n}\n\n.right_top .title h1 {\n\n\tfont-size: 40px;\n\tfont-weight: 800;\n\tletter-spacing: 2px;\n\n}\n\n.weight_player .player_info .border {\n\n\twidth: 3px;\n\theight: 22px;\n\tborder-radius: 100px;\n\tbackground: rgb(87, 99, 208);\n\n}\n\n.weight_player .player_info span {\n\n\tfont-size: 15px;\n\tfont-weight: 600;\n\twhite-space: nowrap;\n\n}\n\n.weight_player .player_info span > span {\n\n\t/* font-style: italic; */\n\tfont-weight: 700;\n\n}\n\n.weight_player .weight .weightTextLeft {\n\n\tposition: absolute;\n\tright: 12px;\n\ttop: 22px;\n\n}\n\n.weight .weightTextLeft h2 {\n\n\tfont-size: 12px;\n\tfont-weight: 800;\n\ttext-align: right;\n\twidth: 100%;\n\tmargin-bottom: 5px;\n\n}\n\n.weight .weightTextLeft span {\n\n\tfont-size: 10px;\n\tfont-weight: 500;\n\ttext-align: right;\n\n}\n\n.weight_player .weight #weightBarLeft {\n\n\twidth: 100%;\n\theight: 13px;\n\tbackground: rgba(87, 99, 208, .25);\n\tborder: 5px solid rgba(16, 16, 21, .75);;\n\tborder-radius: 100px;\n\n}\n\n.weight #weightBarLeft .weightBar {\n\n\theight: 100%;\n\tborder-radius: 100px;\n\tbackground: rgb(87, 99, 208);\n\ttransition: all .25s;\n\n}\n\n/* ---------- SHOP ----------";
document.head.appendChild(styleElement);
var selectShop = 'selectShop';
var selectType = "Buy";
window.onload = () => {
  renderHTML();
};
$(document).ready(function() {
  window.addEventListener("message", function(_0x18eead) {
    switch (_0x18eead.data.action) {
      case "showNUI":
        selectShop = _0x18eead.data.name;
        selectType = _0x18eead.data.type;
        setTimeout(() => {
          $(".inventory").css("display", "flex");
        }, 0x78);
        requestShop();
        break;
      case "hideNUI":
        $('.inventory').css("display", "none");
        $(".ui-tooltip").hide();
        break;
      case "requestShop":
        requestShop();
        break;
    }
  });
  document.onkeyup = _0x2e9326 => {
    if (_0x2e9326.key === 'Escape') {
      $.post('http://shops/close');
      $('.invRight').html('');
      $(".invLeft").html('');
    }
  };
});
const updateDrag = () => {
  $(".populated").draggable({
    'helper': 'clone'
  });
  $(".empty").droppable({
    'hoverClass': 'hoverControl',
    'drop': function(_0x43356f, _0x47a9e1) {
      if (_0x47a9e1.draggable.parent()[0x0] == undefined) {
        return;
      }
      const _0x4c8578 = _0x43356f.shiftKey;
      const _0x5cf452 = _0x47a9e1.draggable.parent()[0x0].className;
      if (_0x5cf452 === undefined) {
        return;
      }
      const _0x164fd9 = $(this).parent()[0x0].className;
      itemData = {
        'key': _0x47a9e1.draggable.data("item-key"),
        'slot': _0x47a9e1.draggable.data("slot")
      };
      const _0x2c6bdb = $(this).data('slot');
      if (itemData.key === undefined || _0x2c6bdb === undefined) {
        return;
      }
      let _0x119a21 = $(".amount").val();
      if (_0x4c8578) {
        _0x119a21 = _0x47a9e1.draggable.data("amount");
      }
      if (_0x164fd9 === "invLeft") {
        if (_0x5cf452 === "invLeft") {
          $.post('http://shops/populateSlot', JSON.stringify({
            'item': itemData.key,
            'slot': itemData.slot,
            'target': _0x2c6bdb,
            'amount': parseInt(_0x119a21)
          }));
          $(".amount").val('');
        } else if (_0x5cf452 === 'invRight') {
          $.post("http://shops/functionShops", JSON.stringify({
            'shop': selectShop,
            'item': itemData.key,
            'slot': _0x2c6bdb,
            'amount': parseInt(_0x119a21)
          }));
          $(".amount").val('');
        }
      } else if (_0x164fd9 === "invRight") {
        if (_0x5cf452 === "invLeft" && selectType === 'Sell') {
          $.post("http://shops/functionShops", JSON.stringify({
            'shop': selectShop,
            'item': itemData.key,
            'slot': itemData.slot,
            'amount': parseInt(_0x119a21)
          }));
          $(".amount").val('');
        }
      }
    }
  });
  $('.populated').droppable({
    'hoverClass': "hoverControl",
    'drop': function(_0xd36536, _0x1f0055) {
      if (_0x1f0055.draggable.parent()[0x0] == undefined) {
        return;
      }
      const _0x42e1f4 = _0xd36536.shiftKey;
      const _0xd8ca7b = _0x1f0055.draggable.parent()[0x0].className;
      if (_0xd8ca7b === undefined) {
        return;
      }
      const _0x5b21d0 = $(this).parent()[0x0].className;
      itemData = {
        'key': _0x1f0055.draggable.data("item-key"),
        'slot': _0x1f0055.draggable.data("slot")
      };
      const _0x296aab = $(this).data("slot");
      if (itemData.key === undefined || _0x296aab === undefined) {
        return;
      }
      let _0x579d7b = $(".amount").val();
      if (_0x42e1f4) {
        _0x579d7b = _0x1f0055.draggable.data("amount");
      }
      if (_0x5b21d0 === "invLeft") {
        if (_0xd8ca7b === "invLeft") {
          $.post("http://shops/updateSlot", JSON.stringify({
            'item': itemData.key,
            'slot': itemData.slot,
            'target': _0x296aab,
            'amount': parseInt(_0x579d7b)
          }));
          $('.amount').val('');
        } else if (_0xd8ca7b === "invRight") {
          $.post("http://shops/functionShops", JSON.stringify({
            'shop': selectShop,
            'item': itemData.key,
            'slot': _0x296aab,
            'amount': parseInt(_0x579d7b)
          }));
          $(".amount").val('');
        }
      } else if (_0x5b21d0 === 'invRight') {
        if (_0xd8ca7b === "invLeft" && selectType === "Sell") {
          $.post("http://shops/functionShops", JSON.stringify({
            'shop': selectShop,
            'item': itemData.key,
            'slot': itemData.slot,
            'amount': parseInt(_0x579d7b)
          }));
          $(".amount").val('');
        }
      }
    }
  });
  $(".populated").tooltip({
    'create': function(_0x2e586a, _0x3fa40a) {
      var _0x3eb4b2 = $(this).attr('data-max');
      var _0x32095d = $(this).attr('data-type');
      var _0x20f7c6 = $(this).attr("data-name-key");
      var _0x3622d0 = $(this).attr("data-description");
      $(this).tooltip({
        'content': "<item>" + _0x20f7c6 + '</item>' + (_0x3622d0 !== "undefined" ? "<br><description>" + _0x3622d0 + "</description>" : '') + "<br><legenda>Tipo: <r>" + _0x32095d + "</r> <s>|</s> Máximo: <r>" + (_0x3eb4b2 !== 'undefined' ? _0x3eb4b2 : 'S/L') + "</r></legenda>",
        'position': {
          'my': "center top+10",
          'at': "center bottom",
          'collision': 'flipfit'
        },
        'show': {
          'duration': 0xa
        },
        'hide': {
          'duration': 0xa
        }
      });
    }
  });
};
const formatarNumero = _0x13348c => {
  var _0x13348c = _0x13348c.toString();
  var _0x2c426f = '';
  var _0x28fa8a = 0x0;
  for (var _0x19fbeb = _0x13348c.length; _0x19fbeb > 0x0; _0x19fbeb--) {
    _0x2c426f += _0x13348c.substr(_0x19fbeb - 0x1, 0x1) + (_0x28fa8a == 0x2 && _0x19fbeb != 0x1 ? '.' : '');
    _0x28fa8a = _0x28fa8a == 0x2 ? 0x0 : _0x28fa8a + 0x1;
  }
  return _0x2c426f.split('').reverse().join('');
};
const colorPicker = _0x2557e8 => {
  var _0x308103 = "#5763D0";
  if (_0x2557e8 >= 0x64) {
    _0x308103 = "transparent";
  }
  if (_0x2557e8 >= 0x1a && _0x2557e8 <= 0x32) {
    _0x308103 = '#fc8a58';
  }
  if (_0x2557e8 <= 0x19) {
    _0x308103 = "#fc5858";
  }
  return _0x308103;
};
const requestShop = () => {
  $.post("http://shops/requestShop", JSON.stringify({
    'shop': selectShop
  }), _0xcba4bc => {
    $("#weightText").html(_0xcba4bc.invPeso.toFixed(0x2) + " / " + (_0xcba4bc.invMaxpeso.toFixed(0x2) + 'KG'));
    $('#backend_info').html("\n\t\t" + _0xcba4bc.name + " <span>#" + _0xcba4bc.id + "</span>\n\t\t");
    $("#weightBarLeft").html("\n\t\t\t<div class=\"weightBar\" style=\"width: " + _0xcba4bc.invPeso / _0xcba4bc.invMaxpeso * 0x64 + "%\"></div>\n\t\t");
    $(".invLeft").html('');
    $('.invRight').html('');
    if (_0xcba4bc.invMaxpeso > 0x64) {
      _0xcba4bc.invMaxpeso = 0x64;
    }
    for (let _0x3c58d1 = 0x1; _0x3c58d1 <= _0xcba4bc.invMaxpeso; _0x3c58d1++) {
      const _0x552ddf = _0x3c58d1.toString();
      if (_0xcba4bc.inventoryUser[_0x552ddf] !== undefined) {
        const _0x3362ac = _0xcba4bc.inventoryUser[_0x552ddf];
        const _0x58bcce = 0x15180 * _0x3362ac.days;
        const _0x49cf1e = (_0x58bcce - _0x3362ac.durability) / _0x58bcce;
        var _0x27544f = _0x49cf1e * 0x64;
        if (_0x27544f <= 0x1) {
          _0x27544f = 0x1;
        }
        const _0xfd0883 = "<div class=\"item populated\" data-max=\"" + _0x3362ac.max + "\" data-type=\"" + _0x3362ac.type + "\" data-description=\"" + _0x3362ac.desc + "\" style=\"background-image: url('nui://inventory/web-side/images/" + _0x3362ac.index + ".png'); background-position: center; background-repeat: no-repeat;\" data-item-key=\"" + _0x3362ac.key + "\" data-name-key=\"" + _0x3362ac.name + "\" data-peso=\"" + _0x3362ac.peso + "\" data-amount=\"" + _0x3362ac.amount + "\" data-slot=\"" + _0x552ddf + "\">\n\t\t\t\t\t<div class=\"top\">\n\t\t\t\t\t\t<div class=\"itemAmount\">" + formatarNumero(_0x3362ac.amount) + "x</div>\n\t\t\t\t\t\t<div class=\"itemWeight\">" + ((_0x3362ac.peso * _0x3362ac.amount).toFixed(0x2) + 'KG') + "</div>\n\t\t\t\t\t</div>\n\n\t\t\t\t\t<div class=\"durability\">\n\t\t\t\t\t\t<div class=\"bar\" style=\"width: " + (_0x27544f == 0x1 ? '100' : _0x27544f) + "%; background: " + (_0x27544f == 0x1 ? "#5763D0" : colorPicker(_0x27544f)) + ";\"></div>\n\t\t\t\t\t</div>\n\t\t\t\t\t<div class=\"nameItem\">" + _0x3362ac.name + "</div>\n\t\t\t\t</div>";
        $('.invLeft').append(_0xfd0883);
      } else {
        const _0x3b202c = "<div class=\"item empty\" data-slot=\"" + _0x552ddf + "\"></div>";
        $('.invLeft').append(_0x3b202c);
      }
    }
    const _0x4b68f9 = _0xcba4bc.inventoryShop.sort((_0xc3c6b9, _0x5cd2d4) => _0xc3c6b9.name > _0x5cd2d4.name ? 0x1 : -0x1);
    for (let _0x181901 = 0x1; _0x181901 <= _0xcba4bc.shopSlots; _0x181901++) {
      const _0x2aea63 = _0x181901.toString();
      if (_0x4b68f9[_0x181901 - 0x1] !== undefined) {
        const _0x1dbef8 = _0x4b68f9[_0x181901 - 0x1];
        const _0x124219 = "<div class=\"item populated\" title=\"\" data-max=\"" + _0x1dbef8.max + "\" data-type=\"" + _0x1dbef8.type + "\" data-description=\"" + _0x1dbef8.desc + "\" style=\"background-image: url('nui://inventory/web-side/images/" + _0x1dbef8.index + ".png'); background-position: center; background-repeat: no-repeat;\" data-item-key=\"" + _0x1dbef8.key + "\" data-name-key=\"" + _0x1dbef8.name + "\" data-price=\"" + _0x1dbef8.price + "\" data-peso=\"" + _0x1dbef8.peso + "\" data-slot=\"" + _0x2aea63 + "\">\n\t\t\t\t\t<div class=\"top\">\n\t\t\t\t\t\t<div class=\"itemWeight\">" + (_0x1dbef8.peso.toFixed(0x2) + 'KG') + "</div>\n\t\t\t\t\t\t<div class=\"itemPrice\">$" + formatarNumero(_0x1dbef8.price) + "</div>\n\t\t\t\t\t</div>\n\n\t\t\t\t\t<div class=\"durability\" style=\"background: transparent;\">\n\t\t\t\t\t\t<div class=\"bar\" style=\"background: transparent;\"></div>\n\t\t\t\t\t</div>\n\t\t\t\t\t<div class=\"nameItem\">" + _0x1dbef8.name + "</div>\n\t\t\t\t</div>";
        $(".invRight").append(_0x124219);
      } else {
        const _0x4795d9 = "<div class=\"item empty\" data-slot=\"" + _0x2aea63 + "\"></div>";
        $(".invRight").append(_0x4795d9);
      }
    }
    updateDrag();
  });
};

function somenteNumeros(_0xa8e31f) {
  var _0xe5a072 = _0xa8e31f.charCode ? _0xa8e31f.charCode : _0xa8e31f.keyCode;
  if (_0xe5a072 != 0x8 && _0xe5a072 != 0x9) {
    var _0x543657 = $(".amount").val();
    if (_0xe5a072 < 0x30 || _0xe5a072 > 0x39 || _0x543657.length >= 0x9) {
      return false;
    }
  }
}

function renderHTML() {
  $(".inventory").html("\n\t\t<div class=\"innerInventory\">\n\t\t\t<div class=\"top_header\">\n\t\t\t\t<div class=\"left_top\">\t\n\t\t\t\t\t<div class=\"title\">\n\t\t\t\t\t\t<h1>SEU INVENTÁRIO</h1>\n\t\t\t\t\t</div>\n\t\t\t\t\t<div class=\"weight_player\">\n\t\t\t\t\t\t<div class=\"player_info\">\n\t\t\t\t\t\t\t<div class=\"border\"></div>\n\t\t\t\t\t\t\t<span id=\"backend_info\">Felipe Gonçalves <span>#63</span></span>\n\t\t\t\t\t\t</div>\n\t\t\t\t\t\t<div class=\"weight\">\n\t\t\t\t\t\t\t<div class=\"weightTextLeft\">\n\t\t\t\t\t\t\t\t<h2>PESO</h2>\n\t\t\t\t\t\t\t\t<span id=\"weightText\"></span>\n\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t<div id=\"weightBarLeft\"></div>\n\t\t\t\t\t\t</div>\n\t\t\t\t\t</div>\n\t\t\t\t</div>\n\t\t\t\t<div class=\"right_top\">\t\n\t\t\t\t\t<div class=\"title\">\n\t\t\t\t\t\t<h1>LOJA</h1>\n\t\t\t\t\t</div>\n\t\t\t\t</div>\n\t\t\t</div>\n\n\t\t\t<div class=\"sections\">\n\t\t\t\t<div class=\"invLeft\"></div>\n\t\t\t\t<div class=\"invMiddle\">\n\t\t\t\t\t<input class=\"amount\" type=\"number\" onKeyPress=\"if(this.value.length==9) return false;\" placeholder=\"QTD\" maxlength=\"9\" />\n\t\t\t\t</div>\n\t\t\t\t<div class=\"invRight\">\n\t\t\t\t\t\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t</div>\n\t");
}