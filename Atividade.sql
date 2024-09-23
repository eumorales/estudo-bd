
DECLARE @ProdutoNome VARCHAR(50), @EstoqueQtd INT, @ProdutoPreco DECIMAL(10, 2);
SET @ProdutoNome = 'Notebook';
SET @EstoqueQtd = 15;
SET @ProdutoPreco = 2999.99;

PRINT 'Nome do Produto: ' + @ProdutoNome;
PRINT 'Quantidade em Estoque: ' + CAST(@EstoqueQtd AS VARCHAR);
PRINT 'Preço do Produto: ' + CAST(@ProdutoPreco AS VARCHAR);

SELECT @ProdutoNome AS Produto, @EstoqueQtd AS Quantidade, @ProdutoPreco AS Preco;

DECLARE @BaseSalario DECIMAL(10, 2), @Adicional DECIMAL(10, 2), @SalarioFinal DECIMAL(10, 2);
SET @BaseSalario = 5000.00;
SET @Adicional = 800.00;
SET @SalarioFinal = @BaseSalario + @Adicional;

PRINT 'Salário Total: ' + CAST(@SalarioFinal AS VARCHAR);
SELECT @SalarioFinal AS SalarioTotal;

SELECT CAST(GETDATE() AS VARCHAR(10)) AS DataAtual;
SELECT CONVERT(INT, 12345.67) AS NumeroConvertido;

DECLARE @ValorDecimal DECIMAL(10, 2), @ValorInteiro INT;
SET @ValorDecimal = 1234.56;
SET @ValorInteiro = 1234;

SELECT CAST(@ValorDecimal AS INT) AS DecimalParaInteiro;
SELECT CONVERT(DECIMAL(10, 2), @ValorInteiro) AS InteiroParaDecimal;

DECLARE @DataNasc VARCHAR(10);
SET @DataNasc = '15/08/1990';
SELECT CONVERT(DATE, @DataNasc, 103) AS DataFormatada;

DECLARE @Anos INT;
SET @Anos = 20;
IF @Anos >= 18 
    PRINT 'Maior de Idade';
ELSE 
    PRINT 'Menor de Idade';

DECLARE @FinalNota INT;
SET @FinalNota = 85;
IF @FinalNota >= 90 
    PRINT 'Aprovado com Excelência';
ELSE IF @FinalNota >= 70 AND @FinalNota < 90 
    PRINT 'Aprovado';
ELSE IF @FinalNota >= 50 AND @FinalNota < 70 
    PRINT 'Em Recuperação';
ELSE 
    PRINT 'Reprovado';

DECLARE @AnoAtual INT;
SET @AnoAtual = 2024;
IF (@AnoAtual % 4 = 0 AND @AnoAtual % 100 <> 0) OR (@AnoAtual % 400 = 0)
    PRINT 'Ano Bissexto';
ELSE 
    PRINT 'Ano Comum';

DECLARE @LoopCount INT;
SET @LoopCount = 1;
WHILE @LoopCount <= 10 
BEGIN
    PRINT @LoopCount;
    SET @LoopCount = @LoopCount + 1;
END;

DECLARE @StartValue INT;
SET @StartValue = 100;
WHILE @StartValue >= 50 
BEGIN
    PRINT @StartValue;
    SET @StartValue = @StartValue - 5;
END;

DECLARE @IndiceAtual INT, @LimitePreco DECIMAL(10, 2);
SET @IndiceAtual = 1;
SET @LimitePreco = 100;

WHILE EXISTS (SELECT 1 FROM Produtos WHERE Preco > @LimitePreco) 
BEGIN
    DECLARE @NomeProdutoSelecionado VARCHAR(50);
    SELECT @NomeProdutoSelecionado = Nome FROM Produtos WHERE Preco > @LimitePreco 
    ORDER BY Nome OFFSET @IndiceAtual - 1 ROWS FETCH NEXT 1 ROW ONLY;

    IF @NomeProdutoSelecionado IS NOT NULL 
    BEGIN
        PRINT @NomeProdutoSelecionado;
        SET @IndiceAtual = @IndiceAtual + 1;
    END 
    ELSE 
        BREAK;
END;

DECLARE @NumeroAtual INT;
SET @NumeroAtual = 2;
WHILE @NumeroAtual <= 1000 
BEGIN
    PRINT @NumeroAtual;
    SET @NumeroAtual = @NumeroAtual * 2;
END;

CREATE PROCEDURE CalculoDesconto
    @PrecoInicial DECIMAL(10, 2),
    @Qtd INT,
    @PrecoComDesconto DECIMAL(10, 2) OUTPUT
AS
BEGIN
    DECLARE @TaxaDesconto DECIMAL(10, 2), @PrecoDesconto DECIMAL(10, 2), @ContadorQtd INT;
    SET @TaxaDesconto = 0;

    IF @Qtd > 10 
        SET @TaxaDesconto = 0.10;
    ELSE 
    BEGIN
        IF @Qtd < 5 
        BEGIN
            SET @TaxaDesconto = 0;
            SET @ContadorQtd = 1;

            WHILE @ContadorQtd < @Qtd 
            BEGIN
                SET @TaxaDesconto = @TaxaDesconto + 0.01;
                SET @ContadorQtd = @ContadorQtd + 1;
            END;
        END;
    END;

    SET @PrecoDesconto = @PrecoInicial * (1 - @TaxaDesconto);
    SET @PrecoComDesconto = @PrecoDesconto;
END;

DECLARE @PrecoFinalCalc DECIMAL(10, 2);
EXEC CalculoDesconto @PrecoInicial = 100.00, @Qtd = 4, @PrecoComDesconto = @PrecoFinalCalc OUTPUT;
SELECT @PrecoFinalCalc AS PrecoFinal;
