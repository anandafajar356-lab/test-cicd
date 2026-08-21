const btn = document.getElementById('pingBtn');
const output = document.getElementById('statusOutput');

btn.addEventListener('click', () => {
    const now = new Date().toLocaleTimeString();
    output.textContent = `Ping acknowledged at ${now} | Pod Active`;
    output.style.color = '#38bdf8';
});