## v0.0.12:

* Enhance : Allow custom metrics insertion. Submitted by Grégoire Seux
* Enhance : Allow the user to specify the gem version for graphite gem. Submitted by Olivier Bazoud.

## v0.0.10:

* Enhance : Do not specify unix permissions on a windows host.
* Bug     : Gracefully handle the presence of a 'system_packages' node attribute without the contained attributes
            such as 'installed' etc. This will happen when the cookbook is present as a dependency but does not
            appear in the run list.
* Bug     : Correctly handle the scenario where the chef run has failed early enough that the run_status has not
            been fully defined. Submitted by Scott Smith.

## v0.0.8:

* Enhance : Support Ruby 1.8 by including rubygems. Submitted by Julian Dunn.

## v0.0.6:

* Enhance : Include ohai-system_packages plugin statistics if available. Submitted by Lew Goettner.
* Change  : Change the default prefix to have chef at the front. Submitted by Lew Goettner.
* Change  : Change the default prefix to support empty hostname and downcase the hostname.

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
