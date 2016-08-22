Default location Google Go is installed when using the package manage on MacOSX
  /usr/local/go/bin

Running a GO script
  go run script.go

Setup environment
  References : 
    http://golang.org/doc/code.html

  export GOPATH=/path/to/your/go/workspace
  export PATH=$PATH:/path/to/your/go/workspace/bin

Importing new libraries
  Do git clone repository in <<root project>>/src/github.com/garyjob/

When package is main

  run the following command at the <<project space>>/src
    go install github.com/garyjob/go-thrift

  Command will create a binary file in the <<root project>>/bin folder


When package is not main

  run the following command at the <<project space>>/src
    go install github.com/garyjob/hello-go
    go install github.com/edmodo/deliver    
    
  Command will create a .a file in the <<root project>>/pkg folder

Go build command
  creates a package in at <<project space>>/src

Installing remote packages
  go get git.apache.org/thrift.git/lib/go/thrift
  go get github.com/edmodo/deliver
  
  remote all protocols
  
  To consider trying — deliver