# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.precompile += %w( infobox.js map.js bootstrap-timepicker.js bootstrap-datepicker.js icheck.js jquery.sliderPro.min.js timer.jquery.js jquery-1.11.2.min.js common_scripts_min.js functions.js base.css fontello/css/icon_set_1.css fontello/css/icon_set_2.css fontello/css/fontello.css)
