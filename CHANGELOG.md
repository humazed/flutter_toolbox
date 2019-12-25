##  4.3.3

* Updated provider: ^4.0.0.

##  4.3.2

* Make the hero animation in NetImage opt in 
  as it was causing crashes when there is multiple image with the same url in the same page.

##  4.3.1

* Improve hero in NetImage.

##  4.3.0

* Added swiping support to the image.

##  4.2.1

* Expose toolbox_config.dart.

##  4.2.0

* Added global config to the app.
* Added config for noItemsFoundWidget.
* make the SearchItemPicker hide the empty text items.

##  4.1.0

* added toolbox_app.dart.
* updated toast.
* fixed crash with connection_status_bar.dart

##  4.0.0

* Updated deps to support flutter the stable 1.12.13.

##  3.6.1

* Added ru localization.

##  3.6.0

* Added noItemsFoundBuilder noItemsFoundWidget to PaginatedListView and to PaginatedSliverList.

##  3.5.2

* Use the default MultipartFile.fromPath instead of implementing it myself.
* updated deps

##  3.5.1

* improve `multiFile` and handle nulls in it.

##  3.5.0+1

* updated deps.

##  3.5.0

* make netImage not zoomable.
* updated deps.

##  3.4.1

* Make toolkit compatible with flutter master.

##  3.4.0

* Added onUnknownError to http.dart.
* updated deps

##  3.3.1

* make the background color black for full image.

##  3.3.0

* added Full screen to netImage
 
##  3.2.2

* added suffixIcon prefixIcon to SearchItemPicker
 
 ##  3.2.1

* expose SearchItemPicker 

##  3.2.0

* added SearchItemPicker
* added localization to connection_status_bar.dart

##  3.2.0

* Ignore touch events on connectionStatusBar.

##  3.1.0

* Added connectionStatusBar.

##  3.0.0

* added refresh indicator to paginated_list_view.dart.

##  2.10.2

* fix a bug in http.

##  2.10.1

* Improve error methods for http.

##  2.10.0

* added pushAndRemoveUntil to navigator.
* added the class name as the route name so it can be looked up later.

##  2.9.6

* improve loadingBuilder logging.

##  2.9.5

* improve http logging.

##  2.9.4

* improve http logging.

##  2.9.3

* improve http logging.

##  2.9.2

* update chopper2.

##  2.9.1

* Fix errors regarding chopper2.

##  2.9.0

* Depend on my chopper2.

##  2.8.0

* Depend on my fork of chopper.

##  2.7.5

* Make future required in loading builder.

##  2.7.4

* Print the error in PaginateListView.

##  2.7.3

* Improve error handling.

##  2.7.2

* Added showServerErrorMessage to safeRest.

##  2.7.1

* Updated gradle and kotlin plugin.

##  2.7.0

* Added PaginateSliverList.

##  2.6.0

* Fix ios build issues.

##  2.5.1

* Added pushReplacement to navigation.dart.

##  2.5.0

* Added materialRoute to navigation.dart.

##  2.4.0

* Update deps.

##  2.3.1

* Added localization to time and date picker field.

##  2.3.0

* added navigation utils and push method inside it.

##  2.2.1

* check if onError is null in safeRequest.

##  2.2.0

* added await to onSuccess to behave predictably.
* added on error. to safeRequest.

##  2.1.0

* make onSuccess optional in safeRequest.

##  2.0.0

* handle the error in chopper 3.0.0.

##  1.7.0

* updated chopper to 3.0.0.

## 1.6.4+1

* Added defaults to TabRoundedLineIndicator.

## 1.6.4

* Added TabRoundedLineIndicator.

## 1.6.3+2

* revert changes in 1.6.3 and 1.6.3+1 wait for improvement in another time.

## 1.6.3+1

* try making loading builder logging more useful.

## 1.6.3

* make loading builder logging more useful.

## 1.6.2

* fix a bug in PaginateListView.

## 1.6.1

* added mutable to PaginateListView.

## 1.6.0+1

* added pageLoadController to PaginateListView.
* fixed comment in LoadingBuilder.

## 1.6.0

* removed drawer as it's better to be in the app.

## 1.5.0

* added paginate_list_view to flutter_toolbox
* change src from flutter_utils to flutter_toolbox

## 1.4.0

* added PaginateListView

## 1.3.3

* rename net_image to NetImage.

## 1.3.2

* updated cached_network_image.
* added flutter_cache_manager to make pub happy.

## 1.3.1

* Wrap the progressPar of the netImage into center

## 1.3.0

* Added NetImage

## 1.2.0

* change `d()` to take object not just a string to totally replace `print()`.

## 1.1.0

* No changes just update to indicate breaking change.

## 1.0.3

* Remove common_button and common_text_field.

## 1.0.2

* Export all important files.

## 1.0.1

* Fix gradle build problems and update kotlin and gradle versions.

## 1.0.0

* initial release.
