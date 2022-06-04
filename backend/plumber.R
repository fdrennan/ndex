#
# This is a Plumber API. You can run the API by clicking
# the 'Run API' button above.
#
# Find out more about building APIs with Plumber here:
#
#    https://www.rplumber.io/
#

library(ndexback)
devtools::load_all()
# run_port = 8231
run_port <- 8000
pr <- pr() %>%
  pr_filter("cors", cors) %>%
  pr_filter("logger", log_incoming) %>%
  pr_get("/user/create", user_create) %>%
  pr_get("/user/logout", user_logout) %>%
  pr_get("/code/markdown", code_markdown, serializer = serializer_html()) %>%
  pr_get("/code/course", code_course, serializer = serializer_html()) %>%
  pr_run(host = "0.0.0.0", port = run_port)
