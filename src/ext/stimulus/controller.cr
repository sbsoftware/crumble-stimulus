require "stimulus"
require "../../crumble/stimulus_controllers"

class Stimulus::Controller
  macro inherited
    Crumble::StimulusControllers.add_controller({{@type}})
  end
end
