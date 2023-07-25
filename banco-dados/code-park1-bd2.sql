create database escola2;

-- \c escola2; caso esteja utilizando o psql

create table turma (cod_turma varchar(10) primary key, professor varchar(30) not null);

create table aluno (matricula serial primary key, nome varchar(30) not null, data_Nascimento date not null, fk_cod_turma varchar(10) not null references turma(cod_turma));

create table responsavel_legal (cod_responsavel serial primary key, fk_matricula int references aluno (matricula), nome_responsavel varchar(30) not null, parentesco varchar(10) not null);

insert into turma (cod_turma, professor)
values ('2023.1A', 'Pamela Morais'),
       ('2023-1B', 'Estephanie Góis'),
       ('2023-2A', 'Kinara Sounza'),
       ('2023-2B', 'Daniel Gomes'),
       ('2023-3A', 'Leda Duran');

insert into aluno (nome, data_Nascimento, fk_cod_turma) 
values ('Doroteia Alves', '1956-10-05', '2023.1A'),
       ('Ignácio Dantes', '1985-09-07', '2023.1A'),
       ('Leopodo Abgneu', '1987-05-07', '2023-3A'),
       ('Serafim Antonio', '1959-05-08', '2023-3A'),
       ('Galvão Peixoto', '1966-10-18', '2023-1B');

insert into responsavel_legal (fk_matricula, nome_responsavel, parentesco)
values (1, 'Jonas Serafim', 'Pai'),
       (2, 'Pablo Lopes', 'Irmão'),
       (3, 'Cesar Bezerra', 'Tio'),
       (4, 'Lula da Silva', 'Avô'),
       (5, 'Dilma Dantas', 'Mãe');

select nome, fk_cod_turma, professor from aluno as A inner join turma as T on fk_cod_turma = T.cod_turma;
 select matricula, nome, nome_responsavel, parentesco from aluno as A inner join responsavel_legal as RL on A.matricula = RL.fk_matricula;
