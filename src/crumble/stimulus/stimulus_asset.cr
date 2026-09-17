require "crumble"

module Crumble::Stimulus
  extend self

  StimulusAsset = JavascriptFile.register(
    "assets/stimulus-3.2.2.js",
    "#{__DIR__}/../../../vendor/stimulus/3.2.2/stimulus.js",
  )

  def stimulus_url
    StimulusAsset.uri_path
  end
end
