-- char - ASCII - 1 byte
-- varchar - ASCII - 1 byte
-- nchar - UNICODE - 2 bytes
-- nvarchar - UNICODE - 2 bytes

DECLARE @chrMyCharacters as char(10)

set @chrMyCharacters = 'hello'

SELECT @chrMyCharacters as myString, len(@chrMyCharacters) as MyLength, DATALENGTH(@chrMyCharacters) as MyDataLength

-- Always prefix nchar and nvarchar values with N (capital N).
