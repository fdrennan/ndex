library(ndex)
library(shiny.router)
library(shinyjs)
dotenv::load_dot_env()
# system('/home/freddy/.node/node-v17.4.0-linux-x64/bin/sass ./www/styles.scss ./www/styles.css')



router <- make_router(
  # If adding or deleting, please also update
  # the navbar
  route("/", ui_home()),
  route("about", h1("About", class = "display-1")),
  route("theme", bs_text_ui()),
  route("settings", ui_settings("settings", "testuser"))
)


#' ui
#' @export
ui <- function(incoming) {
  html_page(
    title = "ndexr",
    ui_navbar(),
    router$ui,
    HTML('<!-- Footer -->
          <footer class="bg-dark text-center text-white">
            <!-- Grid container -->
            <div class="container p-4">
              <!-- Section: Social media -->
              <section class="mb-4">

                <!-- Twitter -->
                <a class="btn btn-outline-light btn-floating m-1" href="#!" role="button"
                  ><i class="bi bi-twitter"></i></i></i></a>

                <!-- Linkedin -->
                <a class="btn btn-outline-light btn-floating m-1" href="#!" role="button"
                  ><i class="bi bi-linkedin"></i
                ></a>

                <!-- Github -->
                <a class="btn btn-outline-light btn-floating m-1" href="#!" role="button"
                  ><i class="bi bi-github"></i></i
                ></a>
              </section>
              <!-- Section: Social media -->

              <!-- Section: Form -->
              <section class="">
                <form action="">
                  <!--Grid row-->
                  <div class="row d-flex justify-content-center">
                    <!--Grid column-->
                    <div class="col-auto">
                      <p class="pt-2">
                        <strong>Sign up for our newsletter</strong>
                      </p>
                    </div>
                    <!--Grid column-->

                    <!--Grid column-->
                    <div class="col-md-5 col-12">
                      <!-- Email input -->
                      <div class="form-outline form-white mb-4">
                        <input type="email" id="form5Example21" class="form-control" />
                        <label class="form-label" for="form5Example21">Email address</label>
                      </div>
                    </div>
                    <!--Grid column-->

                    <!--Grid column-->
                    <div class="col-auto">
                      <!-- Submit button -->
                      <button type="submit" class="btn btn-outline-light mb-4">
                        Subscribe
                      </button>
                    </div>
                    <!--Grid column-->
                  </div>
                  <!--Grid row-->
                </form>
              </section>
              <!-- Section: Form -->

              <!-- Section: Links -->
              <section class="">
                <!--Grid row-->
                <div class="row">
                  <!--Grid column-->
                  <div class="col-lg-6 col-md-6 mb-4 mb-md-0">
                    <h5 class="text-uppercase">Links</h5>

                    <ul class="list-unstyled mb-0">
                      <li>
                        <a href="#!" class="text-white">Link 1</a>
                      </li>
                      <li>
                        <a href="#!" class="text-white">Link 2</a>
                      </li>
                    </ul>
                  </div>
                  <!--Grid column-->

                  <!--Grid column-->
                  <div class="col-lg-6 col-md-6 mb-4 mb-md-0">
                    <h5 class="text-uppercase">Links</h5>

                    <ul class="list-unstyled mb-0">
                      <li>
                        <a href="#!" class="text-white">Link 1</a>
                      </li>
                      <li>
                        <a href="#!" class="text-white">Link 2</a>
                      </li>
                    </ul>
                  </div>
                  <!--Grid column-->
                </div>
                <!--Grid row-->
              </section>
              <!-- Section: Links -->
            </div>
            <!-- Grid container -->

            <!-- Copyright -->
            <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2);">
              © 2020 Copyright:
              <a class="text-white" href="https://mdbootstrap.com/">MDBootstrap.com</a>
            </div>
            <!-- Copyright -->
          </footer>
          <!-- Footer -->')
  )
}



#' server
#' @export
server <- function(input, output, session) {
  router$server(input, output, session)
  server_home()
  server_navbar()
}

shinyApp(
  ui = ui,
  server = server
)
