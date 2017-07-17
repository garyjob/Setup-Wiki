## Utilization

### Setting up the funnel
Admin >> Goals >> New Goal

### Viewing the funnel
Conversion >> Goals >> Funnel Visualization


### Viewing incoming utm_source
Acquisition >> All Traffic >> Channels >> Source

## Integration
### Installation
https://developers.google.com/analytics/devguides/collection/analyticsjs/
```
<!-- Google Analytics -->
<script>
(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-XXXXX-Y', 'auto');
ga('send', 'pageview');
</script>
<!-- End Google Analytics -->
```

### Sending an event
https://developers.google.com/analytics/devguides/collection/analyticsjs/pages

```
ga('send', {
  hitType: 'pageview',
  page: location.pathname
});
```

