Atividade Desenvolvimento 4


-- Uma loja tem um banco de dados que contém todo o controle de vendas de produtos e de cadastro de clientes. 
-- Pensando nisso, crie uma função para somar todos os clientes que foram cadastrados na loja durante um dia.

CREATE OR REPLACE FUNCTION somar_clientes_dia (data_informada DATE)
RETURNS INTEGER AS $$
DECLARE
    total_clientes INTEGER;
BEGIN
    -- Executa a consulta para obter o total de clientes cadastrados na data desejada
    SELECT COUNT(*) INTO total_clientes
    FROM clientes
    WHERE data_cadastro = data_informada;

    RETURN total_clientes;
END;
$$
LANGUAGE plpgsql;

-- Para obter o resultado da função

SELECT somar_clientes_dia('2023-07-25');
