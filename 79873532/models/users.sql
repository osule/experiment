with flattened_json_data as (
    select 
        *,
        filename
    from read_json_auto('data/json_files/*.json')
),

raw_json_lines as (
    select
        filename as raw_filename,
        CAST(value AS VARCHAR) as raw_json_string
    from read_csv_auto('data/json_files/*.json', header=false, columns={'value':'VARCHAR'})
)

select
  fjd.id,
  fjd.name,
  fjd.age,
  REGEXP_REPLACE(SPLIT_PART(fjd.filename, '/', -1), '\\.json$', '') as file_name,
  rjl.raw_json_string as value
from flattened_json_data fjd
join raw_json_lines rjl on fjd.filename = rjl.raw_filename
