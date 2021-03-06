test_that("trying to use Selenium",{
  skip("for now")
  skip_on_appveyor()
  skip_on_travis()

  #library(RSelenium)
  #http://support.divio.com/articles/646695-how-to-use-a-directory-outside-c-users-with-docker-toolbox-docker-for-windows
  #docker run -d -p 4445:4444 -p 5901:5900 -v ${pwd}:/home/statistics selenium/standalone-firefox-debug:2.53.0
  # vnc viewer  password = secret

  remDr <- remoteDriver(
    remoteServerAddr = "192.168.99.100",
    port = 4445L,
    browserName = "firefox"
  )
  #remDr$close()
  remDr$open()
  remDr$navigate("https://eudract-training.ema.europa.eu/results-web/login/login.xhtml")
  userid <- remDr$findElement(using = "name", value = "username")
  userid$sendKeysToElement(list("w6a6w8"))
  password <- remDr$findElement(using= "name", value="password")
  password$sendKeysToElement(list("London2016",key="enter"))



  #login <- remDr$findElement(using="value", value="Login")
  #login$clickElement()

  #script <- "mojarra.jsfcljs(document.getElementById('cta_form'),{'resultsInEditList:1:editCtaLink':'resultsInEditList:1:editCtaLink','resultToEdit':'0015-002811-13'},'')"
  #remDr$executeScript(script, args = list())

  edit_first_item <- remDr$findElement(using="id", value="resultsInEditList:1:editCtaLink")
  edit_first_item$clickElement()

  upload <- remDr$findElement(using="id", value="load_results")
  upload$clickElement()

  confirm <- remDr$findElement(using="id", value="confirmUpload")
  confirm$clickElement()

  select_ae <- remDr$findElement(using="xpath", value="//*/option[@value='ADVERSE_EVENTS']")
  select_ae$clickElement()

  #Can't work out hwo to interact with the file choose menu

  add_file2 <-remDr$findElement(using="id", value="fileUploader:add1")
  #might work - but still have to link the local files to the docker image...
  remDr$getWindowHandles()
  remDr$getCurrentWindowHandle()

  remDr$sendKeysToAlert(list("boo"))

  remDr$close()

  testCsv <- tempfile(fileext = ".csv")
  x <- data.frame(a = 1:4, b = 5:8, c = letters[1:4])
  write.csv(x, testCsv, row.names = FALSE)


  add_file2$sendKeysToElement(list(testCsv))

  add_file2$clickElement()
  add_file2$getElementText()


  remDr$screenshot(display=TRUE)
  remDr$getTitle()


  shell("docker stop $(docker ps -q)")
}
)
