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

{% set start_date = '2025-11-01' %}
{% set end_date_str = "date_sub(now(), interval 30 minute)" %}

{% if is_incremental() %}
  {# 
    Optimization: Fetch the watermark locally in dbt so it can be passed as a static 
    literal to StarRocks, enabling predicate pushdown to the JDBC source.
  #}
  {% set watermark_query %}
    select coalesce(max(report_time), '{{ start_date }}') from {{ this }}
  {% endset %}
  
  {% if execute %}
    {% set results = run_query(watermark_query) %}
    {% set watermark = results.columns[0][0] %}
  {% else %}
    {% set watermark = start_date %}
  {% endif %}
{% endif %}

select src.report_time,
       src.user_id,
       src.other_cols
from {{ source ('src_reports','table_in_sqlserver')}} src
where src.report_time >= '{{ start_date }}' 
  and src.report_time <= {{ end_date_str }}
{% if is_incremental() %}
  and src.report_time > '{{ watermark }}'
{% endif %}
