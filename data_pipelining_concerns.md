# Overview
Documents the various areas of the data pipelining infrastructure that would break during a scale up process

- Too much jobs queued
  - not enough slaves running crawlers to finish queued jobs per period time

- Too high quota for individual slave
  - monit threshold gets triggered before quota runs out
  - slave running forever and IP address is never refreshed

- Too low threshold per slave service
  - results in monit threshold trigger before quota runs out
  - slave running forever and IP address is never refreshed

- High volume of use
  - data server runs out of disk space
  - services stop running

- Autoscaling policy too laxed
  - Sidekiq processors not enough. jobs get queued up

- Autoscaling policy too overly zealous
  - too much Sidekiq processes running. High server cost

- Too laxed monit configuration
  - service consumes too much memory
  - entire EC2 instance freezes

- Too many queues scheduled
  - queueing service would break and loss all prior queued records is all are maintained only in memory