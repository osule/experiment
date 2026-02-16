{{
  config(
    materialized='incremental',
    table_type='PRIMARY',
    keys=['report_time','user_id'],
    partition_by=['date_trunc("day", report_time)'],
    partition_type='Expr',
    distributed_by = ['user_id'],
    buckets = 12
  )
}}
select src.report_time,
       src.user_id,
       src.other_cols
from {{ source ('src_reports','table_in_sqlserver')}} src
where src.report_time >= '2025-11-01' and src.report_time <= date_sub(now(), interval 30 minute)
{% if is_incremental() %}
  and src.report_time > (select coalesce(max(report_time), '2025-11-01') from {{ this }})
{% endif %}
