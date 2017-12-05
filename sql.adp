<%
  package require rl_json

  set r [ns_conn form]
  set sqlstring [ns_set get $r sqlstring]

  ns_headers 200 application/json

  set results [dbi_rows -columns cols -result lists $sqlstring]

  set param_colitem [list]
  foreach col $cols {
     lappend param_colitem "string \"$col\""
  }
  rl_json::json set data "column" [rl_json::json new "array" {*}$param_colitem]

  set param_rowitems [list]
  foreach result $results {
     set param_rowitem [list]
     lappend param_rowitem "array"
     foreach row $result {
        lappend param_rowitem "string \"$row\""
     }

     lappend param_rowitems $param_rowitem
  }
  set data [rl_json::json set data "row" [rl_json::json new "array" {*}$param_rowitems]]

  ns_write $data
%>
