var styleElement = document.createElement('style');
styleElement.innerHTML = "\n:root {\n\n\t--white-color: rgb(255, 255, 255);\n\t--purple-color: #5763D0;\n\n}\n\n* {\n\t\n\toverflow: hidden;\n\tbox-sizing: border-box;\n\tuser-select: none;\n\n}\n\nbody {\n\t\n\tmargin: 0;\n\tpadding: 0;\n\tcolor: var(--white-color);\n\tfont-family: \"Inter\", sans-serif;\n\tfont-optical-sizing: auto;\n\tfont-weight: normal;\n\tfont-style: normal;\n\n}\n\n/* ------------------- SCROLL ------------------- */\n\n*::-webkit-scrollbar { \n\twidth: 3px;\n}\n\n*::-webkit-scrollbar-track { \n\tbackground: rgba(87, 99, 208, .1);\n\tborder-radius: 100px;\n}\n\n*::-webkit-scrollbar-thumb { \n\tbackground: rgb(87, 99, 208);\n\tborder-radius: 100px;\n}\n\ninput::-webkit-outer-spin-button,\ninput::-webkit-inner-spin-button { -webkit-appearance: none; }\n\n/* --------------------------------------------- */\n\n/* ------------------- RESET ------------------- */\n\nh1, h2, h3 {\n\n\tmargin: 0;\n\n}\n\n/* --------------------------------------------- */\n\n.inventory {\n\t\n\twidth: 100vw;\n\theight: 100vh;\n\tdisplay: none;\n\tposition: fixed;\n\talign-items: center;\n\tjustify-content: center;\n\tflex-direction: column;\n\tbackground-image: url(nui://inventory/web-side/images/bg.png);\n\tbackground-size: 100%;\n\tbackground-size: 100%;\n\n}\n\n.innerInventory {\n\tdisplay: flex;\n\tflex-direction: column;\n}\n\n.sections {\n\n\tdisplay: flex;\n\theight: 652px;\n\tmax-height: 652px;\n\n}\n\n.invLeft, .invRight {\n\n\tdisplay: grid;\n\tgrid-template-columns: repeat(5, 1fr);\n\tgap: 4px;\n\toverflow-y: scroll;\n\tpadding-right: 10px;\n\t\n}\n\n.item {\n\t\n\twidth: 125px;\n\theight: 160px;\n\tdisplay: flex;\n\tflex-direction: column;\n\tborder-radius: 5px;\n\tbackground: rgba(16, 16, 21, .2);\n\tposition: relative;\n\tcursor: pointer;\n\n}\n\n.populated {\n\n\tbackground-size: 86% !important;\n\n}\n\n.populated .nameItem {\n\n\tposition: absolute;\n\theight: 0;\n\tleft: 0;\n\tbottom: -60%;\n\ttransition: all .45s ease-in-out;\n\n}\n\n.populated:hover .nameItem {\n\n\theight: 26px;\n\tbottom: 0;\n\tposition: relative;\n\n}\n\n.hoverControl {\n\n\tbackground: rgba(16, 16, 21, .6)\n\n}\n\n.item .top {\n\n\tdisplay: flex;\n\tjustify-content: space-between;\n\talign-items: center;\n\tmargin: 10px 10px 0 10px;\n\tfont-size: .7rem;\n\n}\n\n.invLeft > .item:nth-child(n+1):nth-child(-n+5) .nameItem {\n\n\tposition: relative;\n\theight: 26px;\n\tbottom: 0;\n\n}\n\n.invLeft > .item:nth-child(n+1):nth-child(-n+5) {\n\n\tbackground-color: rgba(255, 255, 255, .01);\n\tbackground-repeat: no-repeat;\n\tbackground-position: center;\n\n}\n\n.invLeft > .item:nth-child(n+1):nth-child(-n+5).populated, .invRight .item.populated:hover {\n\n\tbackground: rgba(16, 16, 21, 0.75);\n\n}\n\n.invLeft > .item:nth-child(n+1):nth-child(-n+5).populated .itemAmount {\n\n\tborder: 1px solid #5763D0;\n\tbackground: rgba(87, 99, 208, .25);\n\t\n}\n\n.invRight .populated:hover {\n\n\tbackground: rgba(16, 16, 21, 0.75);\n\n}\n\n.invLeft > .item:nth-child(1){\n\tbackground-image: url('nui://inventory/web-side/images/1.png');;\n}\n\n.invLeft > .item:nth-child(2){\n\tbackground-image: url('nui://inventory/web-side/images/2.png');;\n}\n\n.invLeft > .item:nth-child(3){\n\tbackground-image: url('nui://inventory/web-side/images/3.png');;\n}\n\n.invLeft > .item:nth-child(4){\n\tbackground-image: url('nui://inventory/web-side/images/4.png');;\n}\n\n.invLeft > .item:nth-child(5){\n\tbackground-image: url('nui://inventory/web-side/images/5.png');;\n}\n\n.itemAmount, .invRight .item .itemWeight {\n\n\tdisplay: grid;\n\tplace-items: center;\n\tborder-radius: 2.5px;\n\theight: 23px;\n\tpadding: 0 6px;\n\tfont-size: 9px;\n\tfont-weight: 600;\n\n}\n\n.itemAmount {\n\n\tborder: 1px solid rgba(87, 99, 208, .15);\n\tbackground: rgba(87, 99, 208, .05);\n\tbackdrop-filter: blur(12.5px);\n\ttransition: all .45s;\n\n}\n\n.invRight .item.populated:hover .itemAmount {\n\n\tborder: 1px solid #5763D0;\n\tbackground: rgba(87, 99, 208, .25);\n\n}\n\n.itemWeight {\n\t\n\tfont-size: 9px;\n\tfont-weight: 600;\n\ttext-align: right;\n\n}\n\n.item .nameItem {\n\n\tdisplay: flex;\n\talign-items: center;\n\tjustify-content: center;\n\theight: 0;\n\twidth: 100%;\n\tfont-size: 10px;\n\tfont-weight: 900;\n\twhite-space: nowrap;\n\ttext-overflow: ellipsis;\n\ttext-transform: uppercase;\n\tborder-radius: 0 0 5px 5px;\n\tbackground: var(--purple-color);\n\n}\n\n.item .durability {\n\n\twidth: 85%;\n\theight: 2px;\n\tborder-radius: 5px;\n\tmargin: auto auto 6px auto;\n\tbackground-color: transparent;\n\n}\n\n.item .durability .bar {\n\n\theight: 100%;\n\tborder-radius: 5px;\n\n}\n\n.invMiddle {\n\n\tdisplay: flex;\n\talign-items: center;\n\tjustify-content: center;\n\tflex-direction: column;\n\tgap: 15px;\n\tmargin: 0 16px 5rem 16px;\n\n}\n\ninput {\n\tborder-radius: 3px;\n\ttext-align: center;\n}\n\n.invMiddle div, .invMiddle input {\n\n\tdisplay: flex;\n\talign-items: center;\n\tjustify-content: center;\n\twidth: 101px;\n\tborder: 0;\n\toutline: none;\n\ttext-align: center;\n\tborder-radius: 5px;\n\tborder: 1px solid rgba(255, 255, 255, 0.10);\n\tbackground: linear-gradient(180deg, rgba(255, 255, 255, 0.00) -81.88%, rgba(255, 255, 255, 0.05) 100%);\n\tbackdrop-filter: blur(12.5px);\n\n}\n\n.invMiddle input {\n\n\tfont-size: 15px;\n\tfont-weight: 500;\n\theight: 60px;\n\tcolor: var(--white-color);\n\n}\n\n.invMiddle div {\n\n\tfont-size: 14px;\n\tfont-weight: 700;\n\theight: 55px;\n\tcursor: pointer;\n\n}\n\n.ui-helper-hidden-accessible {\n\tdisplay: none;\n}\n\n.ui-tooltip {\n\n\tz-index: 9999;\n\tfont-size: 11px;\n\tborder-radius: 5px;\n\tposition: absolute;\n\tletter-spacing: 1px;\n\tpadding: 20px 20px 15px;\n\tbackground: rgba(16, 16, 21, .85);\n\n}\n\n.ui-tooltip:hover {\n\tdisplay: none;\n}\n\n.ui-tooltip item {\n\n\tfloat: left;\n\tfont-size: 14px;\n\tfont-weight: 700;\n\tmin-width: 200px;\n\tcolor: var(--purple-color);\n\ttext-transform: uppercase;\n\n}\n\n.ui-tooltip legenda {\n\tfloat: left;\n\tmin-width: 225px;\n\tmargin-top: 10px;\n\tpadding-top: 6px;\n\tline-height: 20px;\n}\n\n.ui-tooltip description {\n\tfloat: left;\n\tfont-size: 11px;\n\tfont-weight: 600;\n\tmax-width: 225px;\n\tmargin-top: 5px;\n}\n\n.ui-tooltip description green {\n\tcolor: #a0ceb6;\n}\n\n.ui-tooltip s {\n\tcolor: var(--purple-color);\n\tpadding: 0 5px;\n\ttext-decoration: none;\n}\n\n.ui-tooltip r {\n\tcolor: var(--purple-color);\n}\n\n/* -------------------- TOPO -------------------- */\n\n.top_header {\n\n\tdisplay: flex;\n\tjustify-content: space-between;\n\twidth: 100%;\n\n}\n\n.left_top, .right_top {\n\t\n\twidth: 648px;\n\tmax-width: 648px;\n\tpadding-right: 6px;\n\tmargin-bottom: 17px;\n\tposition: relative;\n\n}\n\n.right_top {\n\n\tdisplay: flex;\n\tflex-direction: column;\n\tjustify-content: end;\n\tmargin-bottom: 22px;\n\tpadding-right: 12px;\n\n}\n\n.left_top .title, .right_top .title {\n\n\tmargin-bottom: 10px;\n\n}\n\n.left_top .title h1, .right_top .title h1 {\n\n\tfont-size: 40px;\n\tfont-weight: 800;\n\tletter-spacing: 2px;\n\n}\n\n.left_top .weight_player, .right_top .weight_player {\n\n\tdisplay: flex;\n\talign-items: center;\n\tgap: 14px;\n\twidth: 100%;\n\n}\n\n.left_top .weight_player .weight, .right_top .weight_player .weight {\n\n\tflex: 1;\n\n}\n\n.left_top .weight_player .player_info, .right_top .weight_player .player_info {\n\n\tdisplay: flex;\n\talign-items: center;\n\twidth: min-content;\n\tgap: .63rem;\n\n}\n\n.right_top .title h1 {\n\n\tfont-size: 40px;\n\tfont-weight: 800;\n\tletter-spacing: 2px;\n\n}\n\n.weight_player .player_info .border {\n\n\twidth: 3px;\n\theight: 22px;\n\tborder-radius: 100px;\n\tbackground: rgb(87, 99, 208);\n\n}\n\n.weight_player .player_info span {\n\n\tfont-size: 15px;\n\tfont-weight: 600;\n\twhite-space: nowrap;\n\n}\n\n.weight_player .player_info span > span {\n\n\t/* font-style: italic; */\n\tfont-weight: 700;\n\n}\n\n.weight_player .weight .weightTextLeft, .weight_player .weight .weightTextRight {\n\n\tposition: absolute;\n\tright: 12px;\n\ttop: 18px;\n\n}\n\n.weight_player .weight .weightTextRight {\n\n\tright: 18px;\n\n}\n\n.weight .weightTextLeft h2, .weight .weightTextRight h2 {\n\n\tfont-size: 12px;\n\tfont-weight: 800;\n\ttext-align: right;\n\twidth: 100%;\n\tmargin-bottom: 5px;\n\n}\n\n.weight .weightTextLeft span, .weight .weightTextRight span  {\n\n\tfont-size: 10px;\n\tfont-weight: 500;\n\ttext-align: right;\n\n}\n\n.weight_player .weight #weightBarLeft, .weight_player .weight #weightBarRight {\n\n\twidth: 100%;\n\theight: 13px;\n\tbackground: rgba(87, 99, 208, .25);\n\tborder: 5px solid rgba(16, 16, 21, .75);;\n\tborder-radius: 100px;\n\n}\n\n.weight #weightBarLeft .weightBar, .weight #weightBarRight .weightBar {\n\n\theight: 100%;\n\tborder-radius: 100px;\n\tbackground: rgb(87, 99, 208);\n\ttransition: all .25s;\n\n}\n\n/* ---------- TRUNKCHEST ----------";
document.head.appendChild(styleElement);
window.onload = () => {
  renderHTML();
};
$(document).ready(function () {
  window.addEventListener("message", function (_0x172408) {
    switch (_0x172408.data.action) {
      case 'showMenu':
        requestChest();
        setTimeout(() => {
          $(".inventory").css("display", "flex");
        }, 0xc8);
        break;
      case "hideMenu":
        $('.inventory').css("display", "none");
        $(".ui-tooltip").hide();
        break;
      case 'requestChest':
        requestChest();
        break;
      case "updateWeight":
        $('#weightTextLeft').html(_0x172408.data.invPeso.toFixed(0x2) + " / " + (_0x172408.data.invMaxpeso.toFixed(0x2) + 'KG'));
        $("#weightTextRight").html(_0x172408.data.chestPeso.toFixed(0x2) + " / " + (_0x172408.data.chestMaxpeso.toFixed(0x2) + 'KG'));
        $('#weightBarLeft').html("<div class=\"weightBar\" style=\"width: " + _0x172408.data.invPeso / _0x172408.data.invMaxpeso * 0x64 + "%\"></div>");
        $("#weightBarRight").html("<div class=\"weightBar\" style=\"width: " + _0x172408.data.chestPeso / _0x172408.data.chestMaxpeso * 0x64 + "%\"></div>");
        break;
    }
  });
  document.onkeyup = _0xca22c7 => {
    if (_0xca22c7.key === "Escape") {
      $.post('http://trunkchest/invClose');
      $('.invRight').html('');
      $(".invLeft").html('');
    }
  };
  $("body").mousedown(_0x47613e => {
    if (_0x47613e.button == 0x1) {
      return false;
    }
  });
});
const updateDrag = () => {
  $(".populated").draggable({
    'helper': "clone"
  });
  $(".empty").droppable({
    'hoverClass': "hoverControl",
    'drop': function (_0x2f69ea, _0x5dd63d) {
      if (_0x5dd63d.draggable.parent()[0x0] == undefined) {
        return;
      }
      const _0x5134c4 = _0x2f69ea.shiftKey;
      const _0x348ab5 = _0x5dd63d.draggable.parent()[0x0].className;
      if (_0x348ab5 === undefined) {
        return;
      }
      const _0x5493e7 = $(this).parent()[0x0].className;
      itemData = {
        'key': _0x5dd63d.draggable.data("item-key"),
        'slot': _0x5dd63d.draggable.data("slot")
      };
      const _0x2695a8 = $(this).data("slot");
      if (itemData.key === undefined || _0x2695a8 === undefined) {
        return;
      }
      let _0x4aed42 = 0x0;
      let _0x2769b4 = parseInt(_0x5dd63d.draggable.data("amount"));
      if (_0x5134c4) {
        _0x4aed42 = _0x2769b4;
      } else {
        if ($(".amount").val() == '' | parseInt($(".amount").val()) <= 0x0) {
          _0x4aed42 = 0x1;
        } else {
          _0x4aed42 = parseInt($(".amount").val());
        }
      }
      if (_0x4aed42 > _0x2769b4) {
        _0x4aed42 = _0x2769b4;
      }
      $(".populated, .empty").off("draggable droppable");
      let _0x25a724 = _0x5dd63d.draggable.clone();
      let _0x8d3c5a = $(this).data('slot');
      if (_0x4aed42 == _0x2769b4) {
        let _0x15f5d6 = $(this).clone();
        let _0x46e3c2 = _0x5dd63d.draggable.data('slot');
        $(this).replaceWith(_0x25a724);
        _0x5dd63d.draggable.replaceWith(_0x15f5d6);
        $(_0x25a724).data("slot", _0x8d3c5a);
        $(_0x15f5d6).data('slot', _0x46e3c2);
      } else {
        let _0x257e9a = _0x2769b4 - _0x4aed42;
        let _0x2c6d8e = parseFloat(_0x5dd63d.draggable.data("peso"));
        let _0x2d61c1 = (_0x4aed42 * _0x2c6d8e).toFixed(0x2);
        let _0x13770a = (_0x257e9a * _0x2c6d8e).toFixed(0x2);
        _0x5dd63d.draggable.data("amount", _0x257e9a);
        _0x25a724.data("amount", _0x4aed42);
        $(this).replaceWith(_0x25a724);
        $(_0x25a724).data("slot", _0x8d3c5a);
        _0x5dd63d.draggable.children(".top").children('.itemAmount').html(formatarNumero(_0x5dd63d.draggable.data("amount")) + 'x');
        _0x5dd63d.draggable.children(".top").children(".itemWeight").html(_0x13770a);
        $(_0x25a724).children(".top").children('.itemAmount').html(formatarNumero(_0x25a724.data('amount')) + 'x');
        $(_0x25a724).children(".top").children(".itemWeight").html(_0x2d61c1);
      }
      updateDrag();
      if (_0x348ab5 === "invLeft" && _0x5493e7 === "invLeft") {
        $.post('http://inventory/updateSlot', JSON.stringify({
          'item': itemData.key,
          'slot': itemData.slot,
          'target': _0x2695a8,
          'amount': parseInt(_0x4aed42)
        }));
      } else {
        if (_0x348ab5 === "invRight" && _0x5493e7 === "invLeft") {
          $.post("http://trunkchest/takeItem", JSON.stringify({
            'item': itemData.key,
            'slot': itemData.slot,
            'target': _0x2695a8,
            'amount': parseInt(_0x4aed42)
          }));
        } else {
          if (_0x348ab5 === "invLeft" && _0x5493e7 === "invRight") {
            $.post("http://trunkchest/storeItem", JSON.stringify({
              'item': itemData.key,
              'slot': itemData.slot,
              'target': _0x2695a8,
              'amount': parseInt(_0x4aed42)
            }));
          } else if (_0x348ab5 === 'invRight' && _0x5493e7 === "invRight") {
            $.post('http://trunkchest/updateChest', JSON.stringify({
              'item': itemData.key,
              'slot': itemData.slot,
              'target': _0x2695a8,
              'amount': parseInt(_0x4aed42)
            }));
          }
        }
      }
      $(".amount").val('');
    }
  });
  $(".populated").droppable({
    'hoverClass': 'hoverControl',
    'drop': function (_0x28e19a, _0x5732fa) {
      if (_0x5732fa.draggable.parent()[0x0] == undefined) {
        return;
      }
      const _0x20d105 = _0x28e19a.shiftKey;
      const _0x376667 = _0x5732fa.draggable.parent()[0x0].className;
      if (_0x376667 === undefined) {
        return;
      }
      const _0x4ff6e0 = $(this).parent()[0x0].className;
      itemData = {
        'key': _0x5732fa.draggable.data("item-key"),
        'slot': _0x5732fa.draggable.data('slot')
      };
      const _0x4f7d7d = $(this).data('slot');
      if (itemData.key === undefined || _0x4f7d7d === undefined) {
        return;
      }
      let _0x422f8f = 0x0;
      let _0x1cb1c4 = parseInt(_0x5732fa.draggable.data('amount'));
      if (_0x20d105) {
        _0x422f8f = _0x1cb1c4;
      } else {
        if ($(".amount").val() == '' | parseInt($(".amount").val()) <= 0x0) {
          _0x422f8f = 0x1;
        } else {
          _0x422f8f = parseInt($(".amount").val());
        }
      }
      if (_0x422f8f > _0x1cb1c4) {
        _0x422f8f = _0x1cb1c4;
      }
      $(".populated, .empty, .use").off("draggable droppable");
      if (_0x5732fa.draggable.data("item-key") == $(this).data("item-key")) {
        let _0x5f2af5 = _0x422f8f + parseInt($(this).data("amount"));
        let _0x46d3df = _0x5732fa.draggable.data("peso") * _0x5f2af5;
        $(this).data("amount", _0x5f2af5);
        $(this).children(".top").children('.itemAmount').html(formatarNumero(_0x5f2af5) + 'x');
        $(this).children(".top").children(".itemWeight").html(_0x46d3df.toFixed(0x2));
        if (_0x422f8f == _0x1cb1c4) {
          _0x5732fa.draggable.replaceWith("<div class=\"item empty\" data-slot=\"" + _0x5732fa.draggable.data("slot") + "\"></div>");
        } else {
          let _0x5900c0 = _0x1cb1c4 - _0x422f8f;
          let _0x259e69 = parseFloat(_0x5732fa.draggable.data("peso")) * _0x5900c0;
          _0x5732fa.draggable.data("amount", _0x5900c0);
          _0x5732fa.draggable.children(".top").children('.itemAmount').html(formatarNumero(_0x5900c0) + 'x');
          _0x5732fa.draggable.children(".top").children(".itemWeight").html(_0x259e69.toFixed(0x2));
        }
      } else {
        if (_0x376667 === "invRight" && _0x4ff6e0 === "invLeft") {
          return;
        }
        let _0x4e37f1 = _0x5732fa.draggable.clone();
        let _0xdb3e9b = $(this).clone();
        let _0x4319a4 = _0x5732fa.draggable.data('slot');
        let _0x431026 = $(this).data('slot');
        _0x5732fa.draggable.replaceWith(_0xdb3e9b);
        $(this).replaceWith(_0x4e37f1);
        $(_0x4e37f1).data("slot", _0x431026);
        $(_0xdb3e9b).data("slot", _0x4319a4);
      }
      updateDrag();
      if (_0x376667 === "invLeft" && _0x4ff6e0 === 'invLeft') {
        $.post("http://inventory/updateSlot", JSON.stringify({
          'item': itemData.key,
          'slot': itemData.slot,
          'target': _0x4f7d7d,
          'amount': parseInt(_0x422f8f)
        }));
      } else {
        if (_0x376667 === "invRight" && _0x4ff6e0 === "invLeft") {
          $.post("http://trunkchest/takeItem", JSON.stringify({
            'item': itemData.key,
            'slot': itemData.slot,
            'target': _0x4f7d7d,
            'amount': parseInt(_0x422f8f)
          }));
        } else {
          if (_0x376667 === "invLeft" && _0x4ff6e0 === "invRight") {
            $.post('http://trunkchest/storeItem', JSON.stringify({
              'item': itemData.key,
              'slot': itemData.slot,
              'target': _0x4f7d7d,
              'amount': parseInt(_0x422f8f)
            }));
          } else if (_0x376667 === "invRight" && _0x4ff6e0 === "invRight") {
            $.post("http://trunkchest/updateChest", JSON.stringify({
              'item': itemData.key,
              'slot': itemData.slot,
              'target': _0x4f7d7d,
              'amount': parseInt(_0x422f8f)
            }));
          }
        }
      }
      $(".amount").val('');
    }
  });
  $(".populated").tooltip({
    'create': function (_0x41b1ef, _0x4a2c4e) {
      var _0x4bc420 = $(this).attr("data-max");
      var _0x2f3ee5 = $(this).attr("data-type");
      var _0x5a89e6 = $(this).attr("data-name-key");
      var _0x8d1ac0 = $(this).attr("data-description");
      $(this).tooltip({
        'content': '<item>' + _0x5a89e6 + '</item>' + (_0x8d1ac0 !== "undefined" ? '<br><description>' + _0x8d1ac0 + "</description>" : '') + "<br><legenda>Tipo: <r>" + _0x2f3ee5 + "</r> <s>|</s> Máximo: <r>" + (_0x4bc420 !== "undefined" ? _0x4bc420 : "S/L") + "</r></legenda>",
        'position': {
          'my': "center top+10",
          'at': "center bottom",
          'collision': "flipfit"
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
const colorPicker = _0x5eefe9 => {
  var _0x5301fd = '#5763D0';
  if (_0x5eefe9 >= 0x64) {
    _0x5301fd = "transparent";
  }
  if (_0x5eefe9 >= 0x1a && _0x5eefe9 <= 0x32) {
    _0x5301fd = "#fc8a58";
  }
  if (_0x5eefe9 <= 0x19) {
    _0x5301fd = "#fc5858";
  }
  return _0x5301fd;
};
const requestChest = () => {
  $.post('http://trunkchest/requestChest', JSON.stringify({}), _0x1001d9 => {
    $("#weightTextLeft").html(_0x1001d9.invPeso.toFixed(0x2) + " / " + (_0x1001d9.invMaxpeso.toFixed(0x2) + 'KG'));
    $('#weightTextRight').html(_0x1001d9.chestPeso.toFixed(0x2) + " / " + (_0x1001d9.chestMaxpeso.toFixed(0x2) + 'KG'));
    $("#backend_info").html("\n\t\t" + _0x1001d9.name + " <span>#" + _0x1001d9.id + "</span>\n\t\t");
    $("#weightBarLeft").html("\n\t\t\t<div class=\"weightBar\" style=\"width: " + _0x1001d9.invPeso / _0x1001d9.invMaxpeso * 0x64 + "%\"></div>\n\t\t");
    $("#weightBarRight").html("\n\t\t\t<div class=\"weightBar\" style=\"width: " + _0x1001d9.chestPeso / _0x1001d9.chestMaxpeso * 0x64 + "%\"></div>\n\t\t");
    $('.invLeft').html('');
    $(".invRight").html('');
    if (_0x1001d9.invMaxpeso > 0x64) {
      _0x1001d9.invMaxpeso = 0x64;
    }
    for (let _0x7221b1 = 0x1; _0x7221b1 <= _0x1001d9.invMaxpeso; _0x7221b1++) {
      const _0x32eba6 = _0x7221b1.toString();
      if (_0x1001d9.myInventory[_0x32eba6] !== undefined) {
        const _0x25bc41 = _0x1001d9.myInventory[_0x32eba6];
        const _0x1c5309 = 0x15180 * _0x25bc41.days;
        const _0x430beb = (_0x1c5309 - _0x25bc41.durability) / _0x1c5309;
        var _0xe0b560 = _0x430beb * 0x64;
        if (_0xe0b560 <= 0x1) {
          _0xe0b560 = 0x1;
        }
        const _0x5567ed = "<div class=\"item populated\" title=\"\" data-max=\"" + _0x25bc41.max + "\" data-type=\"" + _0x25bc41.type + "\" data-description=\"" + _0x25bc41.desc + "\" style=\"background-image: url('nui://inventory/web-side/images/" + _0x25bc41.index + ".png'); background-position: center; background-repeat: no-repeat;\" data-amount=\"" + _0x25bc41.amount + "\" data-peso=\"" + _0x25bc41.peso + "\" data-item-key=\"" + _0x25bc41.key + "\" data-name-key=\"" + _0x25bc41.name + "\" data-slot=\"" + _0x32eba6 + "\">\n\t\t\t\t\t<div class=\"top\">\n\t\t\t\t\t\t<div class=\"itemAmount\">" + formatarNumero(_0x25bc41.amount) + "x</div>\n\t\t\t\t\t\t<div class=\"itemWeight\">" + ((_0x25bc41.peso * _0x25bc41.amount).toFixed(0x2) + 'KG') + "</div>\n\t\t\t\t\t</div>\n\n\t\t\t\t\t<div class=\"durability\" style=\"width: " + (_0xe0b560 == 0x1 ? "100" : _0xe0b560) + "%; background: " + (_0xe0b560 == 0x1 ? "#fc5858" : colorPicker(_0xe0b560)) + ";\"></div>\n\t\t\t\t\t<div class=\"nameItem\">" + _0x25bc41.name + "</div>\n\t\t\t\t</div>";
        $(".invLeft").append(_0x5567ed);
      } else {
        const _0x53b255 = "<div class=\"item empty\" data-slot=\"" + _0x32eba6 + "\"></div>";
        $(".invLeft").append(_0x53b255);
      }
    }
    for (let _0x277c8c = 0x1; _0x277c8c <= 0x32; _0x277c8c++) {
      const _0x13b64d = _0x277c8c.toString();
      if (_0x1001d9.myChest[_0x13b64d] !== undefined) {
        const _0x341319 = _0x1001d9.myChest[_0x13b64d];
        const _0x3eef75 = 0x15180 * _0x341319.days;
        const _0x236be7 = (_0x3eef75 - _0x341319.durability) / _0x3eef75;
        var _0xe0b560 = _0x236be7 * 0x64;
        if (_0xe0b560 <= 0x1) {
          _0xe0b560 = 0x1;
        }
        const _0x2463ea = "<div class=\"item populated\" title=\"\" data-max=\"" + _0x341319.max + "\" data-type=\"" + _0x341319.type + "\" data-description=\"" + _0x341319.desc + "\" style=\"background-image: url('nui://inventory/web-side/images/" + _0x341319.index + ".png'); background-position: center; background-repeat: no-repeat;\" data-amount=\"" + _0x341319.amount + "\" data-peso=\"" + _0x341319.peso + "\" data-item-key=\"" + _0x341319.key + "\" data-name-key=\"" + _0x341319.name + "\" data-slot=\"" + _0x13b64d + "\">\n\t\t\t\t\t<div class=\"top\">\n\t\t\t\t\t\t<div class=\"itemAmount\">" + formatarNumero(_0x341319.amount) + "x</div>\n\t\t\t\t\t\t<div class=\"itemWeight\">" + ((_0x341319.peso * _0x341319.amount).toFixed(0x2) + 'KG') + "</div>\n\t\t\t\t\t</div>\n\n\t\t\t\t\t<div class=\"durability\" style=\"width: " + (_0xe0b560 == 0x1 ? '100' : _0xe0b560) + "%; background: " + (_0xe0b560 == 0x1 ? "#fc5858" : colorPicker(_0xe0b560)) + ";\"></div>\n\t\t\t\t\t<div class=\"nameItem\">" + _0x341319.name + "</div>\n\t\t\t\t</div>";
        $(".invRight").append(_0x2463ea);
      } else {
        const _0x233c2d = "<div class=\"item empty\" data-slot=\"" + _0x13b64d + "\"></div>";
        $(".invRight").append(_0x233c2d);
      }
    }
    updateDrag();
  });
};
const formatarNumero = _0x4f9393 => {
  var _0x4f9393 = _0x4f9393.toString();
  var _0x1b2102 = '';
  var _0x57bb13 = 0x0;
  for (var _0x371703 = _0x4f9393.length; _0x371703 > 0x0; _0x371703--) {
    _0x1b2102 += _0x4f9393.substr(_0x371703 - 0x1, 0x1) + (_0x57bb13 == 0x2 && _0x371703 != 0x1 ? '.' : '');
    _0x57bb13 = _0x57bb13 == 0x2 ? 0x0 : _0x57bb13 + 0x1;
  }
  return _0x1b2102.split('').reverse().join('');
};
function renderHTML() {
  $(".inventory").html("\n\t\t<div class=\"innerInventory\">\n\t\t\t<div class=\"top_header\">\n\t\t\t\t<div class=\"left_top\">\t\n\t\t\t\t\t<div class=\"title\">\n\t\t\t\t\t\t<h1>SEU INVENTÁRIO</h1>\n\t\t\t\t\t</div>\n\t\t\t\t\t<div class=\"weight_player\">\n\t\t\t\t\t\t<div class=\"player_info\">\n\t\t\t\t\t\t\t<div class=\"border\"></div>\n\t\t\t\t\t\t\t<span id=\"backend_info\">Felipe Gonçalves <span>#63</span></span>\n\t\t\t\t\t\t</div>\n\t\t\t\t\t\t<div class=\"weight\">\n\t\t\t\t\t\t\t<div class=\"weightTextLeft\">\n\t\t\t\t\t\t\t\t<h2>PESO</h2>\n\t\t\t\t\t\t\t\t<span id=\"weightTextLeft\"></span>\n\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t<div id=\"weightBarLeft\"></div>\n\t\t\t\t\t\t</div>\n\t\t\t\t\t</div>\n\t\t\t\t</div>\n\t\t\t\t<div class=\"right_top\">\t\n\t\t\t\t\t<div class=\"title\">\n\t\t\t\t\t\t<h1>BAÚ</h1>\n\t\t\t\t\t</div>\n\t\t\t\t\t<div class=\"weight_player\">\n\t\t\t\t\t\t<div class=\"weight\">\n\t\t\t\t\t\t\t<div class=\"weightTextRight\">\n\t\t\t\t\t\t\t\t<h2>PESO</h2>\n\t\t\t\t\t\t\t\t<span id=\"weightTextRight\"></span>\n\t\t\t\t\t\t\t</div>\n\t\t\t\t\t\t\t<div id=\"weightBarRight\"></div>\n\t\t\t\t\t\t</div>\n\t\t\t\t\t</div>\n\t\t\t\t</div>\n\t\t\t</div>\n\n\t\t\t<div class=\"sections\">\n\t\t\t\t<div class=\"invLeft\"></div>\n\t\t\t\t<div class=\"invMiddle\">\n\t\t\t\t\t<input class=\"amount\" type=\"number\" onKeyPress=\"if(this.value.length==9) return false;\" placeholder=\"QTD\" maxlength=\"9\"/>\n\t\t\t\t</div>\n\t\t\t\t<div class=\"invRight\">\n\t\t\t\t\t\n\t\t\t\t</div>\n\t\t\t</div>\n\t\t</div>\n\t");
}