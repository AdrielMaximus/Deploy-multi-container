const api = 'http://localhost:3000';

async function loadDoctors() {
  const res = await fetch(`${api}/doctors`);
  const doctors = await res.json();

  const select = document.getElementById('doctors');
  select.innerHTML = '';

  doctors.forEach(d => {
    const opt = document.createElement('option');
    opt.value = d.id;
    opt.textContent = `${d.nome} (${d.especialidade})`;
    select.appendChild(opt);
  });

  loadSlots();
}

async function loadSlots() {
  const doctorId = document.getElementById('doctors').value;
  const res = await fetch(`${api}/doctors/${doctorId}/slots`);
  const slots = await res.json();

  const select = document.getElementById('slots');
  select.innerHTML = '';

  slots.forEach(h => {
    const opt = document.createElement('option');
    opt.value = h;
    opt.textContent = h;
    select.appendChild(opt);
  });
}

document.getElementById('doctors').addEventListener('change', loadSlots);

async function schedule() {
  const doctor_id = document.getElementById('doctors').value;
  const horario = document.getElementById('slots').value;
  const paciente_nome = document.getElementById('patient').value;

  const res = await fetch(`${api}/appointments`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      doctor_id,
      paciente_nome,
      data: new Date().toISOString().slice(0, 10),
      horario
    })
  });

  const msg = document.getElementById('msg');
  const data = await res.json();
  msg.textContent = data.message || data.error;
}

loadDoctors();
