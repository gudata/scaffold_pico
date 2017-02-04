export SCAFFOLD_PICO_HOME=~/scaffold_pico
ruby -I $SCAFFOLD_PICO_HOME/lib $SCAFFOLD_PICO_HOME/bin/scaffold_pico \
  -m Admin::Vector -n administration -b AdminController \
  --fields name: description:text featured:boolean license:belongs_to group_id:integer svg:file \
  --index-fields id name imported featured \
  --search-fields name aspect_ratio license created_at \
  --fabrication \
  --services_folder=services \
  --debug --css_framework=materialize
  # --nested_in_resources \
