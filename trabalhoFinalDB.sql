-- Criação de Banco de dados / Tabelas (todas as tipos, restrições e chaves). --
CREATE DATABASE clinica_odontologica

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


-- Inserção de valores e Update. --

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

-- Inserção de valores consulta
INSERT INTO consulta (id_paciente, id_dentista, data_consulta, status, descricao_atendimento, prescricao)
VALUES
	(1, 1, '2026-02-03 08:00:00', 'realizada', 'Limpeza de rotina sem intercorrências', 'Manter higiene bucal diária'),
	(2, 2, '2026-02-04 14:20:00', 'cancelada', 'Consulta de avaliação geral', NULL),
	(3, 3, '2026-02-05 11:10:00', 'realizada', 'Paciente com dor intensa, indicado canal', 'Analgésico por 3 dias'),
	(4, 4, '2026-02-06 09:40:00', 'realizada', 'Extração de dente comprometido', 'Repouso e evitar esforço'),
	(5, 5, '2026-02-07 16:00:00', 'agendada', 'Consulta para clareamento dental', NULL),
	(6, 6, '2026-02-08 09:05:00', 'realizada', 'Tratamento periodontal preventivo', 'Uso de enxaguante bucal'),
	(7, 7, '2026-02-09 15:20:00', 'realizada', 'Aplicação de flúor', 'Evitar alimentos por 30 minutos'),
	(8, 8, '2026-02-10 12:00:00', 'agendada', 'Avaliação ortodôntica', NULL),
	(9, 9, '2026-02-11 15:00:00', 'realizada', 'Restauração em dente posterior', 'Evitar alimentos duros'),
	(10, 10, '2026-02-12 08:30:00', 'realizada', 'Cirurgia simples realizada com sucesso', 'Antibiótico por 5 dias'),
	(11, 1, '2026-02-13 08:30:00', 'realizada', 'Limpeza e profilaxia', 'Uso de fio dental'),
	(12, 2, '2026-02-14 14:40:00', 'agendada', 'Ajuste de aparelho ortodôntico', NULL),
	(13, 3, '2026-02-15 11:20:00', 'realizada', 'Canal finalizado', 'Retorno em 6 meses'),
	(14, 4, '2026-02-16 09:50:00', 'cancelada', 'Avaliação para implante', NULL),
	(15, 5, '2026-02-17 16:10:00', 'realizada', 'Atendimento odontopediátrico preventivo', 'Escovação supervisionada');



-- Inserção de valores consulta_procedimento
INSERT INTO consulta_procedimento (id_consulta, id_procedimento)
VALUES
	(1, 1),
	(3, 3),
	(4, 4),
	(5, 5),
	(6, 7),
	(7, 6),
	(8, 8),
	(9, 2),
	(10, 4),
	(10, 3),
	(11, 1),
	(12, 9),
	(13, 3),
	(14, 10),
	(15, 6);

-- Índices --

Create INDEX idx_telefone_paciente on paciente(telefone);
-- Explicação: Isso agiliza a busca do dentista por um cliente caso o profissional deseja entrar em contato com o cliente.

Create INDEX idx_especialidade_Dentista on dentista(especialidade);
--Explicação: Em caso de existir uma plataforma de uso do cliente, o mesmo consegue acessar com maior agilidade uma lista que mostra as especialidades de cada dentista.

Create INDEX idx_status_descricao on consulta(status, descricao_atendimento)
where status = 'realizada';
--Explicação: Dentista consegue ver de maneira mais acelerada a descrição do atendimento com verificação feita pelo status da consulta (realizada).

Create INDEX idx_procedimento on procedimento(descricao, duracao_media_min);
--Explicação: Em caso de existir uma plataforma de uso do cliente, o mesmo pode ter acesso agilizado a uma lista que traga todas as informações sobre um determinado procedimento.


-- Update --
UPDATE consulta 
SET status = 'realizada' 
WHERE id = 5;

UPDATE paciente 
SET telefone = '21987665433' 
WHERE nome_completo = 'Bianca Moura Castro';

UPDATE dentista 
SET especialidade = 'Ortodontia' 
WHERE cro = 'RJ61045';

-- Delete --
Delete from consulta where status = 'cancelada';


-- Não é possível deletar dentista nem procedimento devido às restrições de FK's
Delete from dentista where nome_completo = 'Gustavo Henrique Pires Salgado';
Delete from procedimento where nome = 'Profilaxia Periodontal';


-- Consultas --

-- Quantidade de consultas por especialidade
SELECT d.especialidade, count(c.id) AS qtd_consulta
	FROM dentista d
	JOIN consulta c
	ON c.id_dentista = d.id
	GROUP BY d.especialidade;

-- Quantidade de consultas por dentista (ordem decrescente)
SELECT d.nome_completo, count(c.id) AS qtd_consulta
	FROM dentista d
	JOIN consulta c
	ON c.id_dentista = d.id
	GROUP BY d.nome_completo
	ORDER BY qtd_consulta DESC;

-- Pacientes com maior número de consultas
SELECT p.nome_completo, count(c.id) AS qtd_consulta
	FROM paciente p
	JOIN consulta c
	ON c.id_paciente = p.id
	GROUP BY p.nome_completo
	ORDER BY qtd_consulta DESC;

-- VIEW — Lista de consultas ordenadas por data
CREATE VIEW vw_consultas_ordenadas AS
SELECT c.id AS id_consulta, 
		pa.nome_completo AS nome_paciente, 
		d.nome_completo AS nome_dentista, 
		c.data_consulta, 
		c.status, 
		pr.nome AS procedimentos_realizados
	FROM consulta c
	JOIN paciente pa
		ON c.id_paciente = pa.id
	JOIN dentista d
		ON c.id_dentista = d.id
	JOIN consulta_procedimento cp
		ON cp.id_consulta = c.id
	JOIN procedimento pr
		ON cp.id_procedimento = pr.id
	ORDER BY c.data_consulta DESC;

SELECT * FROM vw_consultas_ordenadas

-- Média de consultas por dentista
SELECT 1.0*avg(qtd_consulta) as media_consulta
    FROM (SELECT c.id_dentista, count(c.id) AS qtd_consulta
    FROM consulta c
    GROUP BY c.id_dentista);

-- Relaciona o dentista, sua especialidade e o procedimento das consultas agendadas, ordenadas
-- pela data da consulta em ordem decrescente
SELECT 
	d.nome_completo AS dentista,
	d.especialidade AS "Especialidade do Dentista",
	p.nome AS procedimento,
	c.data_consulta AS "Data da Consulta"
FROM 
	consulta c
JOIN 
	dentista d ON c.id_dentista = d.id
JOIN
	consulta_procedimento cp ON cp.id_consulta = c.id
JOIN
	procedimento p ON cp.id_procedimento = p.id
WHERE
	status = 'agendada'
ORDER BY
	c.data_consulta DESC;

-- Selecionar pacientes com recomendação de retorno na prescricao
SELECT
	pac.nome_completo AS paciente,
	d.nome_completo AS dentista,
	pro.nome AS procedimento,
	c.data_consulta AS "Data da última consulta"
FROM
	consulta c
JOIN 
	dentista d ON c.id_dentista = d.id
JOIN
	consulta_procedimento cp ON cp.id_consulta = c.id
JOIN
	procedimento pro ON cp.id_procedimento = pro.id
JOIN 
	paciente pac ON c.id_paciente = pac.id
WHERE 
	prescricao ILIKE '%Retorno%'
ORDER BY
	c.data_consulta;

-- Selecionar a porcentagem de consultas que cada dentista fez do total
SELECT
	d.nome_completo,
	count(c.id) AS QTD_parcial,
	CONCAT(CAST(COUNT(c.id) * 100.0 / SUM(COUNT(c.id)) OVER() AS DECIMAL(10, 2)), '%') AS porcentagem
	FROM 
		dentista d
		JOIN consulta c
			ON c.id_dentista = d.id
	GROUP BY d.nome_completo;
-- OVER() Permite a realização de cálculos com a linha atual juntamente à todas as outras linhas, juntando-as como um GROUP BY
-- CONCAT() junta valores em uma string
-- CAST() muda o tipo do dado dentro dele