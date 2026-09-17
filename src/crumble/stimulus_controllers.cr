require "js"
require "stimulus"
require "crumble"
require "./stimulus/stimulus_asset"

module Crumble
  class StimulusControllers < JS::Module
    js_import Application, Controller, from: Crumble::Stimulus.stimulus_url

    js_fragment do
      window.Stimulus = Application.start._call
    end

    macro add_controller(klass)
      class ::Crumble::StimulusControllers
        js_class {{klass}}

        js_fragment do
          Stimulus.register({{klass}}.controller_name.to_js_ref, {{klass}}.to_js_ref)
        end
      end
    end

    def self.asset_file
      @@asset_file ||= JavascriptFile.new("/assets/stimulus_controllers.js", self.to_js)
    end

    def self.to_html_attrs(_tag, attrs)
      attrs["type"] = "module"
      attrs["src"] = asset_file.uri_path
    end

    ToHtml.class_template do
      script self
    end

    def self.uri_path
      asset_file.uri_path
    end
  end
end
