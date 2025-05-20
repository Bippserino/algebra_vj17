-- NAPIŠITE PROCEDURU KOJA PRIMA KRITERIJI PO KOJEMU ĆETE FILTRIRATI PREZIMENA IZ TABLICE KUPAC. NEKA PROCEDURA POMOĆU IZLAZNOG PARAMETRA VRATI BROJ ZAPISA KOJI ZADOVOLJAVAJU ZADANI KRITERIJ. NEKA PROCEDURA VRATI I SVE ZAPISE KOJI ZADOVOLJAVAJU KRITERIJ. POZOVITE PROCEDURU I ISPIŠTINE VRAĆENU VRIJEDNOST. UKLONITE PROCEDURU

CREATE PROCEDURE FiltrirajKupcePoPrezimenu
    @kriterij NVARCHAR(100),
    @brojKupaca INT OUTPUT
AS
BEGIN
    SELECT @brojKupaca = COUNT(*)
    FROM kupac
    WHERE prezime LIKE @kriterij

    SELECT * 
    FROM kupac
    WHERE prezime LIKE @kriterij
END
GO

DECLARE @broj INT

EXEC FiltrirajKupcePoPrezimenu 'M%', @broj OUTPUT

DROP PROCEDURE FiltrirajKupcePoPrezimenu
GO
-- Napišite proceduru koja za zadanog komercijalistu pomoću izlaznih parametara vraća njegovo ime i prezime te ukupnu količinu izdanih računa

CREATE PROCEDURE FiltrirajKomercijalistu
    @ID INT,
    @ime NVARCHAR(50) OUTPUT,
    @prezime NVARCHAR(50) OUTPUT,
    @ukupnoRacuna INT OUTPUT
AS
BEGIN
    SELECT 
        @ime = Ime,
        @prezime = Prezime
    FROM komercijalist
    WHERE @ID = IDKomercijalist

    SELECT 
        @ukupnoRacuna = COUNT(*)
    FROM racun
    WHERE KomercijalistID = @ID
END
GO

DECLARE @imeKom NVARCHAR(50)
DECLARE @prezimeKom NVARCHAR(50)
DECLARE @brRacuna INT

EXEC FiltrirajKomercijalistu 
    @ID = 268,
    @ime = @imeKom OUTPUT,
    @prezime = @prezimeKom OUTPUT,
    @ukupnoRacuna = @brRacuna OUTPUT

PRINT 'Ime: ' + @imeKom
PRINT 'Prezime: ' + @prezimeKom
PRINT 'Ukupno izdanih računa: ' + CAST(@brRacuna AS NVARCHAR)

DROP PROCEDURE FiltrirajKomercijalistu
GO