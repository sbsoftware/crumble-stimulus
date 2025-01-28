require "./crumble/stimulus_controllers"
require "./ext/**"

module Crumble::Stimulus
  extend self

  def stimulus_url
    "https://unpkg.com/@hotwired/stimulus/dist/stimulus.js"
  end
end
