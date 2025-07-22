{{
    config(
        materialized='table'
    )
}}
select * 
from RAW.GLOBAL_MART.CUSTOMER