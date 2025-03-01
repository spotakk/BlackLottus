function addGaps(nStr) {
  nStr += '';
  var x = nStr.split('.');
  var x1 = x[0];
  var x2 = x.length > 1 ? '.' + x[1] : '';
  var rgx = /(\d+)(\d{3})/;
  while (rgx.test(x1)) {
      x1 = x1.replace(rgx, '$1' + '<span style="margin-left: 3px; margin-right: 3px;"/>' + '$2');
  }
  return x1 + x2;
}

function addCommas(nStr) {
  nStr += '';
  var x = nStr.split('.');
  var x1 = x[0];
  var x2 = x.length > 1 ? '.' + x[1] : '';
  var rgx = /(\d+)(\d{3})/;
  while (rgx.test(x1)) {
      x1 = x1.replace(rgx, '$1' + '.<span style="margin-left: 0px; margin-right: 1px;"/>' + '$2');
  }
  return x1 + x2;
}

$(document).ready(function() {
  window.addEventListener('message', function(event) {
      var item = event.data;
     
      $('.identidade').html(event.data.identidade);
      $('.checarmultas').html(event.data.multasbalance);

      if (item.updateBalance == true) {
          $('.currentBalance').html(' ' + addCommas(event.data.balance));
          $('.dinheirocarteira').html(event.data.walletbalance);
          $('.multasbalance').html(event.data.multasbalance);
          $('.username').html(event.data.player);
      }

      if (item.openEmp == true) {
          $(".container").fadeIn();

          let emprestimo_data = item.emprestimo
          for (let item in emprestimo_data) {
              $("#extrato").append(`
              <div class="margin">
                  <div class="card-content__title">Extrato (` + emprestimo_data[item].data + `)</div>
                  <div class="card-content__value"><span>` + emprestimo_data[item].extrato + `</span></div>
              </div>
            `);
          }
      }

      if (item.openEmp == false) {
          $(".container").fadeOut();
          $(".multa").fadeOut();
          $('#extrato').html('')
          $('.modal').css('display', 'none');
          $('.blur').css('filter', 'blur(0)');
          $('.box-acoes').css('opacity', '1');
      }
  });

  $("#solicitaremp").submit(function(e) {
    e.preventDefault();
    $.post('http://bank/solicitaremprestimo', JSON.stringify({
        amount: $("#solicitaremp #amount").val()
    }));
    $("#solicitaremp #amount").prop('disabled', true)
    setTimeout(function() {
        $("#solicitaremp #amount").prop('disabled', false)
        $("#solicitaremp #submit").css('display', 'block')
    }, 2000)

    $("#solicitaremp #amount").val('')
    $('modal').fadeOut();
});


  document.onkeyup = function(data) {
      if (data.which == 27) {
          $.post('http://bank/close', JSON.stringify({}));
      }
  };
});