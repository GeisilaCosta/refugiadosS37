-- Criacao do banco de dados
CREATE DATABASE IF NOT EXISTS SistemaApoioRefugiados;
USE SistemaApoioRefugiados;

-- Tabela Usuario
CREATE TABLE Usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(25) NOT NULL,
    tipo_usuario ENUM('Admin', 'ONG', 'Voluntario', 'Refugiado') NOT NULL
);

-- Tabela ONG
CREATE TABLE ONG (
    id_ong INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    localizacao VARCHAR(255),
    area_atuacao VARCHAR(50),
    contato VARCHAR(50),
    idUsuario INT UNIQUE NULL,
    FOREIGN KEY (idUsuario) REFERENCES Usuario(id_usuario) ON DELETE SET NULL
);

-- Tabela Comunidade
CREATE TABLE Comunidade (
    id_comunidade INT PRIMARY KEY AUTO_INCREMENT,
    capacidade_acolhimento INT,
    localizacao VARCHAR(255),
    telefone VARCHAR(20),
    nome VARCHAR(100)
);

-- Tabela Refugiado
CREATE TABLE Refugiado (
    id_refugiado INT PRIMARY KEY AUTO_INCREMENT,
    id_comunidade INT NULL,
    situacao VARCHAR(50),
    data_chegada DATE,
    idioma VARCHAR(50),
    nacionalidade VARCHAR(50),
    nome VARCHAR(100),
    idUsuario INT NULL,
    FOREIGN KEY (idUsuario) REFERENCES Usuario(id_usuario) ON DELETE SET NULL,
    FOREIGN KEY (id_comunidade) REFERENCES Comunidade(id_comunidade) ON DELETE SET NULL
);

-- Tabela Voluntario
CREATE TABLE Voluntario (
    id_voluntario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    email VARCHAR(100) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    habilidades TEXT,
    disponibilidade VARCHAR(50),
    idUsuario INT UNIQUE NULL,
    FOREIGN KEY (idUsuario) REFERENCES Usuario(id_usuario) ON DELETE SET NULL
);

-- Tabela RecursoEducacional
CREATE TABLE RecursoEducacional (
    id_recurso INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(255) NOT NULL,
    tipo VARCHAR(50),
    descricao TEXT,
    idONG INT NULL,
    FOREIGN KEY (idONG) REFERENCES ONG(id_ong) ON DELETE SET NULL
);

-- Tabela HistoricoAcolhimento
CREATE TABLE HistoricoAcolhimento (
    id_historico INT PRIMARY KEY AUTO_INCREMENT,
    data_acolhimento DATE,
    idComunidade INT NOT NULL,
    situacao VARCHAR(50),
    idRefugiado INT NOT NULL,
    FOREIGN KEY (idRefugiado) REFERENCES Refugiado(id_refugiado) ON DELETE CASCADE,
    FOREIGN KEY (idComunidade) REFERENCES Comunidade(id_comunidade) ON DELETE CASCADE
);

-- Tabela Doacao
CREATE TABLE Doacao (
    id_doacao INT PRIMARY KEY AUTO_INCREMENT,
    doador VARCHAR(100),
    tipo VARCHAR(50),
    quantidade INT,
    data_doacao DATE,
    situacao VARCHAR(50),
    idVoluntario INT NULL,
    idComunidade INT NULL,
    idONG INT NULL,
    FOREIGN KEY (idVoluntario) REFERENCES Voluntario(id_voluntario) ON DELETE SET NULL,
    FOREIGN KEY (idComunidade) REFERENCES Comunidade(id_comunidade) ON DELETE SET NULL,
    FOREIGN KEY (idONG) REFERENCES ONG(id_ong) ON DELETE SET NULL
);

-- Tabela Recebe (Relacionamento ONG - Comunidade)
CREATE TABLE Recebe (
    id_ong INT NOT NULL,
    id_comunidade INT NOT NULL,
    PRIMARY KEY (id_ong, id_comunidade),
    FOREIGN KEY (id_ong) REFERENCES ONG(id_ong) ON DELETE CASCADE,
    FOREIGN KEY (id_comunidade) REFERENCES Comunidade(id_comunidade) ON DELETE CASCADE
);

-- Tabela Contribui (Relacionamento Voluntario - RecursoEducacional)
CREATE TABLE Contribui (
    id_voluntario INT NOT NULL,
    id_recurso INT NOT NULL,
    PRIMARY KEY (id_voluntario, id_recurso),
    FOREIGN KEY (id_voluntario) REFERENCES Voluntario(id_voluntario) ON DELETE CASCADE,
    FOREIGN KEY (id_recurso) REFERENCES RecursoEducacional(id_recurso) ON DELETE CASCADE
);

CREATE TABLE Usuario_ONG (
    id_usuario INT,
    id_ong INT,
    PRIMARY KEY (id_usuario, id_ong),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_ong) REFERENCES ONG(id_ong) ON DELETE CASCADE
);

