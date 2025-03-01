$(function () {
    const $playerIdentity = $("#player-identity");
    const $policeCard = $("#police-card");
    const $avatarTeste = $('.avatar-teste');
    const $infosTexts = $('.infos-texts');
    const $infosPoliceCard = $('.infos-police-card');
    const $policeCardUpCenter = $('.police-card-up-center');
    const $containerChangeAvatar = $('.container-change-avatar');
    const $inputLink = $('#input-link');
    const $rechangeAvatar = $('#rechange-avatar');

    window.addEventListener('message', (event) => {
        const item = event.data;
        if (item !== undefined && item.type === 'IDENTITY') {
            if (item.payload === true) {
                $playerIdentity.fadeIn(600);
                $.post('http://bs_Identity/getAvatarPlayer', JSON.stringify({}), (data) => {
                    const avatarSrc = data.avatarInfo ? data.avatarInfo : './images/no-avatar.svg';
                    $avatarTeste.html(`<img id="rechange-avatar" class="avatar-identity" src="${avatarSrc}" alt="">`);
                });
                $.post('http://bs_Identity/getInfos', JSON.stringify({}), (data) => {
                    $infosTexts.html(`
                        <div class="infos">
                            <img src="./images/person.svg">
                            <span class="text-up-span">NOME</span>
                            <p class="text-up-p" id="name-person">${data.name} ${data.name2}</p>
                        </div>
                        <div class="infos">
                            <img src="./images/date.svg">
                            <span class="text-down-span">IDADE</span>
                            <p class="text-down-p" id="date-person">${data.age}</p>
                        </div>
                        <div class="infos">
                            <img src="./images/cellphone.svg">
                            <span class="text-down-span">TELEFONE</span>
                            <p class="text-down-p" id="date-person">${data.phone}</p>
                        </div>
                        <div class="infos">
                            <img src="./images/job.svg">
                            <span class="text-down-span">PROFISSÃO</span>
                            <p class="text-down-p" id="date-person">${data.job}</p>
                        </div>
                        <div class="infos job">
                            <img src="./images/identity.svg">
                            <span class="text-down-span">Passaporte</span>
                            <p class="text-down-p" id="date-person">${data.passport}</p>
                        </div>
                    `);
                });
            } else {
                $playerIdentity.fadeOut(600);
            }
        }
        if (item !== undefined && item.type === 'POLICECARD') {
            if (item.payload === true) {
                $policeCard.fadeIn(600);
                $.post('http://bs_Identity/getInfos', JSON.stringify({}), (data) => {
                    $policeCardUpCenter.html(`
                        <span>POLICE DEPARTAMENT of LOS SANTOS</span>
                        <img class="logo-police-card" src="./images/logo-police.svg" alt="">
                        <p class="police-officer-text">POLICE OFFICER</p>
                        <p id="name-police-card">${data.name} ${data.name2}</p>
                    `);
                    $infosPoliceCard.html(`
                        <div class="infos-card">
                            <img src="./images/date.svg" alt="">
                            <span class="text-down-span">CARGO</span>
                            <p class="text-down-p" id="date-person">SHERIFF</p>
                        </div>
                        <div class="infos-card">
                            <img src="./images/identity.svg" alt="">
                            <span class="text-down-span">N° DE REGISTRO</span>
                            <p class="text-down-p" id="date-person">${data.registerAll}</p>
                        </div>
                        <div class="infos-card">
                            <img src="./images/identity.svg" alt="">
                            <span class="text-down-span">PASSAPORTE</span>
                            <p class="text-down-p" id="date-person"> ${data.passport} </p>
                        </div>
                    `);
                });

            } else {
                $policeCard.fadeOut(600);
                console.log('teste 2')
            };
        };

    });

    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://bs_Identity/exit', JSON.stringify({}));
            $containerChangeAvatar.hide();
        }
    };

    $(document).on("click", "#button-confirm", () => {
        const newLink = $inputLink.val();
        const myImage = $rechangeAvatar;
    
        if (/(.*\.png$|.*\.jpg$|.*\.jpeg$)/i.test(newLink) || newLink.indexOf('discord') !== -1) {
            myImage.attr("src", newLink);
            $.post('http://bs_Identity/changeAvatar', JSON.stringify({ newLink }), (data) => {});
            $.post('http://bs_Identity/exit', JSON.stringify({}));
        } else {
            console.log("O link fornecido não é uma imagem válida (deve ser .png, .jpg ou .jpeg).");
        }
    });

    $(document).on("click", "#rechange-avatar", () => {
        $containerChangeAvatar.fadeIn(500);
        $inputLink.val('');
    });

    $(document).on("click", "#button-confirm", () => {
        $containerChangeAvatar.fadeOut(500);
    });
});
