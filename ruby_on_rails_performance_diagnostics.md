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

This will provide visibility into the IP address of the server generating the load on the database.

If your application is constantly throwing up active record connection time out error, 
it might likely to do with your application layer concurrency configurations. 
Check to make sure the total number of concurrent connections in your application layer ```database.yml``` is not more than 
the ```max_connections``` set in your postgresql configurations file.

The above is especially true when you have start having distributed servers running in the cloud. 
If it becomes inevitable that your application layer request for more connections than your database could handle, it might be time to 
start adopting master WRTIE and slave READ database architecture. This approach is easier to manage as compared to a sharded database architecture.


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

Do note that by adding more indexes to a database table, you are doing a trade off facilitating WRITE operations
at the expense of READ operations. It is important to understand the behavioral pattern in which your application 
to determine the best combination of indexes to utilize on your database tables


### Diagnosing suspicious network activities
Unless your server is specifically built to allow automated interactions by other systems, high volumes of 
repeated request from the same IP address can be flagged as suspicious. 

To further confirm the situation, check the User agent header to determine traffic source. 

If heavy is identified to be from either Google or Bing, it would be wise to log into your webmaster console 
on their servers to configure the rate at which your site should get crawled.

If it is from some dubious IP address, first check to see if IP address is from AWS via their public directory
you could easily contact the owner to lower his crawl rate. 

In worse case scenario, start throttling traffic by IP address. That should head off DDOS like traffic to your servers.