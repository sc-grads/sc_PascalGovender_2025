select system_type_id, column_id,system_type_id*1.00 / column_id as Calculation
from sys.all_columns

select system_type_id, column_id, floor(system_type_id*1.00 /column_id) as Calculation
from sys.all_columns

select system_type_id, column_id, Cast(system_type_id*1.00 / column_id as decimal(8,1)) as Calculation
from sys.all_columns


select try_Convert(tinyint,system_type_id*2), column_id, Cast(system_type_id*1.00 / column_id as decimal(8,1)) as Calculation
from sys.all_columns