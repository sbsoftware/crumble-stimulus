require "js"
require "stimulus"
require "crumble"

module Crumble
  class StimulusControllers < JS::Module
    js_import Application, Controller, from: Crumble::Stimulus.stimulus_url

    def self.add_controller(klass)
      js_class klass
    end

    def_to_js do
      window.Stimulus = Application.start._call

      {% for ctrl_klass in ::Stimulus::Controller.all_subclasses %}
        Stimulus.register({{ctrl_klass}}.controller_name.to_js_ref, {{ctrl_klass}}.to_js_ref)
      {% end %}
    end

    macro finished
      @@asset_file = JavascriptFile.new("/assets/stimulus_controllers.js", self.to_js)
    end

    def self.to_html_attrs(_tag, attrs)
      attrs["type"] = "module"
      attrs["src"] = @@asset_file.uri_path
    end

    ToHtml.class_template do
      script self
    end
  end
end
