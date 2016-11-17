# Overview
Documents the various parameters to be aware of when doing web crawling at scale

- Too much jobs queued
  - not enough slaves running crawlers to finish queued jobs per period time

- Too high quota for individual slave
  - monit threshold gets triggered before quota runs out
  - slave running forever and IP address is never refreshed

- Too low threshold per service running in individual slave
  - results in monit threshold trigger before quota runs out
  - slave running forever and IP address is never refreshed

- High volume of usage
  - data server runs out of disk space
  - services stop running
  - UI/UX needs to change to display more items in queue

- Autoscaling policy too laxed
  - Sidekiq processors not enough. jobs get queued up

- Autoscaling policy too overly zealous
  - too much Sidekiq processes running. High server cost

- Too laxed monit configuration
  - service consumes too much memory
  - entire EC2 instance freezes

- Too many queues scheduled
  - queueing service would break and loss all prior queued records is all are maintained only in memory
  - UI/UX needs to change to display more items that are not maintained in memory

- Too many concurrent crawlers deployed to harvest data from site
  - site detects crawling activites and blocks data harvesting
  - site suffers from undesirable Denial of Service attack

- Queueing service goes down
  -Slaves fail to reboot
