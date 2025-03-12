
------Simple procedure------

CREATE PROCEDURE [dbo].[SelectAllPersonAddress]
AS
SELECT * FROM  Person.Address
go;

GO


EXEC [dbo].[SelectAllPersonAddress]  --activating a procedure--

DROP PROCEDURE [dbo].[SelectAllPersonAddress]


-------Procedure with parameters---------
CREATE PROCEDURE [dbo].[SelectAllPersonAddressWithParams] (@City NVARCHAR(30))
AS

BEGIN
SET NOCOUNT ON

SELECT * FROM  Person.Address where City = @city;

END
GO

EXEC SelectAllPersonAddressWithParams @city = 'New York'

EXEC SelectAllPersonAddressWithParams 'Miami'

DROP PROCEDURE [SelectAllPersonAddressWithParams]


------Procedure with parameter default value-----------

CREATE PROCEDURE [dbo].[SelectAllPersonAddressWithParams] (@City NVARCHAR(30) = 'New York')
AS

BEGIN
SET NOCOUNT ON

SELECT * FROM  Person.Address where City = @city;

END
GO


EXEC SelectAllPersonAddressWithParams 'Miami'



------------Procedure with multiple parameters-----------------

CREATE PROCEDURE [dbo].[SelectAllPersonAddressWithParams] (@City NVARCHAR(30) = 'New York',@stateProvinceid int)
AS

BEGIN
SET NOCOUNT ON

SELECT * FROM  Person.Address where City = @city;

END
GO