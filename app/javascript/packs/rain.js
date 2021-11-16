if (document.getElementById('canvas2')) {

  const canvasEl = document.querySelector('#canvas2');

  const w = canvasEl.width = window.innerWidth;
  const h = canvasEl.height = window.innerHeight * 2;

  function looping() {
    requestAnimationFrame(looping);
    ctx.clearRect(0, 0, w, h);

    confs.forEach((conf) => {
      conf.update();
      conf.draw();
    })
  }

  function Rain() {
    //construct confetti
    const colours = ['black', 'black'];

    this.x = Math.round(Math.random() * w);
    this.y = Math.round(Math.random() * h) - (h / 2);
    this.rotation = Math.random() * 360;

    const size = w / 600;
    this.size = size < 1 ? 1 : size;

    this.color = colours;

    this.speed = this.size / 0.8;

    this.opacity = 100;

    this.shiftDirection = Math.random() > 0.5 ? 1 : -1;
  }

  Rain.prototype.border = function () {
    if (this.y >= h) {
      this.y = h;
    }
  }

  Rain.prototype.update = function () {
    this.y += this.speed;

    // if (this.y <= h) {
    //   this.x += this.shiftDirection / 3;
    //   this.rotation += this.shiftDirection * this.speed / 0;
    // }

    if (this.y > h) this.border();
  };

  Rain.prototype.draw = function () {
    ctx.beginPath();
    ctx.arc(this.x, this.y, this.size, this.rotation, this.rotation + (Math.PI / 2));
    ctx.lineTo(this.x, this.y);
    ctx.closePath();
    ctx.globalAlpha = this.opacity;
    ctx.fillStyle = this.color;
    ctx.fill();
  };

  const ctx = canvasEl.getContext('2d');
  const confNum = Math.floor(w / 1);
  const confs = new Array(confNum).fill().map(_ => new Rain());

  looping();
}
