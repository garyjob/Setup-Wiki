Default location Google Go is installed when using the package manage on MacOSX
  - /usr/local/go/bin

Running a GO script
  - go run script.go

Setup environment
  - References : 
    - http://golang.org/doc/code.html

  - export GOPATH=/path/to/your/go/workspace
  - export PATH=$PATH:/path/to/your/go/workspace/bin

Importing new libraries
  - Do git clone repository in <<root project>>/src/github.com/garyjob/

When package is main

  - run the following command at the <<project space>>/src
    - go install github.com/garyjob/go-thrift

  - Command will create a binary file in the <<root project>>/bin folder


When package is not main

  - run the following command at the <<project space>>/src
    - go install github.com/garyjob/hello-go
    - go install github.com/edmodo/deliver    
  
  - Command will create a .a file in the <<root project>>/pkg folder

Go build command
  - creates a package in at <<project space>>/src

Installing remote packages
  - go get git.apache.org/thrift.git/lib/go/thrift
  - go get github.com/edmodo/deliver
  
  - remote all protocols
  
  - To consider trying — deliver

Unit testing
  - proceed to folder and then run 
  ```
  go test
  ```

  - Shaving time off compile time per compile time
  ```
  go install
  ```

  - to auto-run after each save. To ensure we run it in the subfolder instead of the main folder
  ```
  ginkgo watch
  ```

  - Unit individual UNIT test files - included all dependencies
  ```
  go test quiz_submissions_finish_handler_test.go quiz_submissions_finish_handler.go quiz_submissions_wrapper_handler.go quiz_submissions_handler.go test_factories.go grades_handler.go messages_handler.go replies_handler.go quiz_contents_handler.go quiz_user_answers_handler.go assignments_handler.go assignment_submissions_handler.go replies_helper.go reactions_handler.go quizzes_handler.go events_handler.go notifications_handler.go poll_votes_handler.go follows_handler.go message_pins_handler.go timeline_handler.go embeds_handler.go links_handler.go files_handler.go assignment_templates_handler.go library_items_handler.go standalone_grades_handler.go assignment_submission_replies_handler.go replies_threaded_handler.go messages_threaded_handler.go grades_handler_test.go  handlers_suite_test.go
  ```