-- Criação da extensão pgcrypto (caso não exista) para usar gen_random_uuid()
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Criação da tabela de pacientes
CREATE TABLE IF NOT EXISTS tb_patient (
                                          id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
                                          name VARCHAR(255) NOT NULL,
                                          email VARCHAR(255) NOT NULL UNIQUE,
                                          address TEXT NOT NULL,
                                          date_of_birth DATE NOT NULL,
                                          registered_date DATE NOT NULL,
                                          created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                          updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Inserção de 50 pacientes fictícios
INSERT INTO tb_patient (id, name, email, address, date_of_birth, registered_date)
VALUES
    (gen_random_uuid(), 'Maria Silva', 'maria.silva@email.com', 'Rua das Flores, 123, São Paulo, SP', '1985-03-12', '2023-01-15'),
    (gen_random_uuid(), 'João Santos', 'joao.santos@email.com', 'Av. Paulista, 1000, São Paulo, SP', '1978-06-25', '2023-02-20'),
    (gen_random_uuid(), 'Ana Oliveira', 'ana.oliveira@email.com', 'Rua Augusta, 789, São Paulo, SP', '1990-10-05', '2023-01-10'),
    (gen_random_uuid(), 'Carlos Pereira', 'carlos.pereira@email.com', 'Av. Brasil, 500, Rio de Janeiro, RJ', '1982-04-18', '2023-03-05'),
    (gen_random_uuid(), 'Juliana Costa', 'juliana.costa@email.com', 'Rua da Praia, 234, Salvador, BA', '1995-08-30', '2023-02-15'),
    (gen_random_uuid(), 'Roberto Almeida', 'roberto.almeida@email.com', 'Av. Atlântica, 1200, Rio de Janeiro, RJ', '1970-12-10', '2023-01-20'),
    (gen_random_uuid(), 'Patricia Lima', 'patricia.lima@email.com', 'Rua das Margaridas, 567, Curitiba, PR', '1988-05-22', '2023-03-10'),
    (gen_random_uuid(), 'Marcos Souza', 'marcos.souza@email.com', 'Av. Amazonas, 890, Belo Horizonte, MG', '1976-09-14', '2023-02-25'),
    (gen_random_uuid(), 'Fernanda Gomes', 'fernanda.gomes@email.com', 'Rua dos Pinheiros, 432, São Paulo, SP', '1992-11-28', '2023-01-05'),
    (gen_random_uuid(), 'Lucas Ferreira', 'lucas.ferreira@email.com', 'Av. Boa Viagem, 765, Recife, PE', '1980-07-03', '2023-03-15'),
    (gen_random_uuid(), 'Amanda Nunes', 'amanda.nunes@email.com', 'Rua da Paz, 123, Fortaleza, CE', '1993-02-17', '2023-01-25'),
    (gen_random_uuid(), 'Rafael Martins', 'rafael.martins@email.com', 'Av. Independência, 456, Porto Alegre, RS', '1975-04-09', '2023-02-10'),
    (gen_random_uuid(), 'Camila Rodrigues', 'camila.rodrigues@email.com', 'Rua das Acácias, 789, Brasília, DF', '1989-08-12', '2023-03-20'),
    (gen_random_uuid(), 'Pedro Castro', 'pedro.castro@email.com', 'Av. Goiás, 321, Goiânia, GO', '1983-10-26', '2023-01-30'),
    (gen_random_uuid(), 'Letícia Mendes', 'leticia.mendes@email.com', 'Rua dos Lírios, 654, São Luís, MA', '1997-06-15', '2023-02-05'),
    (gen_random_uuid(), 'Gustavo Barbosa', 'gustavo.barbosa@email.com', 'Av. Manaíra, 987, João Pessoa, PB', '1972-12-04', '2023-03-25'),
    (gen_random_uuid(), 'Beatriz Alves', 'beatriz.alves@email.com', 'Rua das Palmeiras, 258, Manaus, AM', '1991-03-19', '2023-01-12'),
    (gen_random_uuid(), 'Felipe Campos', 'felipe.campos@email.com', 'Av. Beira Mar, 753, Florianópolis, SC', '1979-07-23', '2023-02-18'),
    (gen_random_uuid(), 'Gabriela Cardoso', 'gabriela.cardoso@email.com', 'Rua dos Ipês, 159, Belém, PA', '1994-09-08', '2023-03-02'),
    (gen_random_uuid(), 'Ricardo Ribeiro', 'ricardo.ribeiro@email.com', 'Av. Central, 357, Campo Grande, MS', '1981-05-31', '2023-01-22'),
    (gen_random_uuid(), 'Bianca Teixeira', 'bianca.teixeira@email.com', 'Rua das Violetas, 852, Teresina, PI', '1996-01-14', '2023-02-28'),
    (gen_random_uuid(), 'Thiago Araújo', 'thiago.araujo@email.com', 'Av. Getúlio Vargas, 159, Aracaju, SE', '1973-11-20', '2023-03-08'),
    (gen_random_uuid(), 'Carolina Moreira', 'carolina.moreira@email.com', 'Rua dos Girassóis, 753, Natal, RN', '1990-02-25', '2023-01-18'),
    (gen_random_uuid(), 'Diego Pinto', 'diego.pinto@email.com', 'Av. Duque de Caxias, 951, Cuiabá, MT', '1977-04-12', '2023-02-23'),
    (gen_random_uuid(), 'Renata Lopes', 'renata.lopes@email.com', 'Rua das Orquídeas, 357, Rio Branco, AC', '1993-08-05', '2023-03-13'),
    (gen_random_uuid(), 'Bruno Cavalcanti', 'bruno.cavalcanti@email.com', 'Av. Rio Branco, 753, Maceió, AL', '1984-12-30', '2023-01-08'),
    (gen_random_uuid(), 'Vanessa Nascimento', 'vanessa.nascimento@email.com', 'Rua das Tulipas, 159, Palmas, TO', '1998-06-21', '2023-02-13'),
    (gen_random_uuid(), 'Henrique Dias', 'henrique.dias@email.com', 'Av. Juscelino Kubitschek, 357, Porto Velho, RO', '1971-10-10', '2023-03-18'),
    (gen_random_uuid(), 'Laura Freitas', 'laura.freitas@email.com', 'Rua dos Cravos, 753, Macapá, AP', '1989-01-02', '2023-01-28'),
    (gen_random_uuid(), 'Alexandre Azevedo', 'alexandre.azevedo@email.com', 'Av. Afonso Pena, 159, Belo Horizonte, MG', '1980-05-16', '2023-02-08'),
    (gen_random_uuid(), 'Natália Carvalho', 'natalia.carvalho@email.com', 'Rua das Hortênsias, 357, Santos, SP', '1995-09-27', '2023-03-22'),
    (gen_random_uuid(), 'Leonardo Fernandes', 'leonardo.fernandes@email.com', 'Av. São João, 753, Campinas, SP', '1974-03-08', '2023-01-03'),
    (gen_random_uuid(), 'Isabela Vieira', 'isabela.vieira@email.com', 'Rua dos Jasmins, 159, Niterói, RJ', '1992-07-19', '2023-02-17'),
    (gen_random_uuid(), 'André Correia', 'andre.correia@email.com', 'Av. Presidente Vargas, 357, Vitória, ES', '1982-11-01', '2023-03-27'),
    (gen_random_uuid(), 'Mariana Duarte', 'mariana.duarte@email.com', 'Rua das Camélias, 753, Ribeirão Preto, SP', '1997-04-13', '2023-01-14'),
    (gen_random_uuid(), 'Rodrigo Melo', 'rodrigo.melo@email.com', 'Av. Epitácio Pessoa, 159, Londrina, PR', '1976-08-29', '2023-02-19'),
    (gen_random_uuid(), 'Daniela Castro', 'daniela.castro@email.com', 'Rua dos Antúrios, 357, Joinville, SC', '1991-12-22', '2023-03-04'),
    (gen_random_uuid(), 'Marcelo Nogueira', 'marcelo.nogueira@email.com', 'Av. Atlântica, 753, Santos Dumont, MG', '1983-02-03', '2023-01-09'),
    (gen_random_uuid(), 'Aline Silveira', 'aline.silveira@email.com', 'Rua das Azaleias, 159, Sorocaba, SP', '1996-06-26', '2023-02-14'),
    (gen_random_uuid(), 'José Oliveira', 'jose.oliveira@email.com', 'Av. Brasil, 357, Bauru, SP', '1969-10-15', '2023-03-29'),
    (gen_random_uuid(), 'Paula Rocha', 'paula.rocha@email.com', 'Rua dos Lírios, 753, São José dos Campos, SP', '1988-02-11', '2023-01-17'),
    (gen_random_uuid(), 'Igor Santana', 'igor.santana@email.com', 'Av. Paulista, 159, Piracicaba, SP', '1981-06-07', '2023-02-22'),
    (gen_random_uuid(), 'Tatiana Cunha', 'tatiana.cunha@email.com', 'Rua das Bromélias, 357, Uberlândia, MG', '1994-10-20', '2023-03-07'),
    (gen_random_uuid(), 'Fábio Xavier', 'fabio.xavier@email.com', 'Av. Atlântica, 753, Campos dos Goytacazes, RJ', '1973-02-06', '2023-01-27'),
    (gen_random_uuid(), 'Cintia Machado', 'cintia.machado@email.com', 'Rua das Rosas, 159, Caxias do Sul, RS', '1990-05-24', '2023-02-03'),
    (gen_random_uuid(), 'Vinícius Barros', 'vinicius.barros@email.com', 'Av. Sete de Setembro, 357, Maringá, PR', '1979-09-18', '2023-03-12'),
    (gen_random_uuid(), 'Elisa Monteiro', 'elisa.monteiro@email.com', 'Rua das Margaridas, 753, Juiz de Fora, MG', '1993-01-09', '2023-01-23'),
    (gen_random_uuid(), 'Leandro Ferreira', 'leandro.ferreira@email.com', 'Av. das Américas, 159, Belford Roxo, RJ', '1975-05-27', '2023-02-09'),
    (gen_random_uuid(), 'Sandra Moraes', 'sandra.moraes@email.com', 'Rua dos Flamingos, 357, Anápolis, GO', '1992-09-03', '2023-03-17'),
    (gen_random_uuid(), 'Rafaela Costa', 'rafaela_costa@email.com', 'Rua das Orquídeas, 357, Rio Branco, AC', '1993-08-05', '2023-03-13');

-- Criação de índices para melhorar a performance
CREATE INDEX idx_patient_name ON tb_patient(name);
CREATE INDEX idx_patient_date_of_birth ON tb_patient(date_of_birth);
CREATE INDEX idx_patient_registered_date ON tb_patient(registered_date);
