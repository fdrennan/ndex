#
# This is a Plumber API. You can run the API by clicking
# the 'Run API' button above.
#
# Find out more about building APIs with Plumber here:
#
#    https://www.rplumber.io/
#

library(ndexback)

pr <- pr() %>%
  pr_filter("cors", cors) %>%
  pr_filter("logger", log_incoming) %>%
  pr_get("/user/create", user_create) %>%
  pr_get("/user/login", user_login) %>%
  pr_get("/user/logout", user_logout) %>%
  pr_get("/code/markdown", code_markdown, serializer = serializer_html()) %>%
  pr_run(host = '0.0.0.0', port = 8000)
