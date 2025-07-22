-- Criando o banco de dados
CREATE DATABASE IF NOT EXISTS meubanco;

-- Selecionando o banco de dados
USE meubanco;

-- Apagando a tabela existente (se necessário)
DROP TABLE IF EXISTS mensagens;

-- Criando a tabela mensagens com email único
CREATE TABLE mensagens (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    comentario VARCHAR(100) NOT NULL
);
