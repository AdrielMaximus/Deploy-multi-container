CREATE TABLE doctors (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(100) NOT NULL
);

CREATE TABLE appointments (
    id SERIAL PRIMARY KEY,
    doctor_id INTEGER REFERENCES doctors(id),
    paciente_nome VARCHAR(100) NOT NULL,
    data DATE NOT NULL,
    horario TIME NOT NULL,
    UNIQUE (doctor_id, data, horario)
);

INSERT INTO doctors (nome, especialidade) VALUES
('Dr. João Silva', 'Cardiologia'),
('Dra. Maria Souza', 'Dermatologia');
