create database escola;

-- \c escola; -- Uso esse comando no psql.exe

create table aluno (
    id serial primary key,
    nome varchar(255) not null,
    email varchar(255) not null,
    endereco varchar(255) not null
);