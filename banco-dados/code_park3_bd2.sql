CREATE DATABASE loja;

\c loja;

CREATE TABLE produto (id SERIAL PRIMARY KEY, nome VARCHAR(30) NOT NULL, valor FLOAT NOT NULL, quantidade INT NOT NULL, descricao VARCHAR(50));

CREATE TABLE vendas (id SERIAL PRIMARY KEY, data_venda DATE NOT NULL, quantidade_vendida INT NOT NULL, fk_id_produto INT NOT NULL REFERENCES produto(id), subtotal FLOAT NOT NULL);

CREATE TABLE relatorio_vendas (fk_id_produto INT NOT NULL, nome_produto VARCHAR(30) NOT NULL, quantidade INT NOT NULL, data DATE NOT NULL, valor_venda FLOAT NOT NULL);
 
INSERT INTO produto (nome, valor, quantidade) VALUES 
('ventilador', 124.08, 10),
('tv', 5000.00, 50),
('celular', 5000.00, 4);

INSERT INTO vendas (data_venda, quantidade_vendida, fk_id_produto, subtotal) VALUES
('2023-07-24', 1, 1, 124.08),
('2023-07-24', 1, 2, 5000.00),
('2023-07-24', 1, 2, 5000.00);

CREATE OR REPLACE PROCEDURE relatorio_vendas (pdata DATE) 
AS $$
BEGIN
DELETE FROM relatorio_vendas WHERE data = pdata;

INSERT INTO relatorio_vendas(fk_id_produto, nome_produto, quantidade, data, valor_venda) 
SELECT p.id, nome, SUM(quantidade_vendida), pdata, SUM(subtotal) 
FROM produto AS p 
  JOIN vendas AS v ON v.fk_id_produto = p.id 
WHERE v.data_venda = pdata
GROUP BY p.id;
END;
$$ LANGUAGE plpgsql;

-- chamar o relatório antes de tentar visualizar o relatório, é necessário chamar a procedure.
CALL relatorio_vendas('2023-07-24');

SELECT * FROM relatorio_vendas;