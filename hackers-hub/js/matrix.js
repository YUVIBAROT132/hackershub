/* lightweight matrix background */
const canvas = document.getElementById("matrix-bg");
if (canvas) {
  const ctx = canvas.getContext("2d");
  let w = canvas.width = innerWidth;
  let h = canvas.height = innerHeight;
  const fontSize = 12;
  const columns = Math.floor(w / fontSize);
  const drops = Array(columns).fill(1);
  const letters = "01";
  function draw() {
    ctx.fillStyle = "rgba(0,0,0,0.15)";
    ctx.fillRect(0,0,w,h);
    ctx.fillStyle = "#0f0";
    ctx.font = fontSize + "px monospace";
    for (let i=0;i<drops.length;i++){
      const text = letters.charAt(Math.floor(Math.random() * letters.length));
      ctx.fillText(text, i*fontSize, drops[i]*fontSize);
      if (drops[i]*fontSize > h && Math.random() > 0.975) drops[i]=0;
      drops[i]++;
    }
  }
  setInterval(draw, 40);
  addEventListener('resize', ()=>{ w = canvas.width = innerWidth; h = canvas.height = innerHeight; });
}
