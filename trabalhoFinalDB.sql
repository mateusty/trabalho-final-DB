-- Criação de Banco de dados / Tabelas (todas as tipos, restrições e chaves).	Emanuel
-- CREATE DATABASE \ adicionar um nome \
CREATE TABLE paciente (
	id SERIAL PRIMARY KEY,
	nome_completo VARCHAR(100) NOT NULL,
	cpf VARCHAR(11) NOT NULL UNIQUE,
	data_nascimento DATE NOT NULL CHECK (data_nascimento < CURRENT_DATE),
	telefone VARCHAR(20) NOT NULL,
	email VARCHAR(100) UNIQUE,
	endereco VARCHAR(200)
);

CREATE TABLE dentista (
	id SERIAL PRIMARY KEY,
	nome_completo VARCHAR(100) NOT NULL,
	cpf VARCHAR(11) NOT NULL UNIQUE,
	cro VARCHAR(20) NOT NULL UNIQUE,
	especialidade VARCHAR(80) NOT NULL,
	email VARCHAR(100) UNIQUE
);

CREATE TABLE horario_atendimento (
	id SERIAL PRIMARY KEY,
	id_dentista INT NOT NULL,
	dia_semana VARCHAR(15) NOT NULL,
	hora_inicio TIME NOT NULL,
	hora_fim TIME NOT NULL CHECK (hora_fim > hora_inicio),
	CONSTRAINT fk_horario_atendimento_dentista FOREIGN KEY (id_dentista) REFERENCES dentista(id) ON DELETE CASCADE
);

CREATE TABLE consulta (
	id SERIAL PRIMARY KEY,
	id_paciente INT NOT NULL,
	id_dentista INT NOT NULL,
	data_consulta TIMESTAMP NOT NULL,
	status VARCHAR(20) NOT NULL,
	descricao_atendimento TEXT,
	prescricao TEXT,
	CONSTRAINT fk_consulta_paciente FOREIGN KEY (id_paciente) REFERENCES paciente(id) ON DELETE RESTRICT,
	CONSTRAINT fk_consulta_dentista FOREIGN KEY (id_dentista) REFERENCES dentista(id) ON DELETE RESTRICT
);

CREATE TABLE procedimento (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL UNIQUE,
	descricao TEXT,
	duracao_media_min INT NOT NULL CHECK (duracao_media_min > 0)
);

CREATE TABLE consulta_procedimento (
	id_consulta INT NOT NULL,
	id_procedimento INT NOT NULL,
	CONSTRAINT fk_consulta_procedimento_consulta 
		FOREIGN KEY (id_consulta) REFERENCES consulta(id) ON DELETE CASCADE,
	CONSTRAINT fk_consulta_procedimento_procedimento 
		FOREIGN KEY (id_procedimento) REFERENCES procedimento(id) ON DELETE RESTRICT,
	PRIMARY KEY (id_consulta, id_procedimento)
);


-- Inserção de valores e Update.	Liliane, Caroline

-- Índices e Delete.	Arthur

-- Consultas.	Mateus

-- Modelos Conceitual (Lógico e Físico).	Letícia