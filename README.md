# crumble-stimulus

Seamless integration of [stimulus.cr](https://github.com/sbsoftware/stimulus.cr) into [crumble](https://github.com/sbsoftware/crumble), providing a JS module that includes all your `Stimulus::Controller`s that is automatically added to your layout template.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     crumble-stimulus:
       github: sbsoftware/crumble-stimulus
   ```

2. Run `shards install`

## Usage

```crystal
# make sure this comes before you require any controllers you want to include,
# otherwise they'll be missing
require "crumble-stimulus"
# or wherever your Stimulus controllers are
require "./stimulus_controllers/*"
```

The `Crumble::StimulusControllers` script is automatically added to any template inheriting from the generic `ToHtml::Layout`. Stimulus is served by the application as a fingerprinted asset, so pages do not depend on a third-party request for the runtime.

### Vendored Stimulus runtime

The shard vendors the `stimulus.js` ES module from `@hotwired/stimulus` 3.2.2. The upstream MIT license is included at `vendor/stimulus/3.2.2/MIT-LICENSE`, and its notice is preserved in the served JavaScript.

To upgrade Stimulus, replace both vendored files from the same pinned upstream release, preserve the complete license notice at the start of the JavaScript file, update the version in the registered asset path and this documentation, and run the full spec suite.

### Custom Layout

If you don't use a layout based on `ToHtml::Layout`, you'll have to include the `Crumble::StimulusControllers` script manually:

```crystal
html do
  head do
    # [...]
    Crumble::StimulusControllers
    # [...]
  end
end
```
