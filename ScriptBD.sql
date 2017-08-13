CREATE DATABASE discente_vivo;

USE discente_vivo;

CREATE TABLE ADMINISTRADOR( 
	Email VARCHAR(45),
	Nome VARCHAR(45) NOT NULL,
	Login VARCHAR(15) NOT NULL UNIQUE,
	Senha VARCHAR(8) NOT NULL,
	Cidade VARCHAR(45) NOT NULL,
	Rua VARCHAR(60) NOT NULL,
	Numero VARCHAR(8) NOT NULL,
	PRIMARY KEY(Email)
);

CREATE TABLE ALUNO(
	Matricula VARCHAR(45),
	Email VARCHAR(45) NOT NULL UNIQUE,
	Nome VARCHAR(45) NOT NULL,
	Login VARCHAR(15) NOT NULL UNIQUE,
	Senha VARCHAR(8) NOT NULL,
	Cidade VARCHAR(45) NOT NULL,
	Rua VARCHAR(60) NOT NULL,
	Numero VARCHAR(8) NOT NULL,
	PRIMARY KEY(Matricula)
);

CREATE TABLE ENQUETE(
	Id SERIAL,
	Nome VARCHAR(30) NOT NULL,
	Descricao VARCHAR(500) NOT NULL,
	Foto VARCHAR,
	emailAdmin VARCHAR(45) NOT NULL,
	FOREIGN KEY(emailAdmin) REFERENCES Administrador(email) ON DELETE RESTRICT ON UPDATE CASCADE,
	PRIMARY KEY(Id)
);

CREATE TABLE COMENTARIOS(
	Id SERIAL,
	idEnquete INT,
	Comentario VARCHAR(500) NOT NULL,
	FOREIGN KEY(idEnquete) REFERENCES Enquete(id) ON DELETE RESTRICT ON UPDATE CASCADE,
	PRIMARY KEY(Id)
);

CREATE TABLE OPCOES(
	Id SERIAL,
	idEnquete INT, 
	Opcao VARCHAR NOT NULL,
	FOREIGN KEY(idEnquete) REFERENCES Enquete(id) ON DELETE RESTRICT ON UPDATE CASCADE,
	PRIMARY KEY(Id)
);

CREATE TABLE RESPOSTAS(
	Id SERIAL,
	idEnquete INT,
	idAluno INT,
	Resposta VARCHAR NOT NULL,
	FOREIGN KEY(idEnquete) REFERENCES Enquete(Id) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY(idAluno) REFERENCES Aluno(Id) ON DELETE RESTRICT ON UPDATE CASCADE,
	PRIMARY KEY(Id)
);

CREATE TABLE CURSO(
	Nome VARCHAR(45),
	PRIMARY KEY(Nome)
);
CREATE TABLE SETOR(
	Nome VARCHAR(45),
	PRIMARY KEY(Nome)
);

CREATE TABLE SUGESTAO(
	Id SERIAL,
	Texto VARCHAR(500) NOT NULL,
	Assunto VARCHAR(100) NOT NULL,
	PRIMARY KEY(Id)
);

CREATE TABLE RESPONDEENQUETE(
	matriculaAluno VARCHAR(45),
	idEnquete INT,
	FOREIGN KEY(matriculaAluno) REFERENCES Aluno(Matricula) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY(idEnquete) REFERENCES Enquete(Id) ON DELETE RESTRICT ON UPDATE CASCADE,
	PRIMARY KEY(matriculaAluno, idEnquete)
);

CREATE TABLE ALUNOCURSO(
	matriculaAluno VARCHAR(45),
	nomeCurso VARCHAR(45),
	FOREIGN KEY(matriculaAluno) REFERENCES Aluno(Matricula) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY(nomeCurso) REFERENCES Curso(Nome) ON DELETE RESTRICT ON UPDATE CASCADE,
	PRIMARY KEY(matriculaAluno, nomeCurso)
);

CREATE TABLE ALUNOOPINA(
	matriculaAluno VARCHAR(45),
	idSugestao  INT,
	nomeSetor VARCHAR(45),
	FOREIGN KEY(matriculaAluno) REFERENCES Aluno(Matricula) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY(idSugestao) REFERENCES Sugestao(Id) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY(nomeSetor) REFERENCES Setor(Nome) ON DELETE RESTRICT ON UPDATE CASCADE,
	PRIMARY KEY(matriculaAluno, idSugestao, nomeSetor)
);

CREATE TABLE ENQUETESCURSO(
	idEnquete INT,
	nomeSetor VARCHAR(45),
	FOREIGN KEY(idEnquete) REFERENCES Enquete(Id) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY(nomeSetor) REFERENCES Setor(Nome) ON DELETE RESTRICT ON UPDATE CASCADE,
	PRIMARY KEY(idEnquete, nomeSetor)
);

CREATE TABLE ENQUETESSETOR(
	idEnquete INT,
	nomeSetor VARCHAR(45),
	FOREIGN KEY(idEnquete) REFERENCES Enquete(Id) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY(nomeSetor) REFERENCES Setor(Nome) ON DELETE RESTRICT ON UPDATE CASCADE,
	PRIMARY KEY(idEnquete, nomeSetor)
);