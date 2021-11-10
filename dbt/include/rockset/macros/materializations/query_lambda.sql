{% materialization query_lambda, adapter='rockset' -%}  
   {% set target_relation = this.incorporate(type='view') %}
   {% set rockset_tag = config.get('rockset_tag',default=target.name) %}
   {% set query_parameters = config.get('query_parameters',default=[]) %}
   {{ adapter.create_query_lambda(target_relation, sql, rockset_tag,query_parameters) }}

   {#-- All logic to create Query Lambdas happens in create_query_lambda --#}
   {% call statement('main') -%}
      {{ adapter.get_dummy_sql() }}
   {%- endcall %}

   {{ run_hooks(post_hooks) }}

   {% do persist_docs(target_relation, model) %}

   {{ return({'relations':[target_relation]}) }}
{%- endmaterialization %}
