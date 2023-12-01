# crumble-stimulus

Seamless integration of [stimulus.cr](https://github.com/sbsoftware/stimulus.cr) into [crumble](https://github.com/sbsoftware/crumble), providing a JS module that automatically includes all your `Stimulus::Controller`s and can be easily added to your template.

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
# or wherever your Stimulus controllers are
require "./stimulus_controllers/*"
# make sure this comes after you required all controllers you want to include, otherwise they'll be missing
require "crumble-stimulus"
```

In your template:

```crystal
html do
  head do
    # [...]
    script Crumble::StimulusControllers
    # [...]
  end
end
```

And that's it!
