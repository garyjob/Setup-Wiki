# Ruby on Rails performance diagnostics

Lagging performance on web application conforms to the 80/20 rule where 20% of non-performant code
contribute to 80% of actual poor performance.

This document describes in detail how to diagnose observed slow response time from a RAILS web server 
with a Postgresql database. 


### Enable logging in production environment for better visibility on individual execution performance

In your rails application change the configuration in ```production.rb``` to
```
config.log_level = :debug
```

This will output all executions and corresponding execution time into log file


### Enable tracking of user agent and IP address to detect suspicious activities

Add the following lines of code to your application controller
```
class ApplicationController < ActionController::Base 
  around_filter :global_request_logging

  def global_request_logging 
    logger.info "USERAGENT: #{request.headers['HTTP_USER_AGENT']}"
    begin 
      yield 
    ensure 
      logger.info "response_status: #{response.status}"
    end 
  end 
end
```
This will help surface suspicious IP addresses that might be artificially generating heightended levels 
of load on the servers. 


### Checking the source of load on the database
Next SSH into the postgresql database and run 
```
htop
```

This will provide visibility into the IP address of the server generating the load on the database


### Identifying slow database queries
Once you are SSH into the load causing Rails server instance start tailing the corresponding log files.
Location of log file depends on the instance type you logged into, namely

- web server
- background worker

Command to tail the log file
```
tail -f LOG_FILE_LOCATION
```

Start looking for functions that take more than 1000 milli-seconds to complete.


### Diagnosing slow database queries
In your Postgresql database run the following

```
EXPLAIN ANALYSE YOUR_SLOW_QUERY
```

This should provide visibility into potential missing indexes that should be included in your database table.


### Diagnosing suspicious network activities
Unless your server is specifically built to allow automated interactions by other systems, high volumes of 
repeated request from the same IP address can be flagged as suspicious. 

To further confirm the situation, check the User agent header to determine traffic source. 

If heavy is identified to be from either Google or Bing, it would be wise to log into your webmaster console 
on their servers to configure the rate at which your site should get crawled.

If it is from some dubious IP address, first check to see if IP address is from AWS via their public directory
you could easily contact the owner to lower his crawl rate. 

In worse case scenario, start throttling traffic by IP address. That should head off DDOS like traffic to your servers.