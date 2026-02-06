const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');

const app = express();
app.use(cors());
app.use(express.json());

const pool = new Pool({
  host: 'localhost',
  user: 'postgres',
  password: 'postgres',
  database: 'clinic',
  port: 5432
});

app.get('/doctors', async (req, res) => {
  const result = await pool.query('SELECT * FROM doctors ORDER BY nome');
  res.json(result.rows);
});

app.get('/doctors/:id/slots', async (req, res) => {
  const doctorId = req.params.id;
  const slots = ['09:00', '10:00', '11:00', '14:00', '15:00'];

  const result = await pool.query(
    'SELECT horario FROM appointments WHERE doctor_id = $1 AND data = CURRENT_DATE',
    [doctorId]
  );

  const booked = result.rows.map(r => r.horario.toString().slice(0, 5));
  const available = slots.filter(h => !booked.includes(h));

  res.json(available);
});

app.post('/appointments', async (req, res) => {
  const { doctor_id, paciente_nome, data, horario } = req.body;

  try {
    await pool.query(
      'INSERT INTO appointments (doctor_id, paciente_nome, data, horario) VALUES ($1, $2, $3, $4)',
      [doctor_id, paciente_nome, data, horario]
    );

    res.status(201).json({ message: 'Consulta agendada com sucesso' });
  } catch (err) {
    res.status(400).json({ error: 'Horário já ocupado' });
  }
});

app.listen(3000, () => {
  console.log('Backend rodando na porta 3000');
});
