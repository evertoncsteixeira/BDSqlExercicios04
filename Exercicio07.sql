CREATE TABLE Clientes (
RG VARCHAR(15) PRIMARY KEY,
CPF CHAR(11) NOT NULL,
Nome VARCHAR(100) NOT NULL,
Endereco VARCHAR(100) NOT NULL);

INSERT INTO Clientes VALUES('2.953.184-4','34519878040','Luiz André','R. Astorga, 500');
INSERT INTO Clientes VALUES('13.514.996-x','84984285630','Maria Luiza','R. Piauí, 174');
INSERT INTO Clientes VALUES('12.198.554-1','23354997310','Ana Barbara','Av. Jaceguai, 1141');
INSERT INTO Clientes VALUES('23.987.746-x','43587669920','Marcos Alberto','R. Quinze, 22');


CREATE TABLE Pedido (
NotaFiscal INT PRIMARY KEY,
Valor NUMERIC(11,2) NOT NULL,
Data_Pedido DATE NOT NULL,
RG_Cliente VARCHAR(15) NOT NULL,

FOREIGN KEY (RG_Cliente) REFERENCES Clientes(RG));


INSERT INTO PEDIDO VALUES (1001,754,'04-01-2018','12.198.554-1');
INSERT INTO PEDIDO VALUES (1002,350,'04-02-2018','12.198.554-1');
INSERT INTO PEDIDO VALUES (1003,30,'04-02-2018','2.953.184-4');
INSERT INTO PEDIDO VALUES (1004,1500,'04-03-2018','13.514.996-x');

CREATE TABLE Fornecedor (
Codigo INT PRIMARY KEY,
Nome VARCHAR(50) NOT NULL,
Endereco VARCHAR(100) NOT NULL,
Telefone VARCHAR(15),
CGC VARCHAR(15),
Cidade VARCHAR(30),
Transporte VARCHAR(20),
Pais VARCHAR(30),
Moeda VARCHAR (5));

INSERT INTO Fornecedor VALUES (1,'Clone','Av. Nações Unidas, 12000','(11)4148-7000',NULL,'São Paulo',NULL,NULL,NULL);			
INSERT INTO Fornecedor VALUES (2,'Logitech','28th Street, 100','1-800-145990',NULL,NULL,'Avião','EUA','US$');
INSERT INTO Fornecedor VALUES (3,'LG','Rod. Castello Branco','0800-664400','415997810/0001','Sorocaba',NULL,NULL,NULL);			
INSERT INTO Fornecedor VALUES (4,'PcChips','Ponte da Amizade',NULL,NULL,NULL,'Navio','Py','US$');

CREATE TABLE Mercadoria (
Codigo INT PRIMARY KEY,
Descricao VARCHAR(50) NOT NULL,
Preco NUMERIC(11,2) NOT NULL,
Qtd INT NOT NULL,
Cod_Fornecedor INT NOT NULL

FOREIGN KEY (Cod_Fornecedor) REFERENCES Fornecedor(Codigo));

INSERT INTO Mercadoria VALUES (10,'Mouse',24,30,1);
INSERT INTO Mercadoria VALUES (11,'Teclado',50,20,1);
INSERT INTO Mercadoria VALUES (12,'Cx. De Som',30,8,2);
INSERT INTO Mercadoria VALUES (13,'Monitor 17',350,4,3);
INSERT INTO Mercadoria VALUES (14,'Notebook',1500,7,4);

SELECT P.Valor * 0.1 FROM PEDIDO P
WHERE P.NotaFiscal = 1003;

SELECT P.Valor * 0.05 FROM PEDIDO P
WHERE P.Valor > 700;

SELECT M.Preco * 0.2 as Desconto , M.Preco * 1.2 as PrecoNovo 
FROM Mercadoria M
WHERE M.Qtd < 10;

SELECT P.Data_Pedido, P.Valor
FROM Pedido P
INNER JOIN Clientes C ON (C.RG = P.RG_Cliente)
WHERE C.Nome LIKE  '%Luiz%';

SELECT C.* 
FROM Pedido P
INNER JOIN Clientes C ON (C.RG = P.RG_Cliente)
WHERE P.NotaFiscal = 1004;

SELECT F.Pais, F.Transporte
FROM Fornecedor F
Inner Join Mercadoria M ON (M.Cod_Fornecedor = F.Codigo)
WHERE M.Descricao = 'Cx. De Som';

SELECT M.Descricao, M.Qtd 
FROM Fornecedor F
Inner Join Mercadoria M ON (M.Cod_Fornecedor = F.Codigo)
WHERE F.Nome = 'Clone';

SELECT F.Endereco, F.Telefone
FROM Fornecedor F
Inner Join Mercadoria M ON (M.Cod_Fornecedor = F.Codigo)
WHERE M.Descricao = 'Monitor 17';

SELECT F.Moeda
FROM Fornecedor F
Inner Join Mercadoria M ON (M.Cod_Fornecedor = F.Codigo)
WHERE M.Descricao = 'Notebook';

SELECT DATEDIFF(DAY,Data_Pedido,GETDATE()) as Dias, 
CASE 
WHEN DATEDIFF(MONTH,Data_Pedido,GETDATE()) > 6 THEN
'Pedido Antigo'
ELSE
''
END AS Pedido
FROM Pedido;


SELECT C.Nome, COUNT(P.NOTAFISCAL)  
FROM Pedido P
INNER JOIN Clientes C ON (C.RG = P.RG_Cliente)
GROUP BY C.NOME;

SELECT C.Nome
FROM Clientes C 
LEFT OUTER JOIN Pedido P ON (C.RG = P.RG_Cliente)
WHERE P.RG_Cliente IS NULL;
