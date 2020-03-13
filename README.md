# ProductDiscovery

## Setup & Open the Project

You'll need to have [ProductDiscovery](https://github.com/haodv159/ProductDiscovery/tree/develop) installed
in order to pull the ProductDiscovery dependency.

Then you need to run "pod install" to install the necessary libraries.

### Structural design pattern

* MVVM
* RxSwift

MVVM in conjunction with RxSwift helps manage and separate functions more easily, avoiding the bloat of view controller.

### Explain approach

1. Handle with response
* Because the amount of data the server returns is a lot, there is a lot of data that is not needed for this problem. 
So to save time, I proceed to parse the JSON response manually (only parse the problem data needed).

2. Product Listing screen
* Display the list of products returned from the server.
* Display the basic information, need to calculate the percentage discount on sale price.
* Allow make pull requests and load more.
* Click on cell to move to the details screen.

3. Product Detail screen
* Display a slide image of the product.
* Display the basic information, need to calculate the percentage discount on sale price.
* Display specifications and list of related products.
* Calculate quantity and sale price to add to cart.

### Note

The display of data for items is not really accurate, it needs more information to map more accurately.
