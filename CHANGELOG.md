## v0.0.6:

* Enhance : Include ohai-system_packages plugin statistics if available.

## v0.0.5:

* Bug     : Update to use chef_gem for compatibility with omnibus chef installs.

## v0.0.4:

* Bug     : Stop attempting to print an exception when an error occurs writing to graphite as this can result in an
            an attempt to render the entire state of the chef context if the exception refers to the context.

## v0.0.3:

* Enhance : Improve the error handling when the graphite server is unable to be accessed when the reporter handler
            executes.
* Bug     : Use `Chef::Config[:file_cache_path]}` to determine the cache path rather than hard coding it.
* Enhance : Test foodcritic rules using Travis CI.

## v0.0.2:

* Enhance : Include the `chef_handler::default` recipe from the `graphite_handler::default` recipe to ensure
            the required directory has been created.

## v0.0.1:

* Initial release.
