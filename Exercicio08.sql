CREATE TABLE Cliente (
Codigo INT IDENTITY PRIMARY KEY,
Nome VARCHAR(100) NOT NULL,
Endereco VARCHAR(100) NOT NULL,
Telefone CHAR(8) NOT NULL,
Telefone_Comercial CHAR(8));

INSERT INTO Cliente VALUES ('Luis Paulo','R. Xv de Novembro, 100','45657878',NULL);	
INSERT INTO Cliente VALUES ('Maria Fernanda','R. Anhaia, 1098','27289098','40040090');
INSERT INTO Cliente VALUES ('Ana Claudia','Av. Voluntários da Pátria, 876','21346548',NULL);	
INSERT INTO Cliente VALUES ('Marcos Henrique','R. Pantojo, 76','51425890','30394540');
INSERT INTO Cliente VALUES ('Emerson Souza','R. Pedro Álvares Cabral, 97','44236545','39389900');
INSERT INTO Cliente VALUES ('Ricardo Santos','Trav. Hum, 10','98789878',NULL);	

CREATE TABLE Tipo_Mercadoria (
Codigo INT PRIMARY KEY,
Nome VARCHAR(30) NOT NULL);

INSERT INTO Tipo_Mercadoria VALUES (10001,'Pães');
INSERT INTO Tipo_Mercadoria VALUES (10002,'Frios');
INSERT INTO Tipo_Mercadoria VALUES (10003,'Bolacha');
INSERT INTO Tipo_Mercadoria VALUES (10004,'Clorados');
INSERT INTO Tipo_Mercadoria VALUES (10005,'Frutas');
INSERT INTO Tipo_Mercadoria VALUES (10006,'Esponjas');
INSERT INTO Tipo_Mercadoria VALUES (10007,'Massas');
INSERT INTO Tipo_Mercadoria VALUES (10008,'Molhos');

CREATE TABLE Corredor (
Codigo INT PRIMARY KEY,
Tipo INT ,
Nome VARCHAR(30)

FOREIGN KEY (Tipo) REFERENCES Tipo_Mercadoria(Codigo));

INSERT INTO Corredor VALUES (101,10001,'Padaria');
INSERT INTO Corredor VALUES (102,10002,'Calçados');
INSERT INTO Corredor VALUES (103,10003,'Biscoitos');
INSERT INTO Corredor VALUES (104,10004,'Limpeza');
INSERT INTO Corredor VALUES (105,NULL,NULL);		
INSERT INTO Corredor VALUES (106,NULL,NULL);		
INSERT INTO Corredor VALUES (107,10007,'Congelados');

CREATE TABLE Mercadoria (
Codigo INT PRIMARY KEY,
Nome VARCHAR(30) NOT NULL,
Corredor INT NOT NULL,
Tipo INT NOT NULL,
Valor NUMERIC(11,2) NOT NULL

FOREIGN KEY (Corredor) REFERENCES Corredor(Codigo),
FOREIGN KEY (Tipo) REFERENCES Tipo_Mercadoria(Codigo));

INSERT INTO Mercadoria VALUES (1001,'Pão de Forma',101,10001,3.5);
INSERT INTO Mercadoria VALUES (1002,'Presunto',101,10002,2.0);
INSERT INTO Mercadoria VALUES (1003,'Cream Cracker',103,10003,4.5);
INSERT INTO Mercadoria VALUES (1004,'Água Sanitária',104,10004,6.5);
INSERT INTO Mercadoria VALUES (1005,'Maçã',105,10005,0.9);
INSERT INTO Mercadoria VALUES (1006,'Palha de Aço',106,10006,1.3);
INSERT INTO Mercadoria VALUES (1007,'Lasanha',107,10007,9.7);

CREATE TABLE Compra (
NotaFiscal INT PRIMARY KEY,
Cod_Cliente INT NOT NULL,
Valor NUMERIC(11,2) NOT NULL

FOREIGN KEY (Cod_Cliente) REFERENCES Cliente(Codigo));

INSERT INTO Compra VALUES (1234,2,200);
INSERT INTO Compra VALUES (2345,4,156);
INSERT INTO Compra VALUES (3456,6,354);
INSERT INTO Compra VALUES (4567,3,19);


SELECT C.Valor FROM Compra C
INNER JOIN Cliente CL ON (CL.Codigo = C.Cod_Cliente)
WHERE CL.Nome LIKE '%Luis Paulo%';


SELECT C.Valor FROM Compra C
INNER JOIN Cliente CL ON (CL.Codigo = C.Cod_Cliente)
WHERE CL.Nome LIKE '%Marcos Henrique%';

SELECT CL.Endereco, CL.Telefone, CL.Telefone_Comercial FROM Compra C
INNER JOIN Cliente CL ON (CL.Codigo = C.Cod_Cliente)
WHERE C.NotaFiscal = 4567;

SELECT M.Valor FROM Mercadoria M
INNER JOIN Tipo_Mercadoria TM ON (TM.Codigo = M.Tipo)
WHERE TM.Nome = 'Pães';

SELECT C.Nome FROM Corredor C
INNER JOIN Mercadoria M ON (M.Tipo = C.Tipo)
WHERE M.Nome = 'Lasanha';

SELECT C.Nome FROM Corredor C
INNER JOIN Tipo_Mercadoria TM ON (TM.Codigo = C.Tipo)
WHERE TM.Nome = 'Clorados';
