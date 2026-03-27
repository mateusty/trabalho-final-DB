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
-- Inserção de valores Pacientes
INSERT INTO paciente (nome_completo, cpf, data_nascimento, telefone, email, endereco)
VALUES
	('Adriano Silva Monteiro', '78429150632', '1987-03-14', '21983476125', 'adrianovm.clinic@outlook.com', 'Rua das Acácias, 142'),
	
	('Eduardo Andrade Peçanha', '31975048261', '1988-07-21', '21974583210', NULL, 'Rua Alto da Serra, 76'),
	
	('Lívia Duarte Fagundes', '90351724861', '1995-09-28', '21976549032', 'livia.kd.contato@gmail.com', 'Rua Professora Helena Coutinho, 58'),
	
	('Camila Ribeiro Tavares', '84520973164', '1999-04-11', '21988451239', NULL, 'Rua Jardim Imperial, 211'),
	
	('Caio Valente Pacheco', '64209581734', '2001-06-05', '21991274865', 'caio.valente.pac@gmail.com', 'Rua Serra Verde, 230'),
	
	('Bruno César Lopes Quintanilha', '57031849205', '1981-01-25', '21996374218', NULL, 'Rua das Laranjeiras, 95'),
	
	('Mariane Oliveira Rios', '51873926490', '1990-11-19', '21984573219', 'mariane.tamara@protonmail.com', 'Rua do Cedro, 19'),
	
	('Renata Figueiredo Campos', '29481756320', '1993-08-16', '21987653124', NULL, 'Rua Vista Alegre, 188'),
	
	('Jonatas Navarro Dantas', '27541896032', '1983-02-07', '21999843021', 'jonatas.navarro@email.com', 'Rua São Bartolomeu, 377'),
	
	('Diego Freitas Noronha', '76190534822', '2000-12-02', '21995241367', NULL, 'Rua Colina Verde, 54'),
	
	('Bianca Moura Castro', '89031645728', '1998-12-22', '21987356490', 'bianca.alencastro@icloud.com', 'Rua Padre Anchieta, 84'),
	
	('Rafael Teixeira Vilar', '73150926418', '1979-08-30', '21995478123', 'rafael.vilar@outlook.com', 'Rua Monte Azul, 265'),
	
	('Suelen Guimarães Costa', '46029378512', '2003-01-17', '21982643705', 'suelen.gb@protonmail.com', 'Rua das Palmeiras, 102'),
	
	('Leonardo Batista Cordeiro', '90271846350', '1986-05-09', '21996732048', 'leonardo.cordeiro@email.com', 'Rua José Pacheco, 49'),
	
	('Tatiane Nogueira Barros', '65830491277', '1992-10-03', '21989351762', 'tatiane.barros@gmail.com', 'Rua Bela Vista, 310');
	
-- Inserção de valores dentista 
INSERT INTO dentista (nome_completo, cpf, cro, especialidade, email)
VALUES
	('Marcelo Vinícius Torres Alvim', '83920517462', 'RJ48291', 'Ortodontia', 'marcelo.alvim@odontomail.com'),
	
	('Renata Beatriz Carvalho Peixoto', '53184029716', 'RJ88903', 'Ortodontia', NULL),
	
	('Patrícia Elaine Furtado Nogueira', '57290418635', 'RJ59302', 'Endodontia', 'patricia.nogueira@clinicmail.com'),
	
	('Rodrigo César Bastos Tavares', '91470352864', 'RJ61045', 'Implantodontia', 'rodrigo.tavares@odontoemail.com'),
	
	('Fernanda Cristine Lopes Guedes', '40618275930', 'RJ72819', 'Odontopediatria', 'fernanda.guedes@saudebucal.com'),
	
	('Gustavo Henrique Pires Salgado', '78531904621', 'RJ83472', 'Periodontia', 'gustavo.salgado@oralcare.com'),
	
	('Juliana Martins Queiroz Freire', '26389051744', 'RJ94560', 'Clínica Geral', 'juliana.freire@dentmail.com'),
	
	('Eduardo Navarro Rezende Figueira', '65047192835', 'RJ55218', 'Ortodontia', 'eduardo.figueira@odonto.com'),
	
	('Aline Cristina Borges Dantas', '19476285039', 'RJ66734', 'Dentística', 'aline.dantas@clinicodonto.com'),
	
	('Felipe Augusto Moraes Vasconcelos', '70835921460', 'RJ77125', 'Cirurgia Bucomaxilofacial', 'felipe.vasconcelos@oralmax.com');

-- Inserção de valores horário atendimento
 INSERT INTO horario_atendimento (id_dentista, dia_semana, hora_inicio, hora_fim)
 VALUES 
    (1, 'Segunda', '08:00:00', '08:40:05'),
    (2, 'Quinta',  '14:15:20', '15:10:22'),
    (4, 'Terça',   '09:30:13', '10:05:36'),
    (5, 'Quarta',  '16:15:20', '17:20:25'),
    (3, 'Sexta',   '11:00:25', '11:40:54'),
    (7, 'Terça',   '15:15:27', '16:00:36'),
    (8, 'Segunda', '11:50:40', '12:30:00'),
    (6, 'Quarta',  '09:00:25', '09:45:03'),
    (9, 'Sexta',   '14:50:03', '15:35:27'),
    (10,'Quinta',  '08:00:04', '09:20:52');

-- Inserção valores procedimentos
INSERT INTO procedimento (nome, descricao, duracao_media_min)
VALUES
	('Limpeza Dental Completa', 'Remoção de placa bacteriana e tártaro', 40),
	('Restauração em Resina', 'Recuperação de dente com material estético', 60),
	('Tratamento de Canal', 'Remoção da polpa inflamada do dente', 90),
	('Extração Simples', 'Remoção de dente comprometido', 45),
	('Clareamento Dental', 'Clareamento estético dos dentes', 50),
	('Aplicação de Flúor', 'Fortalecimento do esmalte dentário', 30),
	('Profilaxia Periodontal', 'Limpeza profunda da gengiva', 70),
	('Instalação de Aparelho Ortodôntico', 'Colocação de aparelho ortodôntico', 120),
	('Ajuste de Aparelho', 'Manutenção e ajuste do aparelho', 35),
	('Prótese Dentária Parcial', 'Substituição de dentes ausentes', 80);

-- Índices e Delete.	Arthur

-- Consultas.	Mateus

-- Modelos Conceitual (Lógico e Físico).	Letícia