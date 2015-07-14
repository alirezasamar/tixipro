# Tixipro

### Cron job
` * * * * * cd /home/deployer/ticketing/current && /home/deployer/.rbenv/shims/rake RAILS_ENV=production cart:clear --silent >> log/cron_log.log 2>> log/cron_error_log.log `
