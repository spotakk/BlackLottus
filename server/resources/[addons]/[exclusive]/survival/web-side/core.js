const app = new Vue({
  el: "main",
  template: `
    <div class="background">
        <div class="content">
            <img src="./source/death-icon.png" class="death-icon"/>
            
            <section v-bind:class="{ desactive: busted }" class="time" :style="{ '--width': ((count / 800) * 100).toFixed(2) + '%' }">
                <span>TEMPO RESTANTE</span>
                <h2>{{count}} SEGUNDOS</h2>
            </section>
        </div>
        <footer class="responsive">
            <div class="line"><svg width="2350" height="713" viewBox="0 0 2350 713" fill="none" xmlns="http://www.w3.org/2000/svg">
            <g opacity="0.15">
            <mask id="mask0_437_686" style="mask-type:alpha" maskUnits="userSpaceOnUse" x="0" y="0" width="2350" height="713">
            <rect width="2349.39" height="713" fill="url(#paint0_radial_437_686)"/>
            </mask>
            <g mask="url(#mask0_437_686)">
            <path d="M0 353.578H501.501L562.431 213.135L646.795 487.333V353.578H960.819L1101.43 29.2213L1237.35 677.934L1368.58 353.578C1457.63 356.922 1635.74 361.603 1635.74 353.578C1635.74 345.553 1670.11 272.21 1687.29 236.542L1799.78 577.618L1832.59 353.578H2343.46" stroke="white" stroke-width="4" stroke-linecap="round"/>
            </g>
            </g>
            <defs>
            <radialGradient id="paint0_radial_437_686" cx="0" cy="0" r="1" gradientUnits="userSpaceOnUse" gradientTransform="translate(1174.7 356.5) rotate(90) scale(417.865 1183.98)">
            <stop stop-color="#D9D9D9"/>
            <stop offset="1" stop-color="#D9D9D9" stop-opacity="0"/>
            </radialGradient>
            </defs>
            </svg>
            </div>
            <span>VOCÊ ESTÁ</span>
            <h1>DESACORDADO</h1>
            <ul v-bind:class="{ active: busted }">
                <button v-on:click="handleClick">CLIQUE AQUI</button>
                <p>PARA DESISTIR IMEDIATAMENTE.</p>
            </ul>
        </footer>
    </div>
    `,
  data: {
    count: 800,
    coma: false,
    loop: "",
    busted: false,
    Emergency: {},
    blocked: false,
  },

  methods: {
    handleClick: function handleClick() {
      axios.post("https://survival/reset");
    },
    async startCount() {
      if (!this.coma) {
        await this.haveCops();
        this.coma = true;
        document.body.style.visibility = "visible";
        document.body.style.display = "block";
        this.loop = setInterval(() => {
          if (this.count > 0) {
            this.count -= 1;
            if (this.count == 0) {
              axios.post("https://survival/atualizeInfo");
              this.disableComa();
              this.busted = true;
            }
          }
        }, 1000);
      }
    },

    async haveCops() {
      this.Emergency.minimum = (
        await axios.post("https://survival/haveCops", {})
      ).data;
    },

    disableComa() {
      this.coma = false;
      this.count = 800;
      clearInterval(this.loop);
    },

    protectionBusted() {
      document.body.style.visibility = "visible";
      document.body.style.display = "block";
      this.busted = true;
    },

    hideNui() {
      document.body.style.visibility = "hidden";
      document.body.style.display = "none";
      this.busted = false;
      this.Emergency = {};
      this.disableComa();
    },
  },

  created() {
    window.addEventListener("message", function (event) {
      var item = event.data;
      if (item.coma == false) {
        app.disableComa();
      } else if (item.coma == true) {
        app.startCount();
      } else if (item.action == "hide") {
        app.hideNui();
      } else if (item.emergencyAccept) {
        app.Emergency.accept = true;
      }
    });
  },
});
