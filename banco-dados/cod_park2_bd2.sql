create database livraria_mirra;

-- \c livraria_mirra; usar o banco de dados em psql

create table livros (id serial primary key, nome varchar(30) not null, autor varchar(30) not null,
                     quantidade int not null, valor float not null);

create table reposicao (id serial primary key,
                        data_reposicao date not null,
                        fk_id_livro int references livros(id));

CREATE FUNCTION repor_livros() RETURNS trigger AS $repor_livros$
    BEGIN
        IF NEW.quantidade <= 0 THEN
            INSERT INTO reposicao (data_reposicao, fk_id_livro)
            VALUES (NOW(), NEW.id);
        END IF;
        RETURN NULL;
    END;
$repor_livros$ LANGUAGE plpgsql;

CREATE TRIGGER tg_reposicao_livros AFTER UPDATE OR INSERT ON livros
    FOR EACH ROW EXECUTE FUNCTION repor_livros();
