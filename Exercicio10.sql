CREATE TABLE Medicamento (
Codigo INT IDENTITY PRIMARY KEY,
Nome VARCHAR(100) NOT NULL,
Apresentacao VARCHAR(50) NOT NULL,
Unidade VARCHAR(30) NOT NULL,
Preco NUMERIC(11,3));

 INSERT INTO Medicamento VALUES('Acetato de medroxiprogesterona','150 mg/ml','Ampola',6.700);
 INSERT INTO Medicamento VALUES('Aciclovir','200mg/comp.','Comprimido',0.280);
 INSERT INTO Medicamento VALUES('Ácido Acetilsalicílico','500mg/comp.','Comprimido',0.035);
 INSERT INTO Medicamento VALUES('Ácido Acetilsalicílico','100mg/comp.','Comprimido', 0.030);
 INSERT INTO Medicamento VALUES('Ácido Fólico','5mg/comp.','Comprimido',0.054);
 INSERT INTO Medicamento VALUES('Albendazol','400mg/comp. mastigável','Comprimido',0.560);
 INSERT INTO Medicamento VALUES('Alopurinol','100mg/comp.','Comprimido',0.080);
 INSERT INTO Medicamento VALUES('Amiodarona','200mg/comp.','Comprimido',0.200);
 INSERT INTO Medicamento VALUES('Amitriptilina(Cloridrato)','25mg/comp.','Comprimido',0.220);
 INSERT INTO Medicamento VALUES('Amoxicilina','500mg/cáps.','Cápsula',0.190);

CREATE TABLE Cliente (
CPF CHAR(11) PRIMARY KEY,
Nome VARCHAR(100) NOT NULL,
Rua VARCHAR(100) NOT NULL,
Numero INT NOT NULL,
Bairro VARCHAR(50) NOT NULL,
Telefone CHAR(8) NOT NULL);

INSERT INTO Cliente VALUES('34390898700','Maria Zélia','Anhaia',65,'Barra Funda','92103762');
INSERT INTO Cliente VALUES('21345986290','Roseli Silva','Xv. De Novembro',987,'Centro','82198763');
INSERT INTO Cliente VALUES('86927981825','Carlos Campos','Voluntários da Pátria',1276,'Santana','98172361');
INSERT INTO Cliente VALUES('31098120900','João Perdizes','Carlos de Campos',90,'Pari','61982371');

CREATE TABLE Venda (
NotaFiscal INT NOT NULL,
CPF_Cliente CHAR(11) NOT NULL,
Cod_Medicamento INT NOT NULL,
Qtd INT NOT NULL,
Valor_Total NUMERIC(11,2),
Data_Venda Date

PRIMARY KEY (NotaFiscal,CPF_Cliente,Cod_Medicamento)
FOREIGN KEY (CPF_Cliente) REFERENCES Cliente(CPF),
FOREIGN KEY (Cod_Medicamento) REFERENCES Medicamento(Codigo));

INSERT INTO Venda VALUES(31501,'86927981825',10,3,0.57,'11-01-2010');
INSERT INTO Venda VALUES(31501,'86927981825',2,10,2.8,'11-01-2010');
INSERT INTO Venda VALUES(31501,'86927981825',5,30,1.05,'11-01-2010');
INSERT INTO Venda VALUES(31501,'86927981825',8,30,6.6,'11-01-2010');
INSERT INTO Venda VALUES(31502,'34390898700',8,15,3,'11-01-2010');
INSERT INTO Venda VALUES(31502,'34390898700',2,10,2.8,'11-01-2010');
INSERT INTO Venda VALUES(31502,'34390898700',9,10,2.2,'11-01-2010');
INSERT INTO Venda VALUES(31503,'31098120900',1,20,134,'11-02-2010');


SELECT M.Nome,M.Apresentacao,M.Unidade,M.Preco
FROM Medicamento M 
LEFT OUTER JOIN Venda V ON (V.Cod_Medicamento = M.Codigo)
WHERE V.Cod_Medicamento IS NULL;

SELECT C.Nome
FROM Cliente C
INNER JOIN Venda V ON (V.CPF_Cliente = C.CPF)
INNER JOIN Medicamento M ON (M.Codigo = V.Cod_Medicamento)
WHERE M.Nome = 'Amiodarona';

SELECT C.CPF,C.Rua + ' nº ' + CAST(C.Numero AS VARCHAR(11)) + ' bairro ' + C.Bairro AS Endereco, 
M.Nome as Nome_Remedio, M.Apresentacao, M.Unidade, M.Preco, V.Qtd, V.Valor_Total
FROM Cliente C
INNER JOIN Venda V ON (V.CPF_Cliente = C.CPF)
INNER JOIN Medicamento M ON (M.Codigo = V.Cod_Medicamento)
WHERE C.Nome = 'Maria Zélia';

SELECT CAST(DATEPART(DAY,V.Data_Venda) AS CHAR(2)) + '/' + CAST(DATEPART(MONTH,V.Data_Venda) AS CHAR(2)) 
+ '/' +CAST(DATEPART(YEAR,V.Data_Venda) AS CHAR(4)) AS Data_Venda
FROM Cliente C
INNER JOIN Venda V ON (V.CPF_Cliente = C.CPF)
INNER JOIN Medicamento M ON (M.Codigo = V.Cod_Medicamento)
WHERE C.Nome = 'Carlos Campos';